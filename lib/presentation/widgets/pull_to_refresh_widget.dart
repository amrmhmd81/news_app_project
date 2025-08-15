import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';

class PullToRefreshWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onRefresh;

  const PullToRefreshWidget({
    super.key,
    required this.child,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (onRefresh != null) {
          onRefresh!();
        } else {
          context.read<NewsBloc>().add(const GetNewsArticlesEvent());
        }
      },
      color: Colors.blue,
      backgroundColor: Colors.white,
      child: child,
    );
  }
}
