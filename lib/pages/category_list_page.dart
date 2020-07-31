import 'package:dio/dio.dart';
import 'package:e_commerce_poc/blocs/category_list/category_list_page_bloc.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/categories_with_sub_category.dart';
import 'package:e_commerce_poc/pages/dashboard_page.dart';
import 'package:e_commerce_poc/pages/product_list_page.dart';
import 'package:e_commerce_poc/repository/api_client.dart';
import 'package:e_commerce_poc/repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListPage extends StatefulWidget {
  final Category category;

  final AppDatabase appDatabase;

  const CategoryListPage({
    Key key,
    this.category,
    this.appDatabase,
  }) : super(key: key);

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  Category get category => widget.category;

  AppDatabase get appDatabase => widget.appDatabase;

  CategoryListPageBloc categoryListPageBloc;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryListPageBloc(
        apiRepository: ApiRepository(apiClient: ApiClient(dioClient: Dio())),
        appDatabase: appDatabase,
      )..add(CategoryListPageStarted(category)),
      child: BlocBuilder<CategoryListPageBloc, CategoryListPageState>(builder: (context, state) {
        if (state is CategoryListPageLoading) {
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
        if (state is CategoryListPageLoaded) {
          final List<CategoriesWithSubCategory> catList = state.catListContent['Categories'];
          final List<CategoriesWithSubCategory> subCatList = catList[0].subCategory;
          return DashboardPage(
            [
              MyAppBar(_scaffoldKey),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _MyListItem(subCatList[index], index, appDatabase),
                  childCount: subCatList.length,
                ),
              )
            ],
            state.catListContent['Menu'],
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
  final CategoriesWithSubCategory listItem;
  final int index;

  const _MyListItem(this.listItem, this.index, this.appDatabase, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorList = List.of([Colors.blue, Colors.blueAccent, Colors.lightBlue, Colors.lightBlueAccent]);

    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: (this.index % 2 == 0) ? colorList.toList() : colorList.reversed.toList(),
        ),
      ),
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () => {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ((listItem.subCategory.length > 0)
                  ? CategoryListPage(
                      category: listItem.categories,
                      appDatabase: appDatabase,
                    )
                  : ProductListPage(
                      category: listItem.categories,
                      appDatabase: appDatabase,
                    ))))
        },
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
                listItem.categories.name,
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
    );
  }
}
