import 'dart:convert';

import 'package:bloc_pattern/constants/strings.dart';
import 'package:bloc_pattern/models/news_info.dart';
import 'package:http/http.dart' as http;

class APIManager {
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
}
