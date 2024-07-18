
class ArticleModel {
  String? author;
  String? content;
  String? description;
  String? publishedAt;
  String? title;
  String? url;
  String? urlToImage;
  Source? source;

  ArticleModel({
    required this.author,
    required this.content,
    required this.description,
    required this.publishedAt,
    required this.title,
    required this.url,
    required this.urlToImage,
    required this.source});
  factory ArticleModel.fromJson(Map<String,dynamic>json){
    var mData=Source.fromJson(json['source']);
    return ArticleModel(
        author: json['author'],
        content: json['content'],
        description: json['description'],
        publishedAt: json['publishedAt'],
        title: json['title'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        source: mData);
  }
}

class Source {
  String? id;
  String? name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(name: json['name'], id: json['id']);
  }
}
