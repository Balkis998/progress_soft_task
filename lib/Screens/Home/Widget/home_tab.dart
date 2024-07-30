import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/Language/key_lang.dart';
import 'package:flutter_task/Style/assets.dart';

import '../../../BloC/Home/post_bloc.dart';
import '../../../BloC/Home/post_event.dart';
import '../../../BloC/Home/post_state.dart';
import '../../../Style/form_style.dart';
import '../../../Theme/app_colors.dart';
import '../../../Theme/text_theme.dart';
import '../../Posts/post_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchPosts());
    _searchController.addListener(() {
      context.read<PostBloc>().add(SearchPosts(_searchController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: TextField(
            controller: _searchController,
            decoration: AppStyles.formStyle(
              '',
              labelText: KeyLang.search.tr(),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<PostBloc, PostState>(
            builder: (_, state) {
              if (state is PostLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PostLoaded) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Card(
                        color: AppColors.white,
                        elevation: 5,
                        child: GestureDetector(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return PostScreen(
                              post: post,
                              image: index % 2 == 0
                                  ? ImageAssets.post
                                  : ImageAssets.post2,
                            );
                          })),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        index % 2 == 0
                                            ? ImageAssets.person1
                                            : ImageAssets.person2,
                                        fit: BoxFit.cover,
                                        width: 50.w,
                                        height: 50.h,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      index % 2 == 0
                                          ? 'Ahmad Abu-Taima'
                                          : 'Balqees Abaza',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextThemeStyle
                                          .textThemeStyle.bodyMedium,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  post.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      TextThemeStyle.textThemeStyle.bodyMedium,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  post.body,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextThemeStyle
                                      .textThemeStyle.bodySmall!
                                      .copyWith(),
                                ),
                                SizedBox(height: 16.h),
                                Image.asset(
                                  index % 2 == 0
                                      ? ImageAssets.post
                                      : ImageAssets.post2,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is PostError) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text(KeyLang.somethingWrong.tr()));
              }
            },
          ),
        ),
      ],
    );
  }
}
