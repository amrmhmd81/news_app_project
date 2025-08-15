import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

// Domain imports
import 'domain/repositories/news_repository.dart';
import 'domain/usecases/get_news_articles_usecase.dart';

// Data imports
import 'data/repoImpl/news_repository_impl.dart';
import 'data/datasources/news_data_source.dart';
import 'data/datasources/news_data_source_impl.dart';

// Presentation imports
import 'presentation/bloc/news_bloc.dart';
import 'presentation/pages/home_page.dart';

// Service locator
final GetIt getIt = GetIt.instance;

void main() {
  // تسجيل الـ dependencies
  setupDependencies();
  
  runApp(const MyApp());
}

void setupDependencies() {
  // تسجيل ال Dio
  getIt.registerLazySingleton<Dio>(
    () => Dio(),
  );

  // تسجيل ال DataSource
  getIt.registerLazySingleton<NewsDataSource>(
    () => NewsDataSourceImpl(getIt()),
  );

  // تسجيل ال Repository
  getIt.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(getIt()),
  );

  // تسجيل ال UseCase
  getIt.registerLazySingleton<GetNewsArticlesUsecase>(
    () => GetNewsArticlesUsecase(getIt()),
  );

  // تسجيل ال Bloc
  getIt.registerFactory<NewsBloc>(
    () => NewsBloc(getNewsArticlesUsecase: getIt()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق الأخبار',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue[800]!,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Cairo',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[800],
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) => getIt<NewsBloc>(),
        child: const HomePage(),
      ),
    );
  }
}
