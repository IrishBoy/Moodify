// ignore: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'vars.dart'; // Import the DataModel

// Provider class to manage the list of data points
class DataList with ChangeNotifier {
  List<DataModel> _dataList = [];

  List<DataModel> get dataList => _dataList.toList();

  // Add data to the list
  void addData(DataModel data) {
    _dataList.add(data);
    _saveDataList();
    notifyListeners();
  }

  void _saveDataList() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _dataList.map((e) => e.toJson()).toList();
    await prefs.setStringList(
        'dataKey', data.map((e) => jsonEncode(e)).toList());
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final dataList = prefs.getStringList('dataKey');
    if (dataList != null) {
      _dataList =
          dataList.map((e) => DataModel.fromJson(jsonDecode(e))).toList();
      notifyListeners();
    }
  }
}
