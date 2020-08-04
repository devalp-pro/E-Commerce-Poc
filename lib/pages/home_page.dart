import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:e_commerce_poc/blocs/home/home_page_bloc.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/categories_with_sub_category.dart';
import 'package:e_commerce_poc/database/model/product_ranking.dart';
import 'package:e_commerce_poc/pages/category_list_page.dart';
import 'package:e_commerce_poc/pages/dashboard_page.dart';
import 'package:e_commerce_poc/pages/product_detail_page.dart';
import 'package:e_commerce_poc/repository/api_client.dart';
import 'package:e_commerce_poc/repository/api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final AppDatabase appDatabase;

  const HomePage({
    Key key,
    this.appDatabase,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppDatabase get appDatabase => widget.appDatabase;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(
        apiRepository: ApiRepository(apiClient: ApiClient(dioClient: Dio())),
        appDatabase: appDatabase,
      )..add(HomePageStarted()),
      child: BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
        if (state is HomePageLoading) {
          return DashboardPage(
            [
              MyAppBar(_scaffoldKey),
              SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
            List(),
            _scaffoldKey,
            null,
          );
        }
        if (state is HomePageLoaded) {
          return DashboardPage(
            [
              MyAppBar(_scaffoldKey),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _MyListItem(
                    state.homeContent.values.toList()[index],
                    state.homeContent.keys.toList()[index],
                    index,
                    appDatabase,
                  ),
                  childCount: state.homeContent.length,
                ),
              )
            ],
            state.homeContent['Categories'],
            _scaffoldKey,
            null,
          );
        }
        return DashboardPage(
          [
            MyAppBar(_scaffoldKey),
            SliverFillRemaining(
              child: Center(
                child: Text('Something went wrong!'),
              ),
            )
          ],
          List(),
          _scaffoldKey,
          null,
        );
      }),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final AppDatabase appDatabase;
  final dynamic listItem;
  final String title;
  final int index;

  const _MyListItem(this.listItem, this.title, this.index, this.appDatabase, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorList = List.of([Colors.blue, Colors.blueAccent, Colors.lightBlue, Colors.lightBlueAccent]);

    return Container(
      height: 340,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: (this.index % 2 == 0) ? colorList.toList() : colorList.reversed.toList(),
        ),
      ),
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.vertical,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
//              listItem.length > 6
//                  ? Container(
//                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//                      alignment: Alignment.centerRight,
//                      child: OutlineButton(
//                          splashColor: Colors.blueGrey,
//                          borderSide: BorderSide(color: Colors.white, width: 2),
//                          highlightedBorderColor: Colors.white,
//                          onPressed: () => {},
//                          child: Text(
//                            'See More',
//                            style: TextStyle(color: Colors.white),
//                          )),
//                    )
//                  : Container()
            ],
          ),
          Container(
            height: 260,
            width: double.infinity,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.blueGrey,
                  elevation: 10,
                  shadowColor: Colors.blueAccent,
                  child: InkWell(
                    splashColor: Colors.blue,
                    onTap: () {
                      if (listItem[index] is CategoriesWithSubCategory) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CategoryListPage(
                                  category: (listItem[index] as CategoriesWithSubCategory).categories,
                                  appDatabase: appDatabase,
                                )));
                      } else if (listItem[index] is ProductRanking) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ProductDetailPage((listItem[index] as ProductRanking).products, appDatabase)));
                      }
                    },
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Icon(
                              Icons.broken_image,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              this.index == 0
                                  ? (listItem[index] as CategoriesWithSubCategory).categories.name
                                  : (listItem[index] as ProductRanking).products.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: listItem.length,
              shrinkWrap: true,
//              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
