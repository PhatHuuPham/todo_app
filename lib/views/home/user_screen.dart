import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name project',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Email',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Khoảng cách giữa 2 hàng
          Center(
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
                      onPressed: () {},
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
                        "Đăng nhập", // Ví dụ chữ dài
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
