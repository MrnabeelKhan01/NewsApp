import 'package:flutter/material.dart';
import 'package:news_app/presentation/elements/custom_appbar.dart';
import 'package:news_app/presentation/elements/custom_text.dart';

import '../../../configurations/frontend_configs.dart';

class CommentsView extends StatelessWidget {
  CommentsView({super.key, required this.comments});

  final List<String> comments;
  TextEditingController commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(context,isShowTitle:true,title:"Comments"),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 44,
          child: TextFormField(
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: "EncodeSansSemiCondensed",
              color: Color(0xff111827),
            ),
            controller: commentsController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 18),
                hintText: "Comments",
                hintStyle: const TextStyle(
                    color: Color(0xff9CA3AF),
                    fontFamily: "EncodeSansSemiCondensed",
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: FrontendConfigs.kAppBorderSide),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: FrontendConfigs.kAppBorderSide),
                fillColor: FrontendConfigs.kAppSecondaryColor,
                filled: true,
                suffixIcon:
                    IconButton(onPressed: () {

                    }, icon: const Icon(Icons.send))),
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: comments.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(text: comments[i]),
          );
        },
      ),
    );
  }
}
