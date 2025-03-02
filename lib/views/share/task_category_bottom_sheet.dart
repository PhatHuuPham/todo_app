import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_category.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';
import 'package:todo_app/views/home/detail/task_detail_screen.dart';

class TaskCategoryBottomSheet extends StatelessWidget {
  final TaskCategory taskCategory;

  const TaskCategoryBottomSheet({super.key, required this.taskCategory});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, ScrollController scrollController) {
        return Container(
            decoration: BoxDecoration(
              color: Colors.green.shade200,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: Text(
                    taskCategory.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Consumer<TaskViewmodel>(builder: (context, value, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: value.tasks.length,
                      itemBuilder: (context, index) {
                        final task = value.tasks[index];
                        if (task.categoryId == taskCategory.id) {
                          return ListTile(
                            title: Text(task.title,
                                style: TextStyle(
                                  decoration: task.status == 'completed'
                                      ? TextDecoration.lineThrough
                                      : null,
                                  decorationThickness: 2,
                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TaskDetailScreen(task: task),
                                ),
                              );
                            },
                            trailing: Checkbox(
                                value: task.status == 'completed',
                                onChanged: (bool? newValue) {
                                  if (newValue == true) {
                                    value.updateTaskStatus(
                                        task.id, 'completed');
                                  } else {
                                    value.updateTaskStatus(
                                        task.id, 'in_progress');
                                  }
                                }),
                          );
                        }
                        return Container();
                      },
                    ),
                  );
                })
              ],
            ));
      },
    );
  }
}
