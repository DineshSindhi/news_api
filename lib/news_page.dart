
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_api/search_page.dart';
class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News'),centerTitle: true,
      actions: [
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder:  (context) => SearchPage(),));
          },
            child: Icon(Icons.search))
      ],),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getNews('everything'),
              builder: (_,snap){
                if(snap.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }else if(snap.hasError){
                  return Center(child: Text('${snap.error}'),);
                }else if(snap.hasData){
                  return ListView.builder(
                    itemCount: snap.data!.articles!.length,
                    itemBuilder: (context, index) {
                      var mData=snap.data!.articles![index];
                      return Container(
                        width: double.infinity,
                        height: 560,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          //color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: Colors.blueGrey,width: 2),
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RichText(
                                text: TextSpan(
                        style: TextStyle(fontSize: 24,color: Colors.blueGrey.shade900),
                                  children: [
                                    TextSpan(
                                      text: ' Title - ',
                                      style: TextStyle(fontSize: 24,color: Colors.red.shade600),
                                    ),
                                    TextSpan(
                                      text: '${mData.title}',
                                    )
                                  ]
                                ),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 2, ),

                            InkWell(
                              onTap: (){
                                webUrl('${mData.url}');
                              },
                              child: SizedBox(height: 280,width: double.infinity,
                                child: ClipRRect(child: Image.network('${mData.urlToImage}',fit: BoxFit.fill,),),
                              ),
                            ),
                            myText('Description', '${mData.description}'),
                            myText('Content', '${mData.content}'),
                            myText('PublishedAt', '${mData.publishedAt}'),

                            // myText17(' Description - ${mData.description}'),
                            // myText17(' Content - ${mData.content}',),
                            // myText17(' publishedAt - ${mData.publishedAt}',),
                            myTextA('Author', '${mData.author}'),
                            myTextA('Source/Name', '${mData.source!.name}'),
                            // myText17('Author - ${mData.author}'),
                            // myText17('Source/Name - ${mData.source!.name} '),
                            Container(
                              margin: EdgeInsets.all(5),
                              color: Colors.blueGrey,
                              width: double.infinity,
                              height: 2,),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Icon(Icons.thumb_up,size: 30,color: Colors.blue,),
                                    Text('Like')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.comment_sharp,size: 30,color: Colors.blue,),
                                    Text('Comment')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.share,size: 30,color: Colors.blue,),
                                    Text('Share')
                                  ],
                                ),


                              ],),



                          ],),
                      );
                    },);
                }
                return Container();
              },
            ),
          ),
        ],
      ),

    );
  }



  myText17(String text)=> Text(text,style: TextStyle(fontSize: 18,),textAlign: TextAlign.center,);
  myText(String title,String text,)=>RichText(
    text: TextSpan(
        style: TextStyle(fontSize: 17,color: Colors.blueGrey.shade900),
        children: [
          TextSpan(
            text: ' $title - ',
            style: TextStyle(fontSize: 18,color: Colors.red.shade600,),
          ),
          TextSpan(
            text: text,
          )
        ]
    ),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 2, );
  myTextA(String title,String text,)=>RichText(
    text: TextSpan(
        style: TextStyle(fontSize: 17,color: Colors.blueGrey.shade900),
        children: [
          TextSpan(
            text: ' $title - ',
            style: TextStyle(fontSize: 18,color: Colors.red.shade600,),
          ),
          TextSpan(
            text: text,
          )
        ]
    ),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 1, );

}
