import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:async';

import 'api_exception.dart';

class ApiBaseHelper {
  final String _baseUrl = "https://newsapi.org/v2/";
  final String _apiKey = "ae6c3c0f9d8e485a98fd70edcff81134";

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    var responseJson;
    try {
      final response =
          await http.get(_baseUrl + url + "?country=in&apiKey=$_apiKey");
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
