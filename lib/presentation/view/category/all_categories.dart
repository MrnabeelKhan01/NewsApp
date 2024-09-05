import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:news_app/infrastructure/models/category.dart';
import 'package:news_app/infrastructure/services/get_services.dart';
import 'package:news_app/presentation/elements/custom_appbar.dart';
import 'package:news_app/presentation/elements/custom_text.dart';
import 'package:news_app/presentation/view/news/news_view.dart';
import 'package:provider/provider.dart';

import '../../elements/app_loader.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, isShowTitle: true, title: "News Categories"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureProvider<List<CategoryModel>>(
          create: (context) => GetServices().getCategories(),
          initialData: [],
          catchError: (context, error) {
            log("Error fetching categories: $error");
            return [];
          },
          child: Consumer<List<CategoryModel>>(
            builder: (context, categoryModel, child) {
              if (categoryModel.isEmpty) {
                return const LoadingWidget();
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: categoryModel.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, i) {
                  final category = categoryModel[i];
                  if (category.name == null) {
                    return const SizedBox.shrink();
                  }
                  log(category.name.toString());
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsView(
                            categoryId: category.id.toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: CustomText(text: category.name.toString()),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
