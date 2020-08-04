import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce_poc/blocs/product_detail/product_detail_page_bloc.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/product_with_details.dart';
import 'package:e_commerce_poc/pages/dashboard_page.dart';
import 'package:e_commerce_poc/repository/api_client.dart';
import 'package:e_commerce_poc/repository/api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final AppDatabase appDatabase;

  const ProductDetailPage(this.product, this.appDatabase, {Key key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Product get product => widget.product;

  AppDatabase get appDatabase => widget.appDatabase;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey priceUpdateKey = GlobalKey();

  ProductWithDetails productWithDetails;

  Variant selectedSizeVariant;

  Variant selectedColorVariant;

  HtmlUnescape htmlUnescape = HtmlUnescape();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailPageBloc(
        apiRepository: ApiRepository(apiClient: ApiClient(dioClient: Dio())),
        appDatabase: appDatabase,
      )..add(ProductDetailPageStarted(product)),
      child: BlocBuilder<ProductDetailPageBloc, ProductDetailPageState>(builder: (context, state) {
        if (state is ProductDetailPageLoading) {
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
        if (state is ProductDetailPageLoaded) {
          if (selectedColorVariant == null) selectedColorVariant = state.productWithDetails.colorVariants[0];

          return DashboardPage(
            [
              MyAppBar(_scaffoldKey),
              SliverList(
                key: priceUpdateKey,
                delegate: SliverChildListDelegate([
                  Container(
                    color: Colors.black12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
//                          key: priceUpdateKey,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.width,
                                child: Icon(
                                  Icons.image,
                                  size: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: RichText(
                                  text: TextSpan(
                                    text: "${state.productWithDetails.product.name} - (${selectedColorVariant != null ? selectedColorVariant.color : ""})",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  htmlUnescape.convert("&#x20B9; " + (selectedSizeVariant != null ? selectedSizeVariant.price.toString() : "")),
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Select Color',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: InkResponse(
                                        highlightShape: BoxShape.rectangle,
                                        onTap: () {
                                          setState(() {
                                            this.selectedColorVariant = state.productWithDetails.colorVariants[index];
                                          });
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: state.productWithDetails.colorVariants[index].color == 'Blue'
                                                ? Colors.blue
                                                : state.productWithDetails.colorVariants[index].color == 'Black'
                                                    ? Colors.black
                                                    : state.productWithDetails.colorVariants[index].color == 'Red'
                                                        ? Colors.red
                                                        : state.productWithDetails.colorVariants[index].color == 'White'
                                                            ? Colors.white
                                                            : state.productWithDetails.colorVariants[index].color == 'Yellow'
                                                                ? Colors.yellow
                                                                : state.productWithDetails.colorVariants[index].color == 'Grey'
                                                                    ? Colors.grey
                                                                    : state.productWithDetails.colorVariants[index].color == 'Light Blue'
                                                                        ? Colors.lightBlue
                                                                        : state.productWithDetails.colorVariants[index].color == 'Green'
                                                                            ? Colors.green
                                                                            : Colors.greenAccent,
                                            border: Border.all(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: state.productWithDetails.colorVariants.length,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Select Size',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                height: 80,
                                child: StreamBuilder<List<Variant>>(
                                    stream: appDatabase.productDao.getProductSizeVariantByColor(product.id, selectedColorVariant.color),
                                    builder: (context, AsyncSnapshot<List<Variant>> snapshot) {
                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                        if (snapshot.hasData && selectedSizeVariant == null) {
                                          setState(() {
                                            selectedSizeVariant = snapshot.data[0];
                                          });
                                        }
                                      });

                                      return ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Material(
                                            color: Colors.transparent,
                                            child: InkResponse(
                                              borderRadius: BorderRadius.all(Radius.circular(50)),
                                              highlightShape: BoxShape.circle,
                                              onTap: () {
                                                setState(() {
                                                  selectedSizeVariant = snapshot.data[index];
                                                });
                                              },
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.transparent,
                                                  border: Border.all(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    snapshot.data[index].size.toString(),
                                                    style: TextStyle(color: Colors.blue),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: snapshot.hasData ? snapshot.data.length : 0,
                                      );
                                    }),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              )
            ],
            state.productListContent['Menu'],
            _scaffoldKey,
            null,
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
