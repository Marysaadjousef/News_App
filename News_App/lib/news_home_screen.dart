import 'package:flutter/material.dart';
import 'constants.dart';
import 'data_provider/remote_data/dio_helper.dart';
import 'models/article.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({super.key});

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    List articlesList = await DioHelper().getNews(
        path: ApiConstants.baseUrl + ApiConstants.newsEndpoint,
        queryParameters: {"apiKey": ApiConstants.apikey, "country": "us"});
    articles = Article.convertToArticles(articlesList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              "News",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "Cloud",
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: articles.length == 0
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.only(bottom: 8),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        articles[index].urlToImage,
                        fit: BoxFit.fitWidth,
                      ),
                      Text(
                        articles[index].title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      Text(
                        articles[index].content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                );
              }),
    );
  }
}
