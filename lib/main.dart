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
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Menu')),
      body: Column(
        children: [
          ListTile(
            leading: Icon(_isExpanded ? Icons.close : Icons.menu),
            title: const Text('DANH SÁCH CÁC BÀI'),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('MyHome'),
                    onTap: () => Navigator.pushNamed(context, '/bai1'),
                  ),
                  ListTile(
                    title: const Text('MyClassroom'),
                    onTap: () => Navigator.pushNamed(context, '/bai2'),
                  ),
                  ListTile(
                    title: const Text('MyGuide'),
                    onTap: () => Navigator.pushNamed(context, '/bai3'),
                  ),
                  ListTile(
                    title: const Text('MyHotel'),
                    onTap: () => Navigator.pushNamed(context, '/bai4'),
                  ),
                  ListTile(
                    title: const Text('ChangeColorApp'),
                    onTap: () => Navigator.pushNamed(context, '/bai5'),
                  ),
                  ListTile(
                    title: const Text('CounterApp'),
                    onTap: () => Navigator.pushNamed(context, '/bai6'),
                  ),
                  ListTile(
                    title: const Text('CountDownTimer'),
                    onTap: () => Navigator.pushNamed(context, '/bai7'),
                  ),
                  ListTile(
                    title: const Text('FormLogin'),
                    onTap: () => Navigator.pushNamed(context, '/bai8'),
                  ),
                  ListTile(
                    title: const Text('FormSigin'),
                    onTap: () => Navigator.pushNamed(context, '/bai9'),
                  ),
                  ListTile(
                    title: const Text('Store'),
                    onTap: () => Navigator.pushNamed(context, '/bai10'),
                  ),
                  ListTile(
                    title: const Text('News'),
                    onTap: () => Navigator.pushNamed(context, '/bai11'),
                  ),
                  ListTile(
                    title: const Text('Login Profile API'),
                    onTap: () => Navigator.pushNamed(context, '/bai12'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}









