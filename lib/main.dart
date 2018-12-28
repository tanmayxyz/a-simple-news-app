import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("an news app"),
          ),
          body: NewBody()),
    );
  }
}

class NewBody extends StatefulWidget {
  @override
  _NewBodyState createState() => _NewBodyState();
}

class _NewBodyState extends State<NewBody> {
  List article;
  String url ='https://newsapi.org/v2/top-headlines?'
      'country=us&apiKey=f9a164debafd40cb9eff74e23afce225';
  Future<String> getNews() async {
    var ref = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var refBody = jsonDecode(ref.body);
      article = refBody["articles"];
    });

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: article == null ? 0 : article.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Card(
                    child: Text(article[index]['title']),

                  ),
                  padding: EdgeInsets.all(13.0),
                )
              ],
            ),
          ));
        },
      ),
    );
  }
}
