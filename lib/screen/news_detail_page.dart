import 'package:flutter/material.dart';
import 'package:news/model/news_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  final Article article;

  const NewsDetailPage({required this.article});

  String _formatDate(String? publishedAt, String? author) {
    if (publishedAt == null) {
      return '';
    }

    // Parse the string to DateTime
    final dateTime = DateTime.parse(publishedAt);

    // Format the DateTime to the desired format
    final formattedDate = DateFormat('MMM d, y').format(dateTime);

    // Combine formatted date with author
    if (author != null && author.trim().isNotEmpty) {
      return 'Published on $formattedDate by $author';
    } else {
      return 'Published on $formattedDate';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Image.network(
              article.urlToImage ?? '',
              width: double.infinity,
              height: 200.0, // Adjust the height as needed
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16.0),
            Text(
              _formatDate(
                article.publishedAt,
                article.author,
              ),
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              article.description,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () async {
                if (await canLaunchUrl(article.url! as Uri)) {
                  await launchUrl(article.url! as Uri);
                } else {
                  throw Exception('Failed to load URL');
                }
              },
              child: Row(
                children: [
                  Icon(Icons.link, color: Colors.blue),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      article.url ?? ' ',
                      style: const TextStyle(
                        color: Colors.blue,
                        // decoration: TextDecoration.underline,
                      ),
                      overflow: TextOverflow.ellipsis,
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
}
