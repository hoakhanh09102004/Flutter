import 'api.dart';
import 'package:flutter/material.dart';
import 'model/product.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  @override
  void initState() {
    super.initState();
    test_API.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 125, 179, 237),
        title: Row(
          children: [
            Text(
              'HKhanh shop',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(), // đẩy các icon ra phía bên phải
            IconButton(
              onPressed: () {
                print("Tìm kiếm sản phẩm");
              },
              icon: const Icon(Icons.search, color: Colors.white, size: 24),
            ),
            IconButton(
              onPressed: () {
                print("Giỏ hàng");
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),

      body: FutureBuilder<List<Product>>(
        future: test_API.getAllProduct(),
        builder: (context, snap) {
          // Loading UI
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Khi lỗi
          if (snap.hasError) {
            return const Center(child: Text("Lỗi tải dữ liệu"));
          }
          // Không có dữ liệu
          if (!snap.hasData || snap.data!.isEmpty) {
            return const Center(child: Text("Không có sản phẩm"));
          }
          // Hiển thị danh sách
          return buildList(snap.data!);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 125, 179, 237),
        child: SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  print("Trang chủ");
                },
                icon: const Icon(Icons.home, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  print("Danh mục");
                },
                icon: const Icon(Icons.menu, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  print("Yêu thích");
                },
                icon: const Icon(Icons.favorite, color: Colors.white),
                ),
              IconButton(
                onPressed: () {
                  print("Tài khoản");
                },
                icon: const Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(List<Product> ls) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 sản phẩm mỗi hàng
        crossAxisSpacing: 8, // khoảng cách ngang giữa các item
        mainAxisSpacing: 8, // khoảng cách dọc giữa các item
        childAspectRatio: 0.7, // tỷ lệ chiều rộng/chiều cao của mỗi item
      ),
      itemCount: ls.length,
      itemBuilder: (context, i) {
        return buildItem(ls[i]);
      },
    );
  }

  Widget buildItem(Product p) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  p.image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                p.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                "\$${p.price}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Loại: ${p.category}",
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    "${p.rating.rate} (${p.rating.count} lượt mua)",
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                p.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              ],
          ),
        ),
      ),
    );
  }
}