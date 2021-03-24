import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gram/Widget/MyBookmark.dart';
import 'package:flutter_gram/screens/Commentpage.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model/DataList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataList> list=[];

  int _index = 0;

  bool isLoading=true;

  List<dynamic> bookmarkedList=[];

  List<String> bookmarkedIdList=<String>[];

  List<int> _selectedItems = <int>[];

  List<int> _selectedshowMore = <int>[];

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  List<String> savedIdList=[];


  @override
  void initState() {
    getDetails();
    getSPVal();
    getIndex();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (_index) {
      case 0:
        child = myHome();
        break;
      case 1:
        child = otherWidget(2);
        break;
      case 2:
        child =MyBookmark(bookMarkedFinalVal: bookmarkedList,);
        break;
      case 3:
        child = otherWidget(4);
        break;
      case 4:
        child = otherWidget(5);
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.camera_alt_outlined,color: Colors.black,), onPressed: (){}),
        title: Image.network('https://www.pngarts.com/files/4/Instagram-PNG-Background-Image.png',width: 100,),
        actions: [
          IconButton(icon: Image.network('https://static.thenounproject.com/png/3084968-200.png',height: 22,), onPressed: (){}),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon:  Icon(Icons.home),
            // ignore: deprecated_member_use
            title:  Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            // ignore: deprecated_member_use
            title: new Text('Search'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              // ignore: deprecated_member_use
              title: Text('Bookmark')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              // ignore: deprecated_member_use
              title: Text('Favorite')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              // ignore: deprecated_member_use
              title: Text('Profile')
          ),
        ],
      ),
      body: child,
    );
  }

  Future<List<DataList>> getDetails() async{
    http.Response response = await http.get('https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas');
    if(response.statusCode==200){
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        isLoading=false;
        list = ( jsonResponse as List).map((e) => DataList.fromJson(e)).toList();
      });
      return list;
    }
    else{
      return null;
    }

  }

  Widget channelName(int index,List list) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: CircleAvatar(
                backgroundImage:NetworkImage(list[index].lowThumbnail),
              ),
            ),
            Text(list[index].channelname,style: TextStyle(fontWeight: FontWeight.bold),),
            Expanded(child: Container()),
            IconButton(icon: Icon(Icons.more_vert_outlined), onPressed: (){})
          ],
        ),
      ),
    );
  }
  Widget post(int index) {
    return Container(
      child: AspectRatio(child: Image.network(list[index].highThumbnail),aspectRatio: 16/9,),
    );
  }
  Widget actions(int index) {
    return Container(
      child: Row(children: [
        IconButton(icon: Icon(Icons.favorite_border), onPressed: (){}),
        IconButton(icon: Image.network('https://img.pngio.com/hd-circular-speech-bubble-outline-comments-instagram-comment-instagram-comment-png-980_976.png',height: 22,), onPressed: (){}),
        IconButton(icon: Image.network('https://static.thenounproject.com/png/3084968-200.png',height: 22,), onPressed: (){}),
        Expanded(child: Container()),
        IconButton(icon: Icon((bookmarkedIdList.contains(list[index].id))?Icons.bookmark:Icons.bookmark_border,),
            onPressed: (){
          if((bookmarkedIdList.contains(list[index].id))){
            _removeBookmark(index);
          }
          else{
            _saveFeed(index);
          }
            }
        ),
      ],),
    );
  }
  Widget title(int index) {
    if(list[index].title.length>50){
      if((_selectedshowMore.contains(index))){
        return Container(
          child: Text(list[index].title),
        );
      }
      else{
        return GestureDetector(
          onTap:(){
            if(! _selectedshowMore.contains(index)){
              setState(() {
                _selectedshowMore.add(index);
              });
            }
          },
          child: Container(
            child: Text('${list[index].title.substring(0,50)}...More'),
          ),
        );
      }
    }
    else{
      return Container(
        child: Text(list[index].title),
      );
    }
  }
  Widget comments(int index) {
    return Container(
        child:GestureDetector(child: Text('View Comments'),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentPage()));
        },)
    );
  }

  Widget myHome() {
    return isLoading?Center(child: CircularProgressIndicator()):ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context,int index){
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                channelName(index,list),
                post(index),
                actions(index),
                title(index),
                comments(index),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget otherWidget(int pn) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.insert_drive_file_outlined),
        Text('No Items',style: TextStyle(fontWeight: FontWeight.bold),),
      ],
    ));
  }


  Future encodeDecode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final SharedPreferences prefs = pref;
    var bookMarkListData = json.encode(bookmarkedList);
    prefs.setString('bookMarkListData', bookMarkListData);
    getSPVal();
  }

  Future getSPVal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final SharedPreferences prefs = pref;
    var bookMarkListString = (prefs.getString('bookMarkListData')) ?? '' ;
    var decodeVal = json.decode(bookMarkListString);
    setState(() {
      bookmarkedList=decodeVal.toSet().toList();
    });
  }

  Future storeIndex() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> stringsList=  _selectedItems.map((i)=>i.toString()).toList();
    pref.setStringList('idList', bookmarkedIdList);
    pref.setStringList("bookmarkIndexList", stringsList);
  }

  Future getIndex() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    List<String> mList = (prefs.getStringList('bookmarkIndexList') ?? <String>[]);
    List<int> saveIndex = mList.map((i)=> int.parse(i)).toList();
    setState(() {
      bookmarkedIdList = (prefs.getStringList('idList') ?? <String>[]);
      _selectedItems=saveIndex;
    });

  }

  void _saveFeed(int index) {
    setState(() {
      bookmarkedIdList.add(list[index].id);
      bookmarkedList.add(list[index]);
      storeIndex();
      encodeDecode();
    });
  }

  void _removeBookmark(int index) {
    setState(() {
      bookmarkedIdList.remove(list[index].id);
      bookmarkedList.removeWhere((element) => false);
      bookmarkedList.removeWhere((item) => item['id'] == list[index].id );
    });
    storeIndex();
    encodeDecode();
    getIndex();
  }
}

