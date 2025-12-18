import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_API.dart';

class ProfilePage extends StatefulWidget {
  final String token;

  ProfilePage({required this.token});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? user;
  final AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  loadProfile() async {
    final data = await auth.getProfile(widget.token);

    if (data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Không thể tải hồ sơ. Token không hợp lệ!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
      return;
    }

    setState(() => user = data);
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xfff7ecf7),
      appBar: AppBar(
        title: Text("Hồ sơ cá nhân"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user!["image"] != null
                  ? NetworkImage(user!["image"])
                  : AssetImage("assets/default.png") as ImageProvider,
            ),
            SizedBox(height: 16),

            Text(
              "${user!["firstName"]} ${user!["lastName"]}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Text("@${user!["username"]}",
                style: TextStyle(fontSize: 16, color: Colors.grey)),

            SizedBox(height: 10),

            Text("Email: ${user!["email"]}"),

            SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
              icon: Icon(Icons.logout),
              label: Text("Đăng xuất"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}