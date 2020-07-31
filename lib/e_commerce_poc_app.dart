import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/pages/category_list_page.dart';
import 'package:e_commerce_poc/pages/home_page.dart';
import 'package:e_commerce_poc/pages/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ECommercePocApp extends StatelessWidget {
  AppDatabase _appDatabase = AppDatabase();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(175, 50, 100, 255),
      ),
    );
    return MaterialApp(
      title: 'E-Commerce POC App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(appDatabase: _appDatabase),
        '/category': (context) => CategoryListPage(appDatabase: _appDatabase),
        '/product': (context) => ProductListPage(appDatabase: _appDatabase),
      },
    );
  }
}
