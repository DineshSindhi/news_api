import 'package:news_api/model/article_model.dart';

class DataModel {
  String? status;
  int? totalResults;
  List<ArticleModel>? articles;

  DataModel({
    required this.status,
    required this.totalResults,
    required this.articles
  });
  factory DataModel.fromJson(Map<String,dynamic>json){
    List<ArticleModel>mData=[];
    for(Map<String,dynamic>each in json['articles']){
      mData.add(ArticleModel.fromJson(each));
    }
    return DataModel(
        status: json['status'],
        totalResults: json['totalResults'],
        articles: mData);
  }
}
