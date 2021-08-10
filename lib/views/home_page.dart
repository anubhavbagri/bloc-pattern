import 'package:bloc_pattern/controllers/news_bloc.dart';
import 'package:bloc_pattern/models/news_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newsBloc = NewsBloc();

  @override
  void initState() {
    newsBloc.eventSink.add(NewsAction.Fetch);
    super.initState();
  }

  @override
  void dispose() {
    newsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Container(
        child: StreamBuilder<List<Article>>(
          stream: newsBloc.newsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data![index];
                    var formattedTime = DateFormat('dd MMM - HH:mm')
                        .format(article.publishedAt);
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            article.title,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${article.description}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                              Text(
                                '$formattedTime',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          leading: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 44,
                              minHeight: 64,
                              maxWidth: 64,
                              maxHeight: 64,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                article.urlToImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            } else {
              return Center(
                  child: Text(
                      'Something went wrong ${snapshot.error.toString()}'));
            }
          },
        ),
      ),
    );
  }
}
