import 'package:flutter/material.dart';
import 'package:news/view-model/news_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:news/model/news_model.dart';
import 'news_detail_page.dart';
import 'package:news/screen/news_category.dart';
import 'package:news/screen/sort_news.dart';
import 'package:news/screen/wall_street_journal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    Provider.of<NewsProvider>(context, listen: false).fetchNewsData('tesla');
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

  void _showSearchBottomSheet(BuildContext context) {

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Enter search key",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _searchData(_searchController.text);
                _searchController.text = "";
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text("Search"),
            ),
          ],
        ),
      ),
    );

  }

  Future<void> _searchData(String searchKeyword) async {
    try {
      await Provider.of<NewsProvider>(context, listen: false)
          .fetchNewsData(searchKeyword);
    } catch (error) {
      print('Error searching news: $error');
    }
  }

  void _showFilterByCategoryMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                _navigateToCategoryNewsPage(context, 'business');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text('Business'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToCategoryNewsPage(context, 'entertainment');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text('Entertainment'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToCategoryNewsPage(context, 'general');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text('General'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToCategoryNewsPage(context, 'health');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text('Health'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToCategoryNewsPage(context, 'science');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text('Science'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToCategoryNewsPage(context, 'sports');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text('Sports'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToCategoryNewsPage(context, 'technology');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text('Technology'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategoryNewsPage(BuildContext context, String category) {
    // print(category);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsCategory(category: category),
      ),
    );
  }

  void _showSortByMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                _navigateToSortPage(context, 'relevancy');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text('Relevancy'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToSortPage(context, 'popularity');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text('Popularity'),
            ),
            ElevatedButton(
              onPressed: () {
                _navigateToSortPage(context, 'publishedAt');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text('Published At'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSortPage(BuildContext context, String sortBy) {
    // print(sortBy);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsSort(sortBy: sortBy),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('WW News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              _showSearchBottomSheet(context);
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            color: Colors.white,
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'wallStreetJournal',
                child: Text('Wall Street Journal'),
              ),
              const PopupMenuItem<String>(
                value: 'categories',
                child: Text('Categories By'),
              ),
              const PopupMenuItem<String>(
                value: 'sort',
                child: Text('Sort By'),
              ),
            ],
            onSelected: (value) {
              if (value == 'categories') {
                _showFilterByCategoryMenu(context);
              } else if (value == 'sort') {
                _showSortByMenu(context);
              } else if (value == 'wallStreetJournal') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WallStreetJournal()),
                );
              }
            },
          ),
        ],
      ),
        body: Center(
        child: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
      if (newsProvider.news == null) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Fetching news articles...'),
          ],
        );
      } else {
        return ListView.builder(
            itemCount: newsProvider.news?.articles.length,
            itemBuilder: (context, int index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
    child: SizedBox(
    width: w,
    // height: 150.0,
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Expanded(
    flex: 1,
    child: Image.network(newsProvider.news?.articles
        .elementAt(index)
        .urlToImage ?? "",
        fit: BoxFit.fill,
        ),
    ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${newsProvider.news?.articles.elementAt(index).title}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        _formatDate(
                          newsProvider.news?.articles.elementAt(index).publishedAt,
                          newsProvider.news?.articles.elementAt(index).author,
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
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                      child: const Text(
                        'Read More',
                        style: TextStyle(
                          color: Colors.white, // Text color
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
            });
      }
        },
        ),
        ),
    );
  }
}