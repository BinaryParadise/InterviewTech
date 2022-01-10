import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/app_exception.dart';

import '../network_result.dart';
import '../model/timestamp.dart';

class NetworkDemo extends StatefulWidget {
  const NetworkDemo({Key? key}) : super(key: key);

  @override
  State<NetworkDemo> createState() => _NetworkDemoState();
}

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    err.error = AppException.create(err);
    super.onError(err, handler);
  }
}

class _NetworkDemoState extends State<NetworkDemo> {
  Dio dio = Dio();
  bool fetching = false;

  @override
  void initState() {
    super.initState();

    dio.options.connectTimeout = 30000;
    dio.options.baseUrl = 'http://api.m.taobao.com/';
    dio.interceptors.add(DioErrorInterceptor());
    fetchData();
  }

  Future<Result> fetchData() async {
    try {
      setState(() {
        fetching = true;
      });
      var response =
          await dio.get<Map>('rest/api3.do?api=mtop.common.getTimestamp');
      setState(() {
        fetching = false;
      });
      var r = Timestamp.fromJson(response.data as Map<String, dynamic>);
      print(r);
      return Result(0, r);
    } on DioError catch (e) {
      print(e);
      return Result(1000, null, msg: e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget current;
    current = Center(
      child: fetching
          ? const CircularProgressIndicator()
          : TextButton(
              onPressed: () {
                fetchData();
              },
              child: Text('execute()')),
    );
    current = Scaffold(
      appBar: AppBar(
        title: Text('Network'),
      ),
      body: current,
    );
    return current;
  }
}