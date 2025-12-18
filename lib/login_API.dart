import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'profile.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  final AuthService auth = AuthService();
  bool loading = false;

  login() async {
    setState(() => loading = true);

    final data = await auth.login(userCtrl.text.trim(), passCtrl.text.trim());

    setState(() => loading = false);

    if (data == null || data["token"] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.lastError ?? "Lỗi không xác định")),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ProfilePage(
          token: data["token"],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      backgroundColor: Color(0xfff7ecf7),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Đăng Nhập",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),

              TextField(
                controller: userCtrl,
                decoration: InputDecoration(labelText: "Tên đăng nhập"),
              ),

              TextField(
                controller: passCtrl,
                obscureText: true,
                decoration: InputDecoration(labelText: "Mật khẩu"),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: loading ? null : login,
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("LOGIN"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}