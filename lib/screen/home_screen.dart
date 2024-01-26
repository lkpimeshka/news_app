import 'package:flutter/material.dart';
import 'package:news/view-model/news_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    Provider.of<NewsProvider>(context, listen: false).fetchNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
        child: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
      if (newsProvider.news == null) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Fetching news data...'),
          ],
        );
      } else {
        return ListView.builder(
            itemCount: newsProvider.news?.data.length,
            itemBuilder: (context, int index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
    child: SizedBox(
    width: w,
    height: 100.0,
    child: Row(
    children: [
    Expanded(
    flex: 1,
    child: Image.network(newsProvider.news?.data
        .elementAt(index)
        .avatar ??
        ""),
    ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${newsProvider.news?.data.elementAt(index).firstName} ${newsProvider.news?.data.elementAt(index).lastName}",
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      newsProvider.news?.data
                          .elementAt(index)
                          .email ??
                          "",
                      style: const TextStyle(
                          color: Colors.blue,
                          fontStyle: FontStyle.italic),
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