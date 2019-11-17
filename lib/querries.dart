
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:app_flutter/env.dart';
import 'package:app_flutter/results.dart';

Future<Responses> fetchPost(String location, String choose) async {
  final response =
  await http.get('https://api.foursquare.com/v2/venues/search?client_id='+clientId+'&client_secret='+clientSecret+'&v=20191119&near='+location+'&query='+choose);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Responses.fromJson(json.decode(response.body));
    //print(json.decode(response.body));

  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}