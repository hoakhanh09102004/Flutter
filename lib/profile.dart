import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_API.dart';

class ProfilePage extends StatefulWidget {
  final String token;

  const ProfilePage({Key? key, required this.token}) : super(key: key);

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

  Future<void> loadProfile() async {
    final data = await auth.getProfile(widget.token);

    if (!mounted) return;

    if (data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Không thể tải hồ sơ. Token không hợp lệ!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
      return;
    }

    setState(() => user = data);
  }

  Widget infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "$label: $value",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xfff7ecf7),
      appBar: AppBar(
        title: const Text("Hồ sơ cá nhân"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Avatar
            CircleAvatar(
              radius: 55,
              backgroundImage: user!["image"] != null
                  ? NetworkImage(user!["image"])
                  : const AssetImage("assets/default.png") as ImageProvider,
            ),

            const SizedBox(height: 16),

            /// Họ tên
            Text(
              "${user!["firstName"]} ${user!["lastName"]}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "@${user!["username"]}",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            /// Card thông tin chi tiết
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    infoRow(Icons.fingerprint, "ID", user!["id"].toString()),
                    infoRow(Icons.person, "Giới tính", user!["gender"]),
                    infoRow(Icons.cake, "Tuổi", user!["age"].toString()),
                    infoRow(Icons.email, "Email", user!["email"]),
                    infoRow(Icons.phone, "Số điện thoại", user!["phone"]),
                    infoRow(
                      Icons.location_on,
                      "Địa chỉ",
                      "${user!["address"]["city"]}, "
                      "${user!["address"]["state"]}, "
                      "${user!["address"]["country"]}",
                    ),
                    infoRow(
                      Icons.security,
                      "Vai trò",
                      user!["role"] ?? "User",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Logout
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text("Đăng xuất"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
