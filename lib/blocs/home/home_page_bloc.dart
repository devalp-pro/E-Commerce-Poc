import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/dao/category_dao.dart';
import 'package:e_commerce_poc/database/dao/product_dao.dart';
import 'package:e_commerce_poc/database/dao/ranking_dao.dart';
import 'package:e_commerce_poc/repository/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final CategoryDao categoryDao;
  final ProductDao productDao;
  final RankingDao rankingDao;
  final ApiRepository apiRepository;

  HomePageBloc({@required this.categoryDao, @required this.productDao, @required this.rankingDao, @required this.apiRepository})
      : assert(categoryDao != null),
        assert(productDao != null),
        assert(rankingDao != null),
        assert(apiRepository != null),
        super(HomePageLoading());

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    if (event is HomePageStarted) {
      yield* _mapLoadParentCategoryList();
    }
  }

  Stream<HomePageState> _mapLoadParentCategoryList() async* {
    yield HomePageLoading();
    try {
      DataBean dataBean = await apiRepository.getData();
      if (dataBean != null) {
        await categoryDao.insertAllCategory(dataBean);
        await productDao.insertAllProducts(dataBean);
        await rankingDao.insertAllRankings(dataBean);
      }
      Map<String, dynamic> homeContent = Map();
      List<Category> parentCatList = await categoryDao.getCategoryWithSubCategory();
      homeContent["Categories"] = parentCatList;
      yield HomePageLoaded(homeContent);
    } catch (ex) {
      debugPrint(ex);
      yield HomePageError();
    }
  }
}
