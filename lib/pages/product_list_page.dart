import 'package:dio/dio.dart';
import 'package:e_commerce_poc/blocs/product_list/product_list_page_bloc.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/filter_type.dart';
import 'package:e_commerce_poc/database/model/filter_value.dart';

import 'package:e_commerce_poc/pages/dashboard_page.dart';
import 'package:e_commerce_poc/pages/product_detail_page.dart';
import 'package:e_commerce_poc/repository/api_client.dart';
import 'package:e_commerce_poc/repository/api_repository.dart';
import 'package:flutter/cupertino.dart';
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

  Map<FilterType, List<FilterValue>> filterMap;

  Map<String, List<FilterValue>> selectedFilterMap = Map();

  List<FilterValue> filters = List();

  FilterType filterType;

  @override
  void initState() {
    super.initState();
    _getFilterValues();
  }

  _getFilterValues() async {
    final map = await appDatabase.variantDao.getFiltersByCategory(category.id);
    setState(() {
      filterMap = map;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListPageBloc(
        apiRepository: ApiRepository(apiClient: ApiClient(dioClient: Dio())),
        appDatabase: appDatabase,
      )..add(ProductListPageStarted(category)),
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
                stream: appDatabase.productDao.getProductsByCategoryIdBySortAndFilters(category.id, sortByValue, selectedFilterMap),
                builder: (context, AsyncSnapshot<List<Product>> snapshot) => SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _MyListItem(
                      snapshot.data[index],
                      index,
                      appDatabase,
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
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FilterBottomSheet(
                                filterMap,
                                (selectedFilterMap) {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    this.selectedFilterMap = selectedFilterMap;
                                  });
                                },
                              ),
                            ),
                          );
                        },
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

class FilterBottomSheet extends StatefulWidget {
  final Map<FilterType, List<FilterValue>> filterMap;

  final void Function(Map<String, List<FilterValue>>) onFilterValueTap;

  const FilterBottomSheet(this.filterMap, this.onFilterValueTap, {Key key}) : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  Map<FilterType, List<FilterValue>> get filterMap => widget.filterMap;

  Function get onFilterValueTap => widget.onFilterValueTap;

  List<FilterType> filterType;

  List<FilterValue> filterValue;

  Map<String, List<FilterValue>> mapSelectedFilter = Map();

  @override
  void initState() {
    super.initState();
    filterMap.forEach((key, value) {
      if (key.selectedCount > 0) {
        mapSelectedFilter[key.filterName] = value.where((element) => element.selected).toList();
      }
    });
    filterType = filterMap.keys.toList();
    filterType = filterType.map((e) {
      e.selected = false;
      return e;
    }).toList();
    filterType[0].selected = true;
    _setFilterValue(filterMap.keys.toList()[0]);
  }

  _setFilterValue(FilterType key) {
    setState(() {
      filterValue = filterMap[key];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        enableDrag: false,
        onClosing: () {},
        backgroundColor: Colors.white,
        builder: (BuildContext buildContext) {
          return Container(
            padding: EdgeInsets.only(top: 25),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  height: 60,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Filters',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 2,
                  height: 3,
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Color(0X66E6E6E6),
                          child: ListView.separated(
                            padding: EdgeInsets.all(0),
                            itemBuilder: (buildContext, index) {
                              return InkWell(
                                splashColor: Color(0X66E6E6E6),
                                onTap: () {
                                  setState(() {
                                    final tmpList = filterType.map((e) {
                                      e.selected = false;
                                      return e;
                                    }).toList();
                                    filterType.clear();
                                    filterType.addAll(tmpList);
                                    filterType[index].selected = true;
                                    _setFilterValue(filterType[index]);
                                  });
                                  print('Selected Index $index');
                                },
                                child: Container(
                                  color: filterType[index].selected ? Colors.white : Color(0X00000000),
                                  height: 60,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          filterType[index].filterName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      filterType[index].selectedCount > 0
                                          ? Text(
                                              filterType[index].selectedCount.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (buildContext, index) => Divider(
                              color: Color(0XFFC0C0C0),
                              thickness: 1,
                              height: 1,
                            ),
                            itemCount: filterType != null ? filterType.length : 0,
                            shrinkWrap: false,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.separated(
                            padding: EdgeInsets.all(0),
                            itemBuilder: (buildContext, index) {
                              return InkWell(
                                splashColor: Colors.grey,
                                onTap: () {
                                  setState(() {
                                    filterValue[index].selected = !filterValue[index].selected;
                                  });
                                  FilterType selectedFilterType = filterType.singleWhere((element) => element.selected, orElse: () => null);
                                  if (mapSelectedFilter.containsKey(selectedFilterType.filterName)) {
                                    List<FilterValue> selectedFilters = mapSelectedFilter[selectedFilterType.filterName];
                                    if (filterValue[index].selected) {
                                      if (selectedFilters == null) selectedFilters = List<FilterValue>();

                                      selectedFilters.add(filterValue[index]);

                                      setState(() {
                                        filterType = filterType.map((e) {
                                          if (e.selected) {
                                            e.selectedCount += 1;
                                          }
                                          return e;
                                        }).toList();
                                      });
                                      mapSelectedFilter[selectedFilterType.filterName] = selectedFilters;
                                    } else {
                                      selectedFilters.remove(filterValue[index]);
                                      setState(() {
                                        filterType = filterType.map((e) {
                                          if (e.selected) {
                                            e.selectedCount -= 1;
                                          }
                                          return e;
                                        }).toList();
                                      });
                                      mapSelectedFilter[selectedFilterType.filterName] = selectedFilters;
                                    }
                                  } else {
                                    setState(() {
                                      filterType = filterType.map((e) {
                                        if (e.selected) {
                                          e.selectedCount += 1;
                                        }
                                        return e;
                                      }).toList();
                                    });
                                    mapSelectedFilter[selectedFilterType.filterName] = [filterValue[index]];
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        child: Icon(
                                          Icons.check,
                                          size: 24,
                                          color: filterValue[index].selected ? Colors.blue : Colors.grey,
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                      ),
                                      Expanded(
                                        child: Text(
                                          filterValue[index].name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      filterValue[index].count > 0
                                          ? Text(
                                              filterValue[index].count.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (buildContext, index) => Divider(
                              color: Color(0XFFC0C0C0),
                              thickness: 1,
                              height: 1,
                            ),
                            itemCount: filterValue != null ? filterValue.length : 0,
                            shrinkWrap: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 2,
                  height: 3,
                ),
                Container(
                  height: 60,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
//                            mapSelectedFilter = Map();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: double.infinity,
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        thickness: 2,
                        width: 2,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => onFilterValueTap(mapSelectedFilter),
                          child: Container(
                            height: double.infinity,
                            child: Center(
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _MyListItem extends StatelessWidget {
  final Product listItem;
  final int index;
  final AppDatabase appDatabase;

  const _MyListItem(this.listItem, this.index, this.appDatabase, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.lightBlueAccent,
      elevation: 10,
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailPage(listItem, appDatabase)))},
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
