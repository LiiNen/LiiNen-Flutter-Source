import 'dart:convert';
import 'package:http/http.dart' as http;

import '../functionCollection.dart';
import 'restApi.dart';

signUpApi({required String name, required String email, required String password, required String introduce, required List<String> categories}) async {
  var temp = Map();
  temp['name'] = name;
  temp['email'] = email;
  temp['password'] = password;
  temp['image'] = '';
  temp['introduce'] = introduce;
  temp['categories'] = categories;
  var requestBody = json.encode(temp);
  print(requestBody);

  var response = await http.post(Uri.parse('$baseUrl$pathSignUp'), body: requestBody, headers: {'Content-type': 'application/json'});

  print(response.statusCode);
  print(response.body);
  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    print(responseBody['token']);
    setToken(token: responseBody['token']);
    return true;
  } else {
    print('error');
    return false;
  }
}

signInApi({required String email, required String password}) async {
  var requestBody = Map();
  requestBody['email'] = email;
  requestBody['password'] = password;

  var response = await http.post(Uri.parse('$baseUrl$pathSignIn'), body: requestBody);

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    print(responseBody['token']);
    setToken(token: responseBody['token']);
    return true;
  } else {
    print(response);
    return false;
  }
}