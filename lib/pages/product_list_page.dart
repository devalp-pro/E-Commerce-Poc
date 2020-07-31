import 'package:dio/dio.dart';
import 'package:e_commerce_poc/blocs/product_list/product_list_page_bloc.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/pages/dashboard_page.dart';
import 'package:e_commerce_poc/repository/api_client.dart';
import 'package:e_commerce_poc/repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatefulWidget {
  final Category category;
  final AppDatabase appDatabase;

  const ProductListPage({
    Key key,
    this.category,
    this.appDatabase,
  }) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Category get category => widget.category;

  AppDatabase get appDatabase => widget.appDatabase;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String sortByValue = "Name";
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ProductListPageBloc(
        apiRepository: ApiRepository(apiClient: ApiClient(dioClient: Dio())),
        appDatabase: appDatabase,
      )
        ..add(ProductListPageStarted(category)),
      child: BlocBuilder<ProductListPageBloc, ProductListPageState>(builder: (context, state) {
        if (state is ProductListPageLoading) {
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
        if (state is ProductListPageLoaded) {
          return DashboardPage(
            [
              MyAppBar(_scaffoldKey),
              StreamBuilder(
                stream: appDatabase.productDao.getProductsByCategoryId(category.id, sortByValue),
                builder: (context, snapshot) =>
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                            _MyListItem(
                              snapshot.data[index],
                              index,
                            ),
                        childCount: snapshot.hasData ? snapshot.data.length : 0,
                      ),
                    ),
              ),
            ],
            state.productListContent['Menu'],
            _scaffoldKey,
            Card(
              color: Colors.white,
              shadowColor: Colors.grey,
              elevation: 10,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Colors.white,
                        splashColor: Colors.lightBlueAccent,
                        onPressed: () => {},
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Text(
                          'Filters',
                          style: TextStyle(color: Colors.lightBlueAccent, fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: DropdownButton<String>(
                          value: sortByValue,
                          focusColor: Colors.lightBlueAccent,
                          icon: Icon(Icons.sort),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.lightBlueAccent, fontSize: 18),
                          onChanged: (sortBy) {
                            setState(() {
                              sortByValue = sortBy;
                              debugPrint('$sortByValue');
                            });
                          },
                          isExpanded: false,
                          underline: Container(),
                          items: <String>['Name', 'Most Viewed', 'Most Ordered', 'Most Shared'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return DashboardPage([
          MyAppBar(_scaffoldKey),
          SliverFillRemaining(
            child: Center(
              child: Text('Something went wrong!'),
            ),
          )
        ], List(), _scaffoldKey, null);
      }),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final Product listItem;
  final int index;

  const _MyListItem(this.listItem, this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.lightBlueAccent,
      elevation: 10,
      child: InkWell(
        splashColor: Colors.blue,
//        onTap: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductListPage(listItem.categories)))},
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
                listItem.name,
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
