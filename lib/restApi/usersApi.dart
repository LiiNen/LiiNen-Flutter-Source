import 'dart:convert';
import 'package:http/http.dart' as http;

import 'restApi.dart';

getUsersById({required userId}) async {
  var query = '/$userId';

  var response = await http.get(Uri.parse('$baseUrl$pathUsers$query'));

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    return responseBody;
  } else {
    return null;
  }
}

patchUsers({required userId, name='test'}) async {
  var query = '/$userId';
  var requestBody = Map();
  requestBody['name'] = name;

  var response = await http.patch(Uri.parse('$baseUrl$pathUsers$query'),
      body: requestBody, headers: authToken);

  if(response.statusCode == 200) {
    return true;
  }
  else return false;
}