import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/views/not_found_screen.dart';
import 'package:todo_app/views/home/calendar_screen.dart';
import 'package:todo_app/views/home/detail/create_task_screen.dart';
import 'package:todo_app/views/home/important_screen.dart';
import 'package:todo_app/views/home/task_screen.dart';
import 'package:todo_app/views/home/user_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/task', // Màn hình mặc định khi mở app
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      routes: [
        GoRoute(
          path: '/task',
          builder: (context, state) => const TaskScreen(),
        ),
        GoRoute(
          path: '/important',
          builder: (context, state) => const ImportantScreen(),
        ),
        GoRoute(
          path: '/calendar',
          builder: (context, state) => const CalendarScreen(),
        ),
        GoRoute(
          path: '/user',
          builder: (context, state) => const UserScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/create-task',
      parentNavigatorKey: _rootNavigatorKey, // Đảm bảo mở ngoài ShellRoute
      builder: (context, state) => const CreateTaskScreen(),
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
