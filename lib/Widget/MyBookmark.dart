import 'package:flutter/material.dart';
import 'package:flutter_gram/screens/Commentpage.dart';

class MyBookmark extends StatefulWidget {
  List<dynamic> bookMarkedFinalVal=[];
  MyBookmark({this.bookMarkedFinalVal});
  @override
  _MyBookmarkState createState() => _MyBookmarkState();
}

class _MyBookmarkState extends State<MyBookmark> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.bookMarkedFinalVal.isEmpty?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.insert_drive_file_outlined),
            Text('No Items',style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ):ListView.builder(
        itemCount: widget.bookMarkedFinalVal.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.bookMarkedFinalVal[index]['channelname']),
                  channelName(index),
                  post(index),
                  actions(index),
                  title(index),
                  comments(index),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget channelName(int index) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: CircleAvatar(
                backgroundImage:NetworkImage(widget.bookMarkedFinalVal[index]['lowThumbnail']??''),
              ),
            ),
            Text(widget.bookMarkedFinalVal[index]['channelname'],style: TextStyle(fontWeight: FontWeight.bold),),
            Expanded(child: Container()),
            IconButton(icon: Icon(Icons.more_vert_outlined), onPressed: (){})
          ],
        ),
      ),
    );
  }
  Widget post(int index) {
    return Container(
      child: AspectRatio(child: Image.network(widget.bookMarkedFinalVal[index]['high thumbnail']??'https://1062795.app.netsuite.com/core/media/media.nl?id=199531&c=1062795&h=11ab4a982bd2a52f0c8c&fcts=20191213041104&whence='),aspectRatio: 16/9,),
    );
  }
  Widget actions(int index) {
    return Container(
      child: Row(children: [
        IconButton(icon: Icon(Icons.favorite_border), onPressed: (){}),
        IconButton(icon: Image.network('https://img.pngio.com/circular-speech-bubble-outline-comments-instagram-comment-logo-instagram-comment-png-920_956.png',height: 26,), onPressed: (){}),
        IconButton(icon: Image.network('https://static.thenounproject.com/png/3084968-200.png',height: 22,), onPressed: (){}),
        Expanded(child: Container()),

      ],),
    );
  }
  Widget title(int index) {
    return Container(
      child: Text(widget.bookMarkedFinalVal[index]['title']),
    );
  }
  Widget comments(int index) {
    return Container(
        child:GestureDetector(child: Text('View Comments'),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentPage()));
        },)
    );
  }

}
