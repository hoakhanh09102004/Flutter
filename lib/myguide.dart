import 'package:flutter/material.dart';

class Myguide extends StatelessWidget {
  const Myguide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place'),
        backgroundColor: const Color.fromARGB(255, 213, 209, 209),
      ),
      body: SafeArea(child: myBody()) ,
    );
  }
  Widget myBody() {
  return SingleChildScrollView( // 👈 bọc toàn bộ để cuộn
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        block1(),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: block2(),
        ),
        const SizedBox(height: 10),
        block3(),
        block4(), // ✅ block4 nằm trong vùng cuộn
        const SizedBox(height: 30),
      ],
    ),
  );
  }
  Widget block1(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.notifications)),
        SizedBox(width: 20),
        IconButton(onPressed: (){}, icon: const Icon(Icons.extension)),
        SizedBox(width: 15),
      ],
    );
  }
  Widget block2() {
  return RichText(
    textAlign: TextAlign.left,
      text: const TextSpan(
        children: [
          TextSpan(
            text: "Welcome,\n",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: "Charlie",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
          ),
        ],
        ),
    );
  }
  Widget block3(){
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search), // 🔍 icon bên trái
        hintText: "Search", // gợi ý khi ô trống
        border: OutlineInputBorder( // viền bao quanh
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder( // viền khi được chọn
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    ),
  ); 
  }
  Widget block4() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
        child: Text(
          "Saved Places",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildImage('assets/images/Picture1.png'),
            _buildImage('assets/images/Picture2.png'),
            _buildImage('assets/images/Picture3.png'),
            _buildImage('assets/images/Picture4.png'),
          ],
        ),
      ),
    ],
  );
}

Widget _buildImage(String path) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      color: Colors.white, // ✅ nền trắng để không bị ám xám
      child: Image.asset(
        path,
        fit: BoxFit.cover, // ✅ ảnh đầy khung, không bể
      ),
    ),
  );
}

}