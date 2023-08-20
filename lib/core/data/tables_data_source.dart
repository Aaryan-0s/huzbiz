import 'dart:convert';

import 'package:huzbiz_app/model/table_details.dart';
import 'package:flutter/services.dart';

Future<List<TableDetails>> getTableDetailsLocal() async {
  final response = await rootBundle.loadString('test_data/data.json');
  final jsonList = await json.decode(response);

  final List<TableDetails> tableDetailsList = jsonList
      .map<TableDetails>(
        (json) => TableDetails.fromJson(json),
      )
      .toList();

  return Future.value(tableDetailsList);
}
