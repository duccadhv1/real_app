import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final title;
  final id;

  DetailPage(this.title, this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new DetailPageState(title, id);
  }
}

class DetailPageState extends State<DetailPage> {
  final title;
  final id;
  var _isLoading = true;
  var video_detail = [];

  DetailPageState(this.title, this.id);


  _fetchData() async{
    print("fetch Data running");
    print("fetch Data running $id");
    final url = 'http://api.letsbuildthatapp.com/youtube/course_detail?id=$id';
    final response = await http.get(url);
    if(response.statusCode == 200){
      final map = json.decode(response.body);
      print(response.body);
      setState(() {
        video_detail = map;
        _isLoading = false;
      });
    }
  }
  @override
  Widget _item(data) {
    return new Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Expanded(
              child: new Container(
                child: new Image.network(data['imageUrl'], fit: BoxFit.cover),
                width: 100.0,
              )
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.only(left: 15.0),
              child: new Text(data['name']),
            ),
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    // TODO: implement build

    _fetchData();
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new Center(
          child: _isLoading ? new CircularProgressIndicator() : new Container(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: this.video_detail != null ? this.video_detail.length : 0,
              itemBuilder: (BuildContext context, int index){
                final detail = this.video_detail[index];
//                print(detail);
                return _item(detail);
              },
            ),
          ),
        ),
      ),
    );
  }
}