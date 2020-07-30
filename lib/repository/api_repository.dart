import 'package:dio/dio.dart';
import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:e_commerce_poc/repository/api_client.dart';
import 'package:flutter/material.dart';

class ApiRepository {
  final ApiClient apiClient;

  ApiRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<DataBean> getData() async {
    Response dataResponse =  await apiClient.getData();
    if(dataResponse != null && dataResponse.statusCode == 200){
      return DataBean.fromJson(dataResponse.data);
    }
    return null;
  }
}
