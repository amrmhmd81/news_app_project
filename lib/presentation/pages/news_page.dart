import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';
import '../bloc/news_state.dart';
import '../widgets/news_list_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/pull_to_refresh_widget.dart';
import '../widgets/custom_app_bar.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    // دي بتاعت اول ما الصفحة تفتج يجيب الاخبار
    context.read<NewsBloc>().add(const GetNewsArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'الأخبار',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              context.read<NewsBloc>().add(const GetNewsArticlesEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return const LoadingWidget();
          } else if (state is NewsLoadedState) {
            return PullToRefreshWidget(
              child: NewsListWidget(articles: state.articles),
            );
          } else if (state is NewsErrorState) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<NewsBloc>().add(const GetNewsArticlesEvent());
              },
            );
          } else {
            return const Center(
              child: Text(
                'لا توجد أخبار',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }
}
