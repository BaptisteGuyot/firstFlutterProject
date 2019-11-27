
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:app_flutter/env.dart';
import 'package:app_flutter/results.dart';
import 'package:toast/toast.dart';

Future<Responses> fetchPost(String location, String choose, BuildContext context) async {
  final response =
  await http.get('https://api.foursquare.com/v2/venues/search?client_id='+clientId+'&client_secret='+clientSecret+'&v=20191119&near='+location+'&query='+choose);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Responses.fromJson(json.decode(response.body));
    //print(json.decode(response.body));

  } else {
    if(response.statusCode == 429) {
      Toast.show("Quota de requête atteint", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
    }
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
Future<ReponsesDetails> getVenueDetails(Results result, BuildContext context) async {
  final response =
  await http.get('https://api.foursquare.com/v2/venues/'+result.id+'?client_id='+clientId+'&client_secret='+clientSecret+'&v=20191119');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return ReponsesDetails.fromJson(json.decode(response.body));
    //print(json.decode(response.body));

  } else{
    if(response.statusCode == 429) {
      Toast.show("Quota de requête atteint", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
    }
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
Future<Map<String, dynamic>> getVenuesPhotos(String id) async {
  final response = await http.get('https://api.foursquare.com/v2/venues/'+id+'/photos?client_id='+clientId+'&client_secret='+clientSecret+'&v=20191119');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    print("hey");
    print(response.body);
    return json.decode(response.body);
    //print(json.decode(response.body));

  } else {

    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}