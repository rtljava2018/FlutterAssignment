import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tcslocator/src/models/office_location_data.dart';

const String url = "https://www.tcs.com/content/dam/global-tcs/en/worldwide-json/worldwide-map-5-12.json";

Future<LocationResponse> fetchTcsLocatorData() async {
  final httpPackageUrl = Uri.https('tcs.com', '/content/dam/global-tcs/en/worldwide-json/worldwide-map-5-12.json');
  final response = await http.get(httpPackageUrl);
  //print(response);

  if (response.statusCode == 200) {
    return compute(parseResponse, response.body);
  } else {
    throw Exception(response.statusCode);
  }
}

LocationResponse parseResponse(String responseBody) {
  var result = json.decode(responseBody);
  var locationData=LocationResponse.fromJson(result);
  return locationData;
}
//testing
/*
void main() async {
  final httpPackageUrl = Uri.https('tcs.com', '/content/dam/global-tcs/en/worldwide-json/worldwide-map-5-12.json');
  final response = await http.get(httpPackageUrl);
  print(response);
  //final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return compute(parseCharacter, response.body);
  } else {
    throw Exception(response.statusCode);
  }
}*/
