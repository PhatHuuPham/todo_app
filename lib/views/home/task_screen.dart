import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';
import 'package:todo_app/views/home/detail/task_detail_screen.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSameDate(DateTime date1, DateTime date2) {
      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    }

    return ChangeNotifierProvider(
      create: (context) => TaskViewmodel(),
      child: Consumer<TaskViewmodel>(builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks'),
          ),
          body: ListView.builder(
            itemCount: value.tasks.length,
            itemBuilder: (context, index) {
              final task = value.tasks[index];
              // if (task.dueDate != null) {
              //   final dueDate = task.dueDate!.toIso8601String();
              //   DateTime nowLocal = DateTime.now();
              //   print(DateTime.now());
              // }
              // if (true) {
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
                      builder: (context) => TaskDetailScreen(task: task),
                    ),
                  );
                },
                trailing: Checkbox(
                    value: task.status == 'completed',
                    onChanged: (bool? newValue) {
                      if (newValue == true) {
                        value.updateTaskStatus(task.id, 'completed');
                      } else {
                        value.updateTaskStatus(task.id, 'in_progress');
                      }
                    }),
              );
              // }
              // return Container();
            },
          ),
        );
      }),
    );
  }
}
