import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpService {

  final route;
  final params;
  final body;

  String baseUrl = 'ec2-54-82-137-7.compute-1.amazonaws.com';

  HttpService({this.params, this.body, required this.route});

  Future<http.Response> postMethod() async {

    var url = Uri.http(baseUrl, route);

    final response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: params['data'],
      },
    );

    return response;
  }
}