import 'dart:convert';

import 'package:goal_bank/enums/app_string.dart';

class Currency{
  AppString name;
  String id;
  String symbol = '';

  Currency({
    this.name,
    this.id,
    this.symbol
  });

  factory Currency.fromJsonString(String data) {
    Map<String,dynamic> _temp = json.decode(data);
    return Currency.fromJson(_temp);
  }

  factory Currency.fromJson(Map<String,dynamic> data) {
    AppString _temp;

    if (data['name'] is String) {
      if (data['name'] == '${AppString.CURRENCY_USD}') {
        _temp = AppString.CURRENCY_USD;
      } else if (data['name'] == '${AppString.CURRENCY_EU}') {
        _temp = AppString.CURRENCY_EU;
      } else if (data['name'] == '${AppString.CURRENCY_HRN}') {
        _temp = AppString.CURRENCY_HRN;
      } else _temp = AppString.CURRENCY_USD;
    } else if (data['name'] is AppString) {
      _temp = data['name'];
    } else _temp = AppString.CURRENCY_USD;

    return Currency(
      id     : data['id'],
      name   : _temp,
      symbol : data['symbol'],
    );
  }

  String toJsonString () {
    return json.encode(toMap());
  }


  Map<String,dynamic> toMap() {
    return {
      'id'     : id,
      'name'   : '$name',
      'symbol' : symbol,
    };
  }
}

Map<String, dynamic> dollar = {
  'id': '1',
  'name': AppString.CURRENCY_USD,
  'symbol': '\$'
};

Map<String, dynamic> euro = {
  'id': '2',
  'name': AppString.CURRENCY_EU,
  'symbol': '€'
};

Map<String, dynamic> hryvnia = {
  'id': '3',
  'name': AppString.CURRENCY_HRN,
  'symbol': '₴'
};