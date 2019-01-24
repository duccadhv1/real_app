import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './views/video_cell.dart';
import './views/detail_page.dart';

void main() => runApp(RealApp());

class RealApp extends StatefulWidget {
 @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RealAppState();
  }
}

class RealAppState extends State<RealApp>{
  var _isLoading = true;
  var videos;
  _fetchData() async{
    print("fetch Data running");
    final url = 'http://api.letsbuildthatapp.com/youtube/home_feed';
    final response = await http.get(url);
    if(response.statusCode == 200){
      final map = json.decode(response.body);
      final videoJson = map['videos'];
      setState(() {
        _isLoading = false;
        videos = videoJson;
      });
    }
  }
  @override
  void initState() {
    _fetchData();
  }
  @override
  Widget build(BuildContext context) {
//    _fetchData();
    // TODO: implement build
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Real world app bar"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.refresh),
                onPressed: (){
              print("reloading");
              setState(() {
                _isLoading = true;
              });
              _fetchData();
                })
          ],
        ),
        body: new Center(
          child: _isLoading ? new CircularProgressIndicator() :
          new ListView.builder(
              itemCount: this.videos != null ? this.videos.length : 0,
              itemBuilder: (context, i){
                final video = this.videos[i];
                return new FlatButton(
                    padding: new EdgeInsets.all(0.0),
                    onPressed: (){
                      Navigator.push(context, 
                        new MaterialPageRoute(
                            builder: (context) => new DetailPage(video['name'], video['id']),
                        )
                      );
                    },
                    child: new VideoCell(video));
              },
          ),
        ),
      ),
    );
  }
}
