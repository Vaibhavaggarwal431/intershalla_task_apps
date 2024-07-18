import 'package:flutter/material.dart';
import 'package:intershalla_task_app/core/api/api_method.dart';
import 'package:intershalla_task_app/core/api/constant.dart';
import 'package:intershalla_task_app/core/model/searchmodel.dart';

class ApiInterface extends ChangeNotifier{
  Future<SearchModel> search(
  ) async {
  return getApiResponse<SearchModel>(
  endpoint: searchRoute,
  fromJson: (data) => SearchModel.fromJson(data),
  );
  }
}