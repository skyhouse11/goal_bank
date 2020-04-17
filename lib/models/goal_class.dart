import 'dart:convert';
import 'dart:typed_data';

import 'package:goal_bank/enums/status_enum.dart';

class Goal {
  String id;
  String name;
  String photo;
  Uint8List photoFile;
  DateTime createDate;
  DateTime endDate;
  int currentSum;
  int neededSum;
  GoalStatus status;
  String symbol;

  Goal({
    this.name,
    this.photo,
    this.createDate,
    this.endDate,
    this.currentSum,
    this.neededSum,
    this.status,
    this.id,
    this.photoFile,
    this.symbol,
  });


  factory Goal.fromJsonString(String data) {
    Map<String,dynamic> _temp = json.decode(data);
    return Goal.fromJson(_temp);
  }

  factory Goal.fromJson(Map<String,dynamic> data) {
    GoalStatus _status;

    if (data['status'] == GoalStatus.FINISHED.toString()) {
      _status = GoalStatus.FINISHED;
    } else if (data['status'] == GoalStatus.ACTIVE.toString()) {
      _status = GoalStatus.ACTIVE;
    } else if (data['status'] == GoalStatus.FAILED.toString()) {
      _status = GoalStatus.FAILED;
    }

    if (data['current_sum'] > data['needed_sum']) {
      _status = GoalStatus.FINISHED;
    }

    return Goal(
      id        : data['id'],
      name      : data['name'],
      photo     : data['photo'],
      createDate: DateTime.parse(data['create_date']),
      endDate   : (data['end_date'] != null && data['end_date'] != 'null') ? DateTime.parse(data['end_date']) : null,
      currentSum: data['current_sum'],
      neededSum : data['needed_sum'],
      status    : _status,
      photoFile : base64Decode(data['photo']),
      symbol    : data['symbol'],
    );
  }


  String toJsonString () {
    return json.encode(toMap());
  }

  Map<String,dynamic> toMap() {
    return {
      'id'          : id,
      'name'        : name,
      'photo'       : photo,
      'create_date' : createDate.toString(),
      'end_date'    : endDate.toString(),
      'current_sum' : currentSum,
      'needed_sum'  : neededSum,
      'status'      : status.toString(),
      'symbol'      : symbol,
    };
  }
}

