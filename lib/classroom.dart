import 'package:flutter/material.dart';
import 'dart:math';



class MyClassroom extends StatelessWidget {
  MyClassroom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom'),
        backgroundColor: const Color.fromARGB(255, 170, 196, 243),
      ),
      body: SafeArea(child: myBody()),
    );
  }

  Widget myBody() {
    return ListView( //thay the cho column va row khi vuot ra khoi man hinh
      scrollDirection: Axis.vertical,
      children: List.generate(6, (index) => item())
      ,
    );
  }
  final List<String> bgImages = [
    'https://images.unsplash.com/photo-1503264116251-35a269479413',
    'https://images.unsplash.com/photo-1519389950473-47ba0277781c',
    'https://images.unsplash.com/photo-1522202176988-66273c2fd55f',
    'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1',
    'https://images.unsplash.com/photo-1498050108023-c5249f4df085',
    'https://images.unsplash.com/photo-1506765515384-028b60a970df',
  ];
  String randomImage() {
    final Random random = Random();
    return bgImages[random.nextInt(bgImages.length)];
  }
  Widget item() { 
    String title = "Lập trình Flutter";
    String subtitle = "TIN1234";
    String siSo="50 học viên";
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(randomImage()),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            BlendMode.darken,
          ),
        ),
      ),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: const TextStyle(color: Colors.white),),
                  Text(subtitle,style: const TextStyle(color: Colors.white),)
               ],
              ),
              Text(siSo,style: const TextStyle(color: Colors.white),)
            ],
          ),
          IconButton(onPressed: (){}, color: Colors.white, icon: const Icon(Icons.more_horiz),)
        ],
      ),
    );
  }
}