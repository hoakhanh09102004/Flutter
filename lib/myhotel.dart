import 'package:flutter/material.dart';

class MyHotel extends StatelessWidget {
  const MyHotel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: const Text(
          'Xung quanh vị trí hiện tại\n23 thg 10 – 24 thg 10',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
        toolbarHeight: 70,
      ),
      body: Column(
        children: [
          // Thanh bộ lọc
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _FilterButton(icon: Icons.sort, label: 'Sắp xếp'),
                _FilterButton(icon: Icons.filter_alt_outlined, label: 'Lọc'),
                _FilterButton(icon: Icons.map_outlined, label: 'Bản đồ'),
              ],
            ),
          ),
          const Divider(height: 1),

          // Danh sách khách sạn
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: const [
                HotelCard(
                  imageUrl:
                      'https://plus.unsplash.com/premium_photo-1682913629540-3857602b540c?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  title: 'aNhill Boutique',
                  rating: 9.5,
                  reviews: 95,
                  location: 'Huế · Cách bạn 0,6km',
                  room: '1 suite riêng tư · 1 giường',
                  price: 'US\$109',
                ),
                HotelCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1561501900-3701fa6a0864?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  title: 'An Nam Hue Boutique',
                  rating: 9.2,
                  reviews: 34,
                  location: 'Cư Chính · Cách bạn 0,9km',
                  room: '1 phòng khách sạn · 1 giường',
                  price: 'US\$20',
                ),
                HotelCard(
                  imageUrl:
                      'https://images.unsplash.com/photo-1571896349842-33c89424de2d?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  title: 'Huế Jade Hill Villa',
                  rating: 8.0,
                  reviews: 18,
                  location: 'Cư Chính · Cách bạn 1,3km',
                  room: '1 biệt thự nguyên căn – 1.000 m² · 3 phòng ngủ',
                  price: 'US\$285',
                  extra:
                      'Không cần thanh toán trước\nChỉ còn 1 căn với giá này trên Booking.com',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Nút bộ lọc
class _FilterButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FilterButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.black54),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// Card hiển thị thông tin khách sạn
class HotelCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final int reviews;
  final String location;
  final String room;
  final String price;
  final String? extra;

  const HotelCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.room,
    required this.price,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Bao bữa sáng',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.favorite_border, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(rating.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                    const SizedBox(width: 6),
                    Text('Xuất sắc · $reviews đánh giá',
                        style: const TextStyle(color: Colors.black54, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(location, style: const TextStyle(color: Colors.black87, fontSize: 13)),
                Text(room, style: const TextStyle(color: Colors.black87, fontSize: 13)),
                const SizedBox(height: 4),
                Text(price,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                const Text('Đã bao gồm thuế và phí',
                    style: TextStyle(color: Colors.black54, fontSize: 12)),
                if (extra != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(extra!,
                        style: const TextStyle(color: Colors.red, fontSize: 12)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}