import 'package:flutter/material.dart';
import 'package:news/view-model/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:news/model/news_model.dart';
import 'news_detail_page.dart';

class NewsSort extends StatefulWidget {
  final String sortBy;

  const NewsSort({required this.sortBy, Key? key}) : super(key: key);

  @override
  State<NewsSort> createState() => _NewsSortState();
}

class _NewsSortState extends State<NewsSort> {
  @override
  void initState() {
    Provider.of<NewsProvider>(context, listen: false)
        .fetchSortNewsBy(widget.sortBy);
    super.initState();
  }

  String _formatDate(String? publishedAt, String? author) {
    if (publishedAt == null) {
      return '';
    }

    final dateTime = DateTime.parse(publishedAt);
    final formattedDate = DateFormat('MMM d, y').format(dateTime);
    if (author != null && author.trim().isNotEmpty) {
      return '$formattedDate by $author';
    } else {
      return formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('WW News'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sort by: ${widget.sortBy}',
                style: TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Consumer<NewsProvider>(
              builder: (context, newsProvider, child) {
                if (newsProvider.news == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: newsProvider.news?.articles.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    newsProvider.news?.articles
                                        .elementAt(index)
                                        .urlToImage ??
                                        "",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0.0, left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${newsProvider.news?.articles.elementAt(index).title}",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Text(
                                            _formatDate(
                                              newsProvider.news?.articles
                                                  .elementAt(index)
                                                  .publishedAt,
                                              newsProvider.news?.articles
                                                  .elementAt(index)
                                                  .author,
                                            ),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => NewsDetailPage(
                                                  article: Article(
                                                    author: newsProvider.news?.articles.elementAt(index).author ?? ' ',
                                                    content: newsProvider.news?.articles.elementAt(index).content ?? ' ',
                                                    description: newsProvider.news?.articles.elementAt(index).description ?? ' ',
                                                    publishedAt: newsProvider.news?.articles.elementAt(index).publishedAt ?? ' ',
                                                    source: {
                                                      'id': newsProvider.news?.articles.elementAt(index).source['id'] ?? ' ',
                                                      'name': newsProvider.news?.articles.elementAt(index).source['name'] ?? ' ',
                                                    },
                                                    title: newsProvider.news?.articles.elementAt(index).title ?? ' ',
                                                    url: newsProvider.news?.articles.elementAt(index).url ?? ' ',
                                                    urlToImage: newsProvider.news?.articles.elementAt(index).urlToImage ?? ' ',
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.all(8.0),
                                            minimumSize: Size(5.0, 5.0),
                                            backgroundColor: Colors.purple,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(2.0),
                                            ),
                                          ),
                                          child: const Text(
                                            'Read More',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
