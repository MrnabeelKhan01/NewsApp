import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/infrastructure/models/news.dart';
import 'package:news_app/infrastructure/services/get_services.dart';
import 'package:news_app/presentation/elements/app_loader.dart';
import 'package:news_app/presentation/elements/custom_text.dart';
import 'package:news_app/presentation/view/user_profile/user_profile_view.dart';
import 'package:provider/provider.dart';

import '../../../../applications/provider.dart';
import '../../comments/comments_view.dart';

class NewsBody extends StatefulWidget {
  const NewsBody({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<NewsBody> createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {
  bool isComments = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserProvider>(context,);

    return FutureProvider<List<NewsModel>>(
      initialData: [],
      create: (context) =>
          GetServices().getAllNews(categoryId: widget.categoryId),
      catchError: (context, error) {
        log("Error fetching news: $error");
        return [];
      },
      child: Consumer<List<NewsModel>>(
        builder: (context, newsModelList, child) {
          if (newsModelList.isEmpty) {
            return const Center(child: LoadingWidget());
          }
          return PageView.builder(
            itemCount: newsModelList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, i) {
              var newsItem = newsModelList[i];

              // Check if newsItem contains null or empty fields
              if (newsItem.title == null || newsItem.content == null) {
                return const SizedBox.shrink();
              }

              return isLoading
                  ? const LoadingWidget()
                  : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    newsItem.image != null && newsItem.image!.isNotEmpty
                        ? Image.network(newsItem.image!)
                        : Image.asset("assets/images/new.png"),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserProfileView()));
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  // Optional: Add user's profile picture if available
                                  child: userData.getUserData
                                      .profilePicture !=
                                      null &&
                                      userData.getUserData
                                          .profilePicture!.isNotEmpty
                                      ? Image.network(userData
                                      .getUserData.profilePicture!)
                                      : const Icon(Icons.person),
                                ),
                              ),
                              const SizedBox(width: 5),
                              CustomText(
                                text: userData.getUserData.name
                                    .toString(),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          CustomText(
                            text: newsItem.title.toString(),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            text: newsItem.content.toString(),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              CustomText(
                                text: "Author: ",
                                fontWeight: FontWeight.w500,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue.withOpacity(0.2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: CustomText(
                                    text: newsItem.author?.name?.name ??
                                        'Unknown',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.thumb_up_alt_outlined,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 5),
                                  CustomText(
                                      text: "5", fontSize: 14), // Example data
                                ],
                              ),
                              const SizedBox(width: 18),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.thumb_down_alt_outlined,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 5),
                                  CustomText(
                                      text: "5", fontSize: 14), // Example data
                                ],
                              ),
                              const SizedBox(width: 18),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.share,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  CustomText(
                                    text: newsItem.shares.toString(),
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Comments"),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CommentsView(
                                                comments: newsItem
                                                    .comments!
                                                    .map((comment) =>
                                                comment.content ??
                                                    '')
                                                    .toList(),
                                              )));
                                },
                                icon: const Icon(Icons
                                    .keyboard_arrow_down_outlined),
                              ),
                            ],
                          ),
                          if (isComments &&
                              newsItem.comments != null &&
                              newsItem.comments!.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              itemCount: newsItem.comments!.length,
                              itemBuilder: (context, j) {
                                return CustomText(
                                  text: newsItem.comments![j].content ??
                                      '',
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
