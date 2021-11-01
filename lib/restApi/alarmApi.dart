import 'dart:convert';
import 'package:http/http.dart' as http;

import 'restApi.dart';

getAlarmCount({required String userId}) async {
  String query = '/user/$userId/count';
  var response = await http.get(Uri.parse('$baseUrl$pathAlarm$query'), headers: authToken);

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody['count'];
  }
  else return null;
}

getAlarm({required String userId}) async {
  String query = '/user/$userId';
  var response = await http.get(Uri.parse('$baseUrl$pathAlarm$query'), headers: authToken);

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  }
  return null;
}

readAlarm({required String userId}) async {

}

deleteAlarm({required String alarmId}) async {
  String query = '/$alarmId';
  var response = await http.post(Uri.parse('$baseUrl$pathAlarm$query'), headers: authToken);

  if(response.statusCode == 200) {
    return true;
  }
  return null;
}