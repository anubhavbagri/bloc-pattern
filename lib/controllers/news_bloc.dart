import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/constants/strings.dart';
import 'package:bloc_pattern/models/news_info.dart';
import 'package:http/http.dart' as http;

enum NewsAction {
  Fetch,
  Delete,
}

class NewsBloc {
  final _stateStreamController = StreamController<List<Article>>();
  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

  NewsBloc() {
    _eventStream.listen((event) async {
      if (event == NewsAction.Fetch) {
        try {
          var news = await getNews();
          _newsSink.add(news.articles);
        } on Exception catch (e) {
          _newsSink.addError('Something went wrong');
        }
      }
    });
  }

  Future<Welcome> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Uri.parse(
          NEWS_URL)); //here we will get data from the server i.e. http client calling the get request and fetching the response
      if (response.statusCode == 200) {
        var jsonString =
            response.body; //response body will contain the entire json
        ///we will now parse the jsonString and show it on the UI
        ///But to parse it, we need to convert it to a model, to bind it to the UI we need a model
        ///To convert json to a model, visit: https://app.quicktype.io
        var jsonMap = json.decode(jsonString);

        newsModel = Welcome.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }
    return newsModel;
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
