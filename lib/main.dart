// main.dart
import 'package:flutter_application_1/screen/news_list_scren.dart';

import 'login_API.dart';
import 'myproduct.dart';

//import 'screen/news_detail_screen.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'classroom.dart';
import 'myguide.dart';
import 'myhotel.dart';
import 'change_color_app.dart';
import 'counter_app.dart';
import 'countdown_timer.dart';
import 'login.dart';
import 'sigin.dart';
// ignore: unused_import
import 'api.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ALL',
      home: const HomeScreen(),
      routes: {
        '/bai1': (context) => const Myhome(),
        '/bai2': (context) => MyClassroom(),
        '/bai3': (context) => const Myguide(),
        '/bai4': (context) => const MyHotel(),
        '/bai5': (context) => const ChangeColorApp(),
        '/bai6': (context) => const CounterApp(),
        '/bai7': (context) => const CountdownTimer(),
        '/bai8': (context) => const LoginForm(),
        '/bai9': (context) => const SiginScreen(),
        '/bai10': (context) => const MyProduct(),
        '/bai11': (context) => const NewsListScreen(),
        '/bai12': (context) =>  LoginPage(),
  
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isExpanded = false;//dong mo menu

  @override
  Widget build(BuildContext context) {//lay kich thuoc man hinh
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(//chồng widget
        children: [
          /// BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffe3f2fd),
                  Color(0xfffce4ec),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// 📦 CONTENT
          Column(
            children: [
              SafeArea(
                child: ListTile(
                  leading: Icon(
                    _isExpanded ? Icons.close : Icons.menu,
                    size: 28,
                  ),
                  title: const Text(
                    'DANH SÁCH CÁC BÀI',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ),

              Expanded(
                child: Row(
                  children: [
                    ///  MENU BÊN TRÁI
                    if (_isExpanded)
                      Container(
                        width: width * 0.5,
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 4),
                            )
                          ],
                        ),
                        child: ListView(
                          padding: const EdgeInsets.all(8),
                          children: [
                            _menuItem('Bài 1: MyHome', '/bai1'),
                            _menuItem('Bài 2: MyClassroom', '/bai2'),
                            _menuItem('Bài 3: MyGuide', '/bai3'),
                            _menuItem('Bài 4: MyHotel', '/bai4'),
                            _menuItem('Bài 5: ChangeColorApp', '/bai5'),
                            _menuItem('Bài 6: CounterApp', '/bai6'),
                            _menuItem('Bài 7: CountDownTimer', '/bai7'),
                            _menuItem('Bài 8: FormLogin', '/bai8'),
                            _menuItem('Bài 9: FormSigin', '/bai9'),
                            _menuItem('Bài 10: Store', '/bai10'),
                            _menuItem('Bài 11: News', '/bai11'),
                            _menuItem('Bài 12: Login Profile API', '/bai12'),
                          ],
                        ),
                      ),

                    /// 👉 PHẦN BÊN PHẢI (có thể để trống / sau này thêm nội dung)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Lập trình ứng dụng cho thiết bị di động',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 210, 25, 25),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Nhóm 5',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 210, 25, 25),
                                ),
                              ),
                            ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 Widget menu item
  Widget _menuItem(String title, String route) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}










