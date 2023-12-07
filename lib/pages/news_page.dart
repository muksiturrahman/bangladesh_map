import 'package:bangla_calendar/services/service.dart';
import 'package:bangla_calendar/utils/global_var.dart';
import 'package:flutter/material.dart';
import '../models/news_model.dart';


class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ApiService _apiService = ApiService();
  late Future<List<NewsItem>> _newsList;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _newsList = _apiService.fetchData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NewsPage'),
      ),
      body: FutureBuilder<List<NewsItem>>(
        future: _newsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          } else {
            // Print the fetched data for debugging
            print('Fetched data in NewsPage: ${snapshot.data}');
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                NewsItem newsItem = snapshot.data![index];
                return ListTile(
                  title: Text(globalVar.utf8convert(newsItem.headline),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  subtitle: Text(globalVar.utf8convert(newsItem.details),style: TextStyle(),maxLines: 3,overflow: TextOverflow.ellipsis,),
                  onTap: () {
                    // Handle item tap, e.g., navigate to the detail page
                    print('Tapped on: ${globalVar.utf8convert(newsItem.headline)}');
                  },
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Long Press Dialog'),
                          content: Text('Hi there!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
