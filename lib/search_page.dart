import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:news_api/search_data.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/data_model.dart';

class SearchPage extends StatefulWidget {

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var newsController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
        child: TextField(
          controller: newsController,
          decoration: InputDecoration(
              filled: true,
              hintText: 'Search',
              suffixIcon: InkWell(
                  onTap: (){
                    newsController.text;
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => search_data(value: newsController.text,),));
                  },
                  child: Icon(Icons.search,size: 30,)),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)
              )
          ),),
      ),
    );
  }
}
 Future<DataModel?>getNews(String value)async{
DataModel? news;
String url='https://newsapi.org/v2/everything?q=$value&apiKey=7082d73a82a240f6b43a707bddc3af16&searchIn=title,description';
var response=await http.get(Uri.parse(url));
if(response.statusCode==200){
var mData=response.body;
print(mData);
var rawData=jsonDecode(mData);
news=DataModel.fromJson(rawData);
}
return news;
}
Future<void>webUrl(String url)async {
  if(!await launchUrl(Uri.parse(url),mode: LaunchMode.inAppBrowserView)){
    throw Exception('$url is not run');
  }
}
//newsController.text