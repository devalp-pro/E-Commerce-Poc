import 'package:dio/dio.dart';
import 'package:e_commerce_poc/bean/data_bean.dart';
import 'package:flutter/material.dart';

class ApiClient {
  static const baseUrl = 'https://stark-spire-93433.herokuapp.com';
  final Dio dioClient;

  ApiClient({
    @required this.dioClient,
  }) : assert(dioClient != null){
    dioClient.options = BaseOptions(baseUrl: baseUrl);
    dioClient.interceptors.add(LogInterceptor(responseBody: false));
  }

  Future<Response> getData() {
    return dioClient.get('/json');
  }

}