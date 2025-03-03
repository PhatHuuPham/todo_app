import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';
import 'package:todo_app/views/home/detail/task_detail_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Helper method to check if dates are the same
  bool isSameDate(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  // Add method to get events for a day
  List<dynamic> _getEventsForDay(DateTime day, List<Task> tasks) {
    return tasks
        .where((task) => task.dueDate != null && isSameDate(task.dueDate, day))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TaskViewmodel>(
        builder: (context, taskViewModel, child) {
          return Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                eventLoader: (day) =>
                    _getEventsForDay(day, taskViewModel.tasks),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  markerSize: 8,
                  markersMaxCount: 4,
                  markersAnchor: 0.7,
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: true,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: taskViewModel.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskViewModel.tasks[index];
                    if (isSameDate(task.dueDate, _selectedDay)) {
                      return ListTile(
                        title: Text(task.title),
                        subtitle: Text(task.description),
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
                          onChanged: (bool? value) {
                            taskViewModel.updateTaskStatus(task.id,
                                value == true ? 'completed' : 'in_progress');
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
