import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/viewmodel/task_category_viewmodel.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String taskCategories = '';
  String priority = 'medium';
  String status = 'pending';
  String dueDate = '';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskViewmodel()),
        ChangeNotifierProvider(create: (context) => TaskCategoryViewmodel())
      ],
      child: Consumer<TaskViewmodel>(
          builder: (context, TaskViewmodel value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Task'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Consumer<TaskCategoryViewmodel>(
                    builder: (context, value, child) {
                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    // value: '',
                    items: value.taskCategories.isNotEmpty
                        ? value.taskCategories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category.id.toString(),
                              child: Text(category.name.toUpperCase()),
                            );
                          }).toList()
                        : [],
                    onChanged: (value) {
                      // Handle priority change
                      taskCategories = value!;
                    },
                  );
                }),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(),
                  ),
                  value: 'medium',
                  items: ['low', 'medium', 'high'].map((String priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Handle priority change
                    priority = value!;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  value: 'pending',
                  items: ['pending', 'in_progress', 'completed']
                      .map((String status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status.replaceAll('_', ' ').toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Handle status change
                    status = value!;
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Due Date'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      // Handle date selection
                      dueDate = picked.toIso8601String();
                    }
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Handle task creation
                    value.createTask(
                      Task(
                        id: 0,
                        title: titleController.text,
                        description: descriptionController.text,
                        dueDate:
                            dueDate.isNotEmpty ? DateTime.parse(dueDate) : null,
                        priority: priority,
                        status: status,
                        categoryId: int.parse(taskCategories),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Create Task'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
