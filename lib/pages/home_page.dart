import 'dart:ui';

import 'package:e_commerce_poc/blocs/home/home_page_bloc.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/categories_with_sub_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _MyAppBar(),
          BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              if (state is HomePageLoading) {
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is HomePageLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _MyListItem(
                      state.homeContent.values.toList()[index],
                      state.homeContent.keys.toList()[index],
                    ),
                    childCount: state.homeContent.length,
                  ),
                );
              }
              return SliverFillRemaining(
                child: Center(
                  child: Text('Something went wrong!'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final dynamic listItem;
  final String title;

  const _MyListItem(this.listItem, this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.headline6;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        (title == "Categories")
            ? Flexible(
                fit: FlexFit.loose,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blueAccent, Colors.lightBlue, Colors.lightBlueAccent],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        height: 120,
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: listItem.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                width: 120,
                                height: double.infinity,
                                child: Card(
                                  color: Colors.lightBlue,
                                  elevation: 10,
                                  shadowColor: Colors.blueAccent,
                                  child: InkWell(
                                    splashColor: Colors.deepOrange,
                                    onTap: () => {},
                                    child: Center(
                                      child: Text(
                                        (listItem[index] as CategoriesWithSubCategory).categories.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: LimitedBox(
                  maxHeight: 48,
                  child: Row(
                    children: [
                      AspectRatio(aspectRatio: 1, child: ColoredBox(color: Colors.black12)),
                      SizedBox(width: 24),
                      Expanded(child: Text(title, style: textTheme)),
                      SizedBox(width: 24),
                    ],
                  ),
                ),
              )
      ],
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        IconButton(
                          color: Colors.grey,
                          focusColor: Colors.lightBlue,
                          splashColor: Colors.lightBlue,
                          hoverColor: Colors.lightBlue,
                          highlightColor: Colors.lightBlue,
                          icon: Icon(
                            Icons.menu,
                          ),
                          onPressed: () => {},
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Products',
                              hintStyle: TextStyle(
                                color: Colors.blueGrey,
                                height: 1.3,
                              ),
                            ),
                            style: TextStyle(
                              height: 1.3,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pushNamed('/cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
