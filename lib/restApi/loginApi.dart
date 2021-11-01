import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../functionCollection.dart';
import 'restApi.dart';

signUpApi({required String name, required String email, required String password, required String introduce, required List<String> categories, required File profileImage}) async {
  var temp = Map();
  temp['name'] = name;
  temp['email'] = email;
  temp['password'] = password;
  temp['introduce'] = introduce;
  temp['categories'] = categories;

  var requestBody = json.encode(temp);

  // var response = await http.post(Uri.parse('$baseUrl$pathSignUp'), body: requestBody, headers: {'Content-type': 'application/json'});

  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl$pathSignUp'))
    ..headers['Content-type']='application/json'
    ..fields['name'] = name
    ..fields['email'] = email
    ..fields['password'] = password
    ..fields['introduce'] = introduce
    ..files.add(http.MultipartFile('image',
      profileImage.readAsBytes().asStream(),
      profileImage.lengthSync(),
      filename: 'image'
    ));
  for(String category in categories) {
    request.fields['categories'] = category;
  }


  var response = await request.send();

  print(response.statusCode);

  if(response.statusCode == 200) {
    response.stream.transform(utf8.decoder).listen((value) {
      setToken(token: json.decode(value)['token']);
    });
    return true;
  } else {
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
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