import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';
import '../bloc/news_state.dart';
import '../widgets/news_list_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/custom_app_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(const GetNewsArticlesEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.trim().isNotEmpty) {
      setState(() {
        _hasSearched = true;
      });
      context.read<NewsBloc>().add(SearchNewsArticlesEvent(query: query.trim()));
    } else {
      setState(() {
        _hasSearched = false;
      });
      context.read<NewsBloc>().add(const GetNewsArticlesEvent());
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _hasSearched = false;
    });
    context.read<NewsBloc>().add(const GetNewsArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'البحث في الأخبار',
      ),
      body: Column(
        children: [
          // شريط البحث
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[800],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'ابحث في الأخبار...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.white),
                              onPressed: _clearSearch,
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                    ),
                    onSubmitted: _performSearch,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        _clearSearch();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () => _performSearch(_searchController.text),
                ),
              ],
            ),
          ),
          
          // نتائج البحث
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoadingState) {
                  return const LoadingWidget();
                } else if (state is NewsLoadedState) {
                  if (_hasSearched) {
                    return const Center(
                      child: Text(
                        'اكتب كلمة للبحث',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return NewsListWidget(articles: state.articles);
                } else if (state is NewsSearchState) {
                  return NewsListWidget(articles: state.articles);
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
                      'لا توجد نتائج',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
