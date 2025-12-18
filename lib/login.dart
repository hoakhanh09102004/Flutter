import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50, // Màu nền
      appBar: AppBar(
        title: const Text(
          "Form Đăng nhập",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade700, 
        centerTitle: true,
      ),
      body: myBody(),
    );
  }

  Widget myBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            buildInputWithNote(
              controller: _usernameController,
              label: "Tên người dùng",
              icon: Icons.person_outline,
              note: "Vui lòng nhập tên người dùng",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Tên người dùng không được để trống";
                }
                return null;
              },
              isPassword: false,
            ),
            const SizedBox(height: 25),

            buildInputWithNote(
              controller: _passwordController,
              label: "Mật khẩu",
              icon: Icons.lock_outline,
              note: "Vui lòng nhập mật khẩu",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Mật khẩu không được để trống";
                }
                return null;
              },
              isPassword: true,
            ),
            const SizedBox(height: 40),
            
            blockButton(),
          ],
        ),
      ),
    );
  }

  // 🔹 Hàm xây dựng ô nhập liệu
  Widget buildInputWithNote({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String note,
    required String? Function(String?) validator,
    required bool isPassword,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: isPassword ? _obscurePass : false,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black54), 
            labelText: label,
            // 🔴 1. LabelText có màu đỏ
            labelStyle: const TextStyle(color: Colors.red), 
            
            // 🔴 2. Khung viền mặc định: Màu đỏ
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5), 
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            // 🔴 3. Khung viền khi được focus: Màu đỏ
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscurePass ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePass = !_obscurePass;
                      });
                    },
                  )
                : null,
          ),
          validator: validator,
        ),
        const SizedBox(height: 5),
        
        // 🔴 4. Dòng lưu ý (note): Đã là màu đỏ
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            note,
            style: const TextStyle(
              color: Colors.red, 
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget blockButton() {
    return ElevatedButton.icon(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng nhập thành công!')),
          );
        }
      },
      icon: const Icon(Icons.login),
      label: const Text(
        "Đăng nhập",
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade700, 
        foregroundColor: Colors.white,
        minimumSize: const Size(180, 50), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}