import 'package:flutter/material.dart';
import 'dart:math';

class ChangeColorApp extends StatefulWidget {
  const ChangeColorApp({super.key});

  @override
  State<ChangeColorApp> createState() => _ChangeColorAppState();
}

class _ChangeColorAppState extends State<ChangeColorApp> {
  Color bgColor = Colors.pink;

  final List<Color> lsColor = [
    Colors.red,
    Colors.pink,
    Colors.cyan,
    Colors.teal,
    Colors.yellow,
    Colors.blue,
  ];

  final Map<Color, String> colorNames = {
    Colors.red: "Đỏ",
    Colors.pink: "Hồng",
    Colors.cyan: "Xanh ngọc",
    Colors.teal: "Xanh lơ",
    Colors.yellow: "Vàng",
    Colors.blue: "Xanh dương",
  };

  void _changeRandomColor() {
    setState(() {
      var random = Random();
      bgColor = lsColor[random.nextInt(lsColor.length)];
    });
  }

  void _resetColor() {
    setState(() {
      bgColor = Colors.pink;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Color App"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: bgColor,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Color",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Hàng thứ 2: tên màu nền hiện tại (tiếng Việt)
            Text(
              colorNames[bgColor] ?? "Không rõ",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 40),

            // Hàng thứ 3: 2 nút nằm ngang
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _changeRandomColor,
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text("Đổi màu"),
                ),
                ElevatedButton(
                  onPressed: _resetColor,
                  style: ElevatedButton.styleFrom(
                    //backgroundColor: Colors.grey[700],
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text("Đặt lại"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}