import 'package:dio/dio.dart';
import 'package:e_commerce_poc/blocs/home/home_page_bloc.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/dao/category_dao.dart';
import 'package:e_commerce_poc/database/dao/product_dao.dart';
import 'package:e_commerce_poc/database/dao/ranking_dao.dart';
import 'package:e_commerce_poc/pages/home_page.dart';
import 'package:e_commerce_poc/repository/api_client.dart';
import 'package:e_commerce_poc/repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ECommercePocApp extends StatelessWidget {
  AppDatabase _appDatabase = AppDatabase();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(
          create: (_) => HomePageBloc(
            apiRepository: ApiRepository(apiClient: ApiClient(dioClient: Dio())),
            categoryDao: CategoryDao(_appDatabase),
            productDao: ProductDao(_appDatabase),
            rankingDao: RankingDao(_appDatabase),
          )..add(HomePageStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'E-Commerce POC App',
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
        },
      ),
    );
  }
}
