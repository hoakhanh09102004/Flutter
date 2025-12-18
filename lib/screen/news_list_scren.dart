import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import 'news_detail_screen.dart'; // Đảm bảo đường dẫn này đúng

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  // Hàm gọi API
  Future<List<Article>> fetchArticles() async {
    const String apiKey = '1d17b82e8e7f46f8982caa86815034ee'; // <--- THAY THẾ KEY CỦA BẠN TẠI ĐÂY
    // Gọi API lấy tin tức nổi bật của Mỹ
    const String apiUrl = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> articlesJson = data['articles'];
        
        // Chuyển đổi JSON thành Article và lọc bỏ các bài không có ảnh hoặc URL
        return articlesJson
            .map((json) => Article.fromJson(json))
            .where((article) => article.urlToImage != null && article.url.isNotEmpty && article.title != 'Tiêu đề không có') 
            .toList();
      } else {
        throw Exception('Failed to load articles. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi kết nối hoặc xử lý dữ liệu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tin tức Nổi bật'),
      ),
      body: FutureBuilder<List<Article>>(
        future: fetchArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Hiển thị loading
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Lỗi tải dữ liệu: ${snapshot.error}', textAlign: TextAlign.center),
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return _buildArticleItem(context, article);
              },
            );
          }
          return const Center(child: Text('Không tìm thấy tin tức nào.'));
        },
      ),
    );
  }

  // Widget hiển thị từng bài viết (Đã sửa lỗi vị trí, nằm trong class State)
  Widget _buildArticleItem(BuildContext context, Article article) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: ListTile(
        onTap: () {
          // Khi nhấn vào bài viết → chuyển sang màn hình chi tiết
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailScreen(article: article),
            ),
          );
        },
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              article.urlToImage!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                width: 80, 
                height: 80, 
                child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
              ),
            ),
          ),
        title: Text(
          article.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          article.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}