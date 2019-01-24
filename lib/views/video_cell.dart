import 'package:flutter/material.dart';

class VideoCell extends StatelessWidget{
  final video;
  VideoCell(this.video);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          padding:  new EdgeInsets.all(16.0),
          child: new Column(
            children: <Widget>[
              new Image.network(video['imageUrl']),
              new Container(height: 6.0,),
              new Text(video['name'],
                style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        new Divider()
      ],
    );
  }
}