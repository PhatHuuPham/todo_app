import 'package:flutter/material.dart';
import 'package:todo_app/views/home/calendar_screen.dart';
import 'package:todo_app/views/home/detail/create_task_screen.dart';
import 'package:todo_app/views/home/important_screen.dart';
import 'package:todo_app/views/home/task_screen.dart';
import 'package:todo_app/views/home/user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  // Danh sách các màn hình
  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Khởi tạo PageController
  }

  @override
  void dispose() {
    _pageController.dispose(); // Hủy PageController khi không dùng nữa
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          TaskScreen(),
          ImportantScreen(),
          CalendarScreen(),
          UserScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateTaskScreen()));
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(
            index,
          );
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: 'Task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_outline), label: 'Important'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'User'),
        ],
      ),
    );
  }
}
