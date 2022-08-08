import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:popular_people_app/helpers/constants.dart';

class ApiHelpers {
  ApiHelpers._();

  static makeGetRequest(
    String url, {
    Map<String, String>? headers,
  }) async {
    var uri = Uri.parse(url);
    var resp = {};
    log('Sending get request to $url');
    try {
      http.Response response = await get(uri, headers!);
      resp = responseCheck(response, resp);
    } on SocketException catch (e) {
      resp = {
        'status': false,
        'data': {'status': false, 'data': {}, 'message': e.message},
        'message': "No internet connection",
      };
    } on FormatException catch (e) {
      resp = {
        'status': false,
        'data': {'status': false, 'data': {}, 'message': e.message},
        'message': "Invalid response format",
      };
    } on TimeoutException catch (e) {
      resp = {
        'status': false,
        'data': {'status': false, 'data': {}, 'message': e.message},
        'message': "Connection timed out. Please try again later.",
      };
    } on Exception catch (e) {
      resp = {
        'status': false,
        'data': {'status': false, 'data': {}, 'message': e.toString()},
        'message': "Something went wrong. Please try again later.",
      };
    } catch (e) {
      resp = {
        'status': false,
        'data': {'status': false, 'data': {}, 'message': e.toString()},
        'message': "Something went wrong. Please try again later.",
      };
    }
    return resp;
  }

  static Map<dynamic, dynamic> responseCheck(
      http.Response response, Map<dynamic, dynamic> resp) {
    if (response.statusCode < 200 || response.statusCode > 226) {
      resp = {
        'status': false,
        'data': json.decode(response.body),
        'message': "unsuccessful",
      };
    } else {
      resp = {
        'status': true,
        'data': json.decode(response.body),
        'message': 'successful',
      };
    }
    return resp;
  }

  static Future<http.Response> get(Uri uri, Map<String, String> headers) async {
    http.Response response = await http
        .get(
          uri,
          headers: headers ?? {},
        )
        .timeout(const Duration(milliseconds: AppConstants.connectTimeout));
    if (kDebugMode) {
      log(response.body);
    }
    return response;
  }
}
