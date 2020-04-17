import 'dart:convert';

import 'package:flutter/material.dart';

class Language {
  String name;
  Locale locale;
  String direction;
  Map<String,dynamic> content;

  Language({
    this.name,
    this.locale,
    this.direction,
    this.content
  });

  factory Language.fromJsonString(String data) {
    Map<String,dynamic> _temp = json.decode(data);
    return Language.fromJson(_temp);
  }

  factory Language.fromJson(Map<String,dynamic> data) {
    return Language(
      name      : data['name'],
      locale    : Locale(data['locale']),
      content   : data['content'],
      direction : data['direction'],
    );
  }

  String toJsonString () {
    return json.encode(toMap());
  }

  Map<String,dynamic> toMap() {
    return {
      'name'      : name,
      'locale'    : locale.toString(),
      'content'   : content,
      'direction' : direction,
    };
  }
}