import 'package:flutter/material.dart';
import 'package:news_app/presentation/elements/custom_appbar.dart';
import 'package:news_app/presentation/view/news/layout/body.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key,  required this.categoryId});
final String categoryId;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:customAppBar(context,isShowTitle:true,title:"News"),
      body:NewsBody(categoryId: categoryId,),
    );
  }
}
