import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodel/task_categoryViewmodel.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';
import 'package:todo_app/views/home/detail/task_detail_screen.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSameDate(DateTime? date1, DateTime? date2) {
      if (date1 == null || date2 == null) {
        return false;
      }
      DateTime localDate1 = date1.toLocal();
      DateTime localDate2 = date2.toLocal();
      return localDate1.year == localDate2.year &&
          localDate1.month == localDate2.month &&
          localDate1.day == localDate2.day;
    }

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TaskViewmodel()),
          ChangeNotifierProvider(create: (context) => TaskCategoryViewmodel())
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tasks'),
          ),
          body: Column(
            children: [
              const Center(
                child: Text(
                  'Today',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Consumer<TaskViewmodel>(builder: (context, value, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: value.tasks.length,
                    itemBuilder: (context, index) {
                      final task = value.tasks[index];
                      final today = DateTime.now();
                      if (isSameDate(task.dueDate, today)) {
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
                                  value.updateTaskStatus(task.id, 'completed');
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
              }),
              const Center(
                child: Text(
                  'Task categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Consumer<TaskCategoryViewmodel>(builder: (context, value, child) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: value.taskCategories.length,
                      itemBuilder: (context, index) {
                        final taskCategory = value.taskCategories[index];
                        return ListTile(
                          title: Text(taskCategory.name),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled:
                                    true, // Quan trọng: Cho phép sheet mở rộng toàn màn hình
                                backgroundColor: Colors
                                    .transparent, // Để không có viền trắng xung quanh
                                builder: (context) {
                                  return DraggableScrollableSheet(
                                      initialChildSize:
                                          0.7, // Hiển thị ban đầu 90% màn hình
                                      minChildSize: 0.3, // Nhỏ nhất 60%
                                      maxChildSize: 0.9, // Lớn nhất 90%
                                      expand:
                                          false, // Quan trọng: Không ép sheet mở rộng toàn bộ màn hình
                                      builder: (context, ScrollController) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade200,
                                            borderRadius:
                                                const BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          child: ListView(
                                            children: const [
                                              ListTile(
                                                title: Text(
                                                  "Start making a presentation",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                subtitle: Text("Today"),
                                                leading: Icon(
                                                    Icons.check_circle_outline),
                                              ),
                                              ListTile(
                                                title: Text("Call John"),
                                                leading: Icon(
                                                    Icons.check_circle_outline),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                });
                          },
                        );
                      }),
                );
              })
            ],
          ),
        ));
  }
}
