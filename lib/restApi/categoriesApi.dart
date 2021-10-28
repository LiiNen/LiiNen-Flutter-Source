import 'dart:convert';
import 'package:http/http.dart' as http;

import 'restApi.dart';

getCategories() async {

  var response = await http.get(Uri.parse('$baseUrl$pathCategories'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  } else {
    print('error');
    return null;
  }
}