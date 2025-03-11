import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodel/auth_viewmodel.dart';
import 'package:todo_app/viewmodel/task_category_viewmodel.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';
import 'package:todo_app/viewmodel/user_viewmodel.dart';
import 'package:todo_app/views/home/home.dart';
// import 'package:todo_app/routes/app_router.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TaskViewmodel()),
      ChangeNotifierProvider(create: (context) => TaskCategoryViewmodel()),
      ChangeNotifierProvider(create: (context) => UserViewmodel()),
      ChangeNotifierProvider(create: (context) => AuthViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
