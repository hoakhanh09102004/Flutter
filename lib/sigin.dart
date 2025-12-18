import 'package:flutter/material.dart';

class SiginScreen extends StatefulWidget {
  const SiginScreen({super.key});

  @override
  State<SiginScreen> createState() => _loginState();
}

class _loginState extends State<SiginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Form Đăng ký tài khoản",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: myBody(),
    );
  }

  Widget myBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            blockInput(),
            const SizedBox(height: 30),
            blockButton(),
          ],
        ),
      ),
    );
  }

  Widget blockInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInputWithNote(
          controller: _nameController,
          label: "Họ tên",
          icon: Icons.person_outline,
          note: "Vui lòng nhập họ tên",
          validator: (value) {
            if (value!.isEmpty) return "Vui lòng nhập họ tên";
            return null;
          },
        ),
        const SizedBox(height: 15),

        buildInputWithNote(
          controller: _emailController,
          label: "Email",
          icon: Icons.email_outlined,
          note: "Vui lòng nhập email",
          validator: (value) {
            if (value!.isEmpty) return "Vui lòng nhập email";
            if (!value.contains("@")) return "Email không hợp lệ";
            return null;
          },
        ),
        const SizedBox(height: 15),

        buildInputWithNote(
          controller: _passwordController,
          label: "Mật khẩu",
          icon: Icons.lock_outline,
          note: "Vui lòng nhập mật khẩu",
          obscureText: _obscurePass,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePass ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscurePass = !_obscurePass;
              });
            },
          ),
          validator: (value) {
            if (value!.isEmpty) return "Vui lòng nhập mật khẩu";
            if (value.length < 6) return "Mật khẩu phải ít nhất 6 ký tự";
            return null;
          },
        ),
        const SizedBox(height: 15),

        buildInputWithNote(
          controller: _confirmController,
          label: "Xác nhận mật khẩu",
          icon: Icons.lock_outline,
          note: "Vui lòng xác nhận mật khẩu",
          obscureText: _obscureConfirm,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureConfirm ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscureConfirm = !_obscureConfirm;
              });
            },
          ),
          validator: (value) {
            if (value!.isEmpty) return "Vui lòng xác nhận mật khẩu";
            if (value != _passwordController.text) return "Mật khẩu không khớp";
            return null;
          },
        ),
      ],
    );
  }

  // 🔹 Mỗi ô nhập có dòng lưu ý đỏ phía dưới
  Widget buildInputWithNote({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String note,
    bool obscureText = false,
    Widget? suffixIcon,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            labelText: label,
            // 🟥 Khung viền mặc định: Màu đỏ
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1), // Đã thêm borderSide
            ),
            // 🟥 Khung viền khi được focus: Màu đỏ đậm hơn
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            // 🔴 Để LabelText có màu đỏ (nếu bạn vẫn muốn giữ)
            labelStyle: const TextStyle(color: Colors.red), 
            suffixIcon: suffixIcon,
          ),
          validator: validator,
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            note,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget blockButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đăng ký thành công!')),
            );
          }
        },
        icon: const Icon(Icons.person_add_alt_1), 
        label: const Text(
          "Đăng ký",
          style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          minimumSize: const Size(200, 50), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}