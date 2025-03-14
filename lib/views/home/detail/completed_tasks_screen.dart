import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';
import 'package:todo_app/views/home/detail/task_detail_screen.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: Consumer<TaskViewmodel>(
        builder: (context, taskViewmodel, child) {
          final completedTasks = taskViewmodel.tasks
              .where((task) => task.status == 'completed')
              .toList();

          if (completedTasks.isEmpty) {
            return const Center(
              child: Text(
                'No completed tasks',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: completedTasks.length,
            itemBuilder: (context, index) {
              final task = completedTasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text('Due: ${task.dueDate}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailScreen(task: task),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
