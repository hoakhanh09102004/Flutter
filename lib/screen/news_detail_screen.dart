import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article.dart';

class NewsDetailScreen extends StatelessWidget {
  final Article article;
  
  const NewsDetailScreen({super.key, required this.article});

  // Hàm mở link bài viết gốc trong trình duyệt (Chức năng chính)
  Future<void> _launchURL(String url, BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Hiển thị snackbar nếu không mở được
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể mở link: $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết Bài viết'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Hiển thị hình ảnh
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  article.urlToImage!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Hiển thị tiêu đề
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Nguồn và mô tả
            Text(
              'Nguồn: ${article.sourceName ?? 'Không rõ'}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
            ),
            const Divider(height: 30),

            // Hiển thị nội dung chi tiết
            Text(
              article.content ?? article.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Nút mở link gốc trong trình duyệt
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _launchURL(article.url, context),
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Đọc Bài Viết Gốc', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}