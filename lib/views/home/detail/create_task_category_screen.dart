import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task_category.dart';
import 'package:todo_app/viewmodel/task_category_viewmodel.dart';

class CreateTaskCategoryScreen extends StatefulWidget {
  const CreateTaskCategoryScreen({super.key});

  @override
  State<CreateTaskCategoryScreen> createState() =>
      _CreateTaskCategoryScreenState();
}

class _CreateTaskCategoryScreenState extends State<CreateTaskCategoryScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCategoryViewmodel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Category'),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Category Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description (Optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            final prefs = await SharedPreferences.getInstance();
                            if (_formKey.currentState!.validate()) {
                              try {
                                await viewModel.createTaskCategory(TaskCategory(
                                  id: 0, // ID sẽ được tạo tự động bởi database
                                  name: nameController.text,
                                  description: descriptionController.text,
                                  userId: prefs.getInt('userId'),
                                ));
                                // Hiển thị thông báo thành công
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Category created successfully'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } catch (e) {
                                // Hiển thị thông báo lỗi
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Error creating category: ${e.toString()}'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text('Create Category'),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
