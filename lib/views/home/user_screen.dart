import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/services/data/share_prefrence.dart';
import 'package:todo_app/viewmodel/auth_viewmodel.dart';
import 'package:todo_app/viewmodel/task_category_viewmodel.dart';
import 'package:todo_app/viewmodel/task_viewmodel.dart';
import 'package:todo_app/views/auth/login_screen.dart';
import 'package:todo_app/views/home/home.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isLoggedIn = false;
  String? email = '';
  String? userName = '';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final sharePref = Provider.of<Shareprefrence>(context, listen: false);
    bool status = await sharePref.checkLoginStatus();
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoggedIn = status;
      email = prefs.getString('email');
      userName = prefs.getString('userName');
    });
  }

  void _handleLogout() async {
    // ✅ Reset dữ liệu liên quan đến Task sau khi đăng xuất
    Provider.of<TaskViewmodel>(context, listen: false).clearTasks();
    Provider.of<TaskCategoryViewmodel>(context, listen: false).clearTasks();
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    await authViewModel.logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('user');
    await prefs.remove('userId');
    setState(() {
      isLoggedIn = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  void showEmailUsername() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          isLoggedIn
              ? Container(
                  padding: const EdgeInsets.all(20),
                  width: 1000,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30), // Bo góc dưới bên trái
                      bottomRight: Radius.circular(30), // Bo góc dưới bên phải
                    ),
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    // alignment: WrapAlignment.center, // Căn giữa theo chiều ngang
                    // runAlignment: WrapAlignment.center,

                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/user.jpg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName ?? '',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            email ?? '',
                            style: const TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
          const SizedBox(height: 20), // Khoảng cách giữa 2 hàng
          const Center(
            child: Text('Quản lý',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20), // Khoảng cách giữa 2 hàng

          Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Căn giữa theo chiều dọc

              children: [
                Wrap(
                  spacing: 16.0, // Khoảng cách ngang giữa các nút
                  runSpacing:
                      16.0, // Khoảng cách dọc giữa các dòng (nếu xuống dòng)
                  alignment: WrapAlignment.center, // Căn giữa các phần tử
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(
                            130, 70), // Chiều rộng và chiều cao cố định
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // Bo tròn góc
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Thống kê", // Ví dụ chữ dài
                        textAlign: TextAlign.center, // Căn giữa văn bản
                        softWrap: true, // Cho phép xuống dòng
                        overflow:
                            TextOverflow.visible, // Đảm bảo chữ không bị cắt
                        style: TextStyle(
                            fontSize: 16), // Tùy chỉnh kích thước chữ nếu cần
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(
                            130, 70), // Chiều rộng và chiều cao cố định
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // Bo tròn góc
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Task hoàn thành", // Ví dụ chữ dài
                        textAlign: TextAlign.center, // Căn giữa văn bản
                        softWrap: true, // Cho phép xuống dòng
                        overflow:
                            TextOverflow.visible, // Đảm bảo chữ không bị cắt
                        style: TextStyle(
                            fontSize: 16), // Tùy chỉnh kích thước chữ nếu cần
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Khoảng cách giữa 2 hàng
                Wrap(
                  spacing: 16.0, // Khoảng cách ngang giữa các nút
                  runSpacing:
                      16.0, // Khoảng cách dọc giữa các dòng (nếu xuống dòng)
                  alignment: WrapAlignment.center, // Căn giữa các phần tử
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(
                            130, 70), // Chiều rộng và chiều cao cố định
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // Bo tròn góc
                        ),
                      ),
                      onPressed: () async {},
                      child: const Text(
                        "Cài đặt", // Ví dụ chữ dài
                        textAlign: TextAlign.center, // Căn giữa văn bản
                        softWrap: true, // Cho phép xuống dòng
                        overflow:
                            TextOverflow.visible, // Đảm bảo chữ không bị cắt
                        style: TextStyle(
                            fontSize: 16), // Tùy chỉnh kích thước chữ nếu cần
                      ),
                    ),
                    isLoggedIn
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(
                                  130, 70), // Chiều rộng và chiều cao cố định
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Bo tròn góc
                              ),
                            ),
                            onPressed: () {
                              _handleLogout();
                            },
                            child: const Text(
                              "Đăng xuất", // Ví dụ chữ dài
                              textAlign: TextAlign.center, // Căn giữa văn bản
                              softWrap: true, // Cho phép xuống dòng
                              overflow: TextOverflow
                                  .visible, // Đảm bảo chữ không bị cắt
                              style: TextStyle(
                                  fontSize:
                                      16), // Tùy chỉnh kích thước chữ nếu cần
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(
                                  130, 70), // Chiều rộng và chiều cao cố định
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // Bo tròn góc
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Text(
                              "Đăng nhập", // Ví dụ chữ dài
                              textAlign: TextAlign.center, // Căn giữa văn bản
                              softWrap: true, // Cho phép xuống dòng
                              overflow: TextOverflow
                                  .visible, // Đảm bảo chữ không bị cắt
                              style: TextStyle(
                                  fontSize:
                                      16), // Tùy chỉnh kích thước chữ nếu cần
                            ),
                          ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
