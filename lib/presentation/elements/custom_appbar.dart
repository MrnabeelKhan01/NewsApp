import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

customAppBar(
    BuildContext context, {
      String? title,
      bool isShowTitle = false,
    }) {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle:true,
    title: isShowTitle
        ? Text(
      title!,
      style:const TextStyle(fontSize: 18,
        fontWeight: FontWeight.w500,
        color:Colors.black,),
    )
        : const SizedBox(),
  );
}
