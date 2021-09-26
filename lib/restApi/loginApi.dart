import 'dart:convert';
import 'package:http/http.dart' as http;

import 'restApi.dart';

signUpApi({required String email, required String password}) async {
  var requestBody = Map();
  requestBody['email'] = email;
  requestBody['password'] = password;

  var response = await http.post(Uri.parse('$baseUrl$pathSignUp'), body: requestBody);

  if(response.statusCode == 200) {
    var responseBody = json.decode(response.body);
    print(responseBody['token']);
  } else {
    print('error');
    return null;
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
  } else {
    print('error');
    return null;
  }
}