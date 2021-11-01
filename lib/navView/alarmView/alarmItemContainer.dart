import 'package:flutter/material.dart';

class AlarmItemObject {
  String alarmId;
  String? thumbnailUrl;
  String context;
  int time;
  AlarmItemObject({
    required this.alarmId, this.thumbnailUrl, required this.context, required this.time
  });
}
