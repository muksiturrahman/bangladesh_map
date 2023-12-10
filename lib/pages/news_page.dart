import 'package:bangla_calendar/pages/bangladesh_map.dart';
import 'package:bangla_calendar/services/service.dart';
import 'package:bangla_calendar/utils/global_var.dart';
import 'package:bangla_calendar/widgets/dialog.dart';
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
        title: InkWell(
          onLongPress: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BangladeshMap()));
          },
            child: Text('NewsPage'),
        ),
        centerTitle: true,
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
                  title: Text(GlobalVar.utf8convert(newsItem.headline),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  subtitle: Text(GlobalVar.utf8convert(newsItem.details),style: TextStyle(),maxLines: 3,overflow: TextOverflow.ellipsis,),
                  onTap: () {
                    // Handle item tap, e.g., navigate to the detail page
                    print('Tapped on: ${GlobalVar.utf8convert(newsItem.headline)}');
                  },
                  onLongPress: () {
                    ReUsableDialog.show(context, 'News ${GlobalVar.utf8convert(newsItem.headline)}');
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
