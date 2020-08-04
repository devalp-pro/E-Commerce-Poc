import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/database/app_database.dart';
import 'package:e_commerce_poc/database/model/categories_with_sub_category.dart';
import 'package:e_commerce_poc/repository/api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final AppDatabase appDatabase;
  final ApiRepository apiRepository;

  HomePageBloc({@required this.appDatabase, @required this.apiRepository})
      : assert(appDatabase != null),
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
        await appDatabase.insertAllData(dataBean);
      }
      Map<String, dynamic> homeContent = Map();
      List<CategoriesWithSubCategory> parentCatList = await appDatabase.categoryDao.getCategoryWithSubCategory();
      homeContent["Categories"] = parentCatList;
      homeContent.addAll(await appDatabase.rankingDao.getRankingProducts());
      yield HomePageLoaded(homeContent);
    } on Exception catch (ex) {
      print(ex);
      yield HomePageError();
    }
  }
}
