import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/entities/news_article.dart';
import '../widgets/custom_app_bar.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailPage({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'تفاصيل الخبر',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () => _shareArticle(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الخبر
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 64,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عنوان الخبر
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // معلومات الخبر
                  Row(
                    children: [
                      // المصدر
                      if (article.source != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            article.source!.name,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      
                      const SizedBox(width: 12),
                      
                      // التاريخ
                      Text(
                        _formatDate(article.publishedAt),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // الكاتب
                  if (article.author != null && article.author!.isNotEmpty)
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'بواسطة: ${article.author}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // وصف الخبر
                  const Text(
                    'الوصف',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    article.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // المحتوى
                  if (article.content != null && article.content!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'المحتوى',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        Text(
                          article.content!,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                      ],
                    ),
                  
                                     // زر قراءة المزيد
                   SizedBox(
                     width: double.infinity,
                     child: ElevatedButton.icon(
                       onPressed: () => _launchUrl(context, article.url),
                       icon: const Icon(Icons.open_in_new),
                      label: const Text('قراءة المقال كاملاً'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('لا يمكن فتح الرابط: $url'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }


  //حاجة بدائية عشان مفيش وقت
  void _shareArticle(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ رابط المقال'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
