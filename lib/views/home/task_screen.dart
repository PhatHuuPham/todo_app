import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodel/task_category_viewmodel.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';
import 'package:todo_app/views/home/detail/task_detail_screen.dart';
import 'package:todo_app/views/share/task_category_bottom_sheet.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  double containerCategorySize = 100;

  bool isSameDate(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Tasks'), automaticallyImplyLeading: false),
      body: Column(
        children: [
          const Center(
            child: Text(
              'Today',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Consumer<TaskViewmodel>(builder: (context, value, child) {
            final todayTasks = value.tasks
                .where((task) => isSameDate(task.dueDate, DateTime.now()))
                .toList();

            return Expanded(
              child: ListView.builder(
                itemCount: todayTasks.length,
                itemBuilder: (context, index) {
                  final task = todayTasks[index];
                  return ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.status == 'completed'
                            ? TextDecoration.lineThrough
                            : null,
                        decorationThickness: 2,
                      ),
                    ),
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
                        value.updateTaskStatus(task.id,
                            newValue == true ? 'completed' : 'in_progress');
                      },
                    ),
                  );
                },
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Task categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      containerCategorySize =
                          (containerCategorySize == 100) ? 300 : 100;
                    });
                  },
                  icon: Icon(
                    containerCategorySize == 100
                        ? Icons.expand_less
                        : Icons.expand_more,
                  ),
                ),
              ],
            ),
          ),
          Consumer<TaskCategoryViewmodel>(builder: (context, value, child) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: double.infinity,
              height: containerCategorySize,
              child: ListView.builder(
                itemCount: value.taskCategories.length,
                itemBuilder: (context, index) {
                  final taskCategory = value.taskCategories[index];
                  return ListTile(
                    title: Text(taskCategory.name),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return TaskCategoryBottomSheet(
                              taskCategory: taskCategory);
                        },
                      );
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
