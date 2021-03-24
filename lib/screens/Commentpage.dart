import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gram/model/CommentModel.dart';
import 'package:http/http.dart'as http;
class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<CommentModel> list=[];

  bool isLoading=true;

  @override
  void initState() {
    // TODO: implement initState
    getComments();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        actions: [
          IconButton(icon: Icon(Icons.send), onPressed: (){})
        ],
      ),
      body: isLoading?Center(child: CircularProgressIndicator()):ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context,int index){
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(list[index].username,style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Text(list[index].comments),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('45m'),
                      ),
                      Text('Reply'),
                    ],
                  ),
                  Divider()
                ],
              ),
            ],
          );
        },
      ),
    );
  }
  Future getComments() async{
var response = await http.get('https://cookbookrecipes.in/test.php');
if(response.statusCode==200){
setState(() {
  isLoading=false;
  list = (jsonDecode(response.body)as List).map((e) => CommentModel.fromJson(e)).toList();
});
  return list;
}
  }
}
