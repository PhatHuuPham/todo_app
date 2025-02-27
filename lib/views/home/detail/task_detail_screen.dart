import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late String priority;
  late String status;
  late String dueDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
    priority = widget.task.priority;
    status = widget.task.status;
    dueDate = widget.task.dueDate?.toIso8601String() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskViewmodel(),
      child: Consumer<TaskViewmodel>(
          builder: (context, TaskViewmodel value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Task Detail'),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  value.deleteTask(widget.task.id);
                  Navigator.pop(context);
                },
              ),
            ],
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
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(),
                  ),
                  value: priority,
                  items: ['low', 'medium', 'high'].map((String priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    priority = value!;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  value: status,
                  items: ['pending', 'in_progress', 'completed']
                      .map((String status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status.replaceAll('_', ' ').toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    status = value!;
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: Text(dueDate.isNotEmpty
                      ? 'Due Date: ${DateTime.parse(dueDate).toString().split(' ')[0]}'
                      : 'Set Due Date'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: dueDate.isNotEmpty
                          ? DateTime.parse(dueDate)
                          : DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        dueDate = picked.toIso8601String();
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    value.updateTask(
                      Task(
                        id: widget.task.id,
                        title: titleController.text,
                        description: descriptionController.text,
                        dueDate:
                            dueDate.isNotEmpty ? DateTime.parse(dueDate) : null,
                        priority: priority,
                        status: status,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Update Task'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
