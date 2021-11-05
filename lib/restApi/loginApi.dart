import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_flutter_source/restApi/imageApi.dart';

import '../functionCollection.dart';
import 'restApi.dart';

signUpApi({required String name, required String email, required String password, required String introduce, required List<String> categories, required File profileImage}) async {

  var imageUrls = await postImage(image: profileImage, type: 'users');
  print('3. imageUrls');
  print(imageUrls);
  if(imageUrls == null) {
    print('error image');
    return false;
  }

  var temp = Map();
  temp['name'] = name;
  temp['email'] = email;
  temp['password'] = password;
  temp['introduce'] = introduce;
  temp['imageUrl'] = imageUrls[0];
  temp['categories'] = categories;

  var requestBody = json.encode(temp);
  print(requestBody);
  var response = await http.post(Uri.parse('$baseUrl$pathSignUp'),
    body: requestBody, headers: {'Content-type': 'application/json'});

  print(response.statusCode);

  if(response.statusCode == 200) {
    setToken(token: json.decode(response.body)['token']);
    return true;
  } else {
    print(response.body);
    // print('false');
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
    setToken(token: responseBody['token']);
    return true;
  } else {
    return false;
  }
}