import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tatsam/Utils/app_preferences/app_preferences.dart';
import 'package:tatsam/Utils/app_preferences/prefrences_key.dart';
import 'package:tatsam/Utils/constants/strings.dart';
import 'package:tatsam/Utils/log_utils/log_util.dart';
import 'package:tatsam/service/exception/exception.dart';
import 'package:tatsam/service/network/network_string.dart';

//This Class is not complete, under modification

class NetworkAPICall {
  static final NetworkAPICall _networkAPICall = NetworkAPICall._internal();

  factory NetworkAPICall() {
    return _networkAPICall;
  }

  NetworkAPICall._internal();

  Future<dynamic> post(
    String url,
    dynamic body, {
    bool isBaseUrl = true,
    Map<String, String>? headers,
    bool isCallBackUrl = false,
  }) async {
    var client = http.Client();
    try {
      late String fullURL;
      late Map<String, String> header;
      late String token;
      token = AppPreference().getStringData(PreferencesKey.userToken) ?? '';
      if (isBaseUrl) {
        fullURL = baseURL + url;
        header = {'Authorization': 'Bearer $token'};
      } else {
        fullURL = url;
        header = {'Authorization': 'Bearer $token'};
      }

      LogUtils.showLogs(message: fullURL, tag: 'API Url');
      LogUtils.showLogs(message: '$header', tag: 'API header');
      LogUtils.showLogs(message: '$body', tag: 'API body');

      var uri = Uri.parse(fullURL);

      var response = await http
          .post(uri, body: body, headers: header)
          .timeout(const Duration(seconds: 30));
      LogUtils.showLogs(
          message: response.statusCode.toString(), tag: 'Response statusCode');
      return checkResponse(response);
    } catch (exception) {
      client.close();
      throw AppException.exceptionHandler(exception);
    }
  }

  Future<dynamic> patch(
    String url,
    dynamic body, {
    bool isBaseUrl = true,
    Map<String, String>? headers,
  }) async {
    var client = http.Client();
    try {
      late String fullURL;
      late Map<String, String> header;
      late String token;
      token = AppPreference().getStringData(PreferencesKey.userToken) ?? '';
      if (isBaseUrl) {
        fullURL = baseURL + url;
        header = {'Authorization': 'Bearer $token'};
      } else {
        fullURL = url;
        header = {'Authorization': 'Bearer $token'};
      }

      LogUtils.showLogs(message: fullURL, tag: 'API Url');
      LogUtils.showLogs(message: '$header', tag: 'API header');
      LogUtils.showLogs(message: '$body', tag: 'API body');

      var uri = Uri.parse(fullURL);

      var response = await http
          .patch(uri, body: body, headers: header)
          .timeout(const Duration(seconds: 30));
      LogUtils.showLogs(
          message: response.statusCode.toString(), tag: 'Response statusCode');
      return checkResponse(response);
    } catch (exception) {
      client.close();
      throw AppException.exceptionHandler(exception);
    }
  }

  Future<dynamic> get(String url) async {
    final client = http.Client();
    try {
      String fullURL = baseURL + url;
      late String token;
      token = AppPreference().getStringData(PreferencesKey.userToken) ?? '';
      Map<String, String> header = {'Authorization': 'Bearer $token'};

      LogUtils.showLogs(message: fullURL, tag: 'API Url');
      LogUtils.showLogs(message: '$header', tag: 'API header');

      var uri = Uri.parse(fullURL);
      var response = await client
          .get(uri, headers: header)
          .timeout(const Duration(seconds: 30));

      // LogUtils.showLogs(message: response.body, tag: 'Response Body');
      LogUtils.showLogs(
          message: response.statusCode.toString(), tag: 'Response statusCode');

      return checkResponse(response);
    } catch (exception) {
      client.close();
      throw AppException.exceptionHandler(exception);
    }
  }

  Future<dynamic> delete(String url) async {
    var client = http.Client();
    try {
      String fullURL = baseURL + url;
      late String token;
      token = AppPreference().getStringData(PreferencesKey.userToken) ?? '';
      Map<String, String> header = {'Authorization': 'Bearer $token'};

      LogUtils.showLogs(message: fullURL, tag: 'API Url');
      LogUtils.showLogs(message: '$header', tag: 'API header');

      var uri = Uri.parse(fullURL);
      var response = await client.delete(uri, headers: header);

      LogUtils.showLogs(
          message: response.statusCode.toString(), tag: 'Response statusCode');

      return checkResponse(response);
    } catch (exception, stackTrace) {
      client.close();
      throw AppException.exceptionHandler(exception, stackTrace);
    }
  }

  Future<dynamic> multiPartPatchrequest(
      String url, Map<String, String> body, File image) async {
    var client = http.Client();
    try {
      String fullURL = baseURL + url;
      late String token;
      token = AppPreference().getStringData(PreferencesKey.userToken) ?? '';
      Map<String, String> header = {'Authorization': 'Bearer $token'};

      LogUtils.showLogs(message: fullURL, tag: 'API Url');
      LogUtils.showLogs(message: header.toString(), tag: 'API header');
      LogUtils.showLogs(message: body.toString(), tag: 'API body');

      http.MultipartRequest request =
          http.MultipartRequest('PATCH', Uri.parse(fullURL));

      request.fields.addAll(body);

      request.headers.addAll(header);

      List<int> imageData = await image.readAsBytes();

      request.files.add(
        http.MultipartFile.fromBytes('file', imageData),
      );

      http.StreamedResponse streamedResponse = await request.send();

      http.Response response = await http.Response.fromStream(streamedResponse);

      LogUtils.showLogs(
        message: streamedResponse.statusCode.toString(),
        tag: 'Response statusCode',
      );

      LogUtils.showLogs(
          message: response.body.toString(), tag: 'Response Body');

      return checkResponse(response);
    } catch (exception) {
      client.close();
      rethrow;
    }
  }

  Future<dynamic> multiPartPostRequest(
      String url, Map<String, String> body, File image) async {
    var client = http.Client();
    try {
      String fullURL = baseURL + url;
      late String token;
      token = AppPreference().getStringData(PreferencesKey.userToken) ?? '';
      var header = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      LogUtils.showLogs(message: fullURL, tag: 'API Url');
      log('API body: $body');
      log('API header: $header');

      var request = http.MultipartRequest('POST', Uri.parse(fullURL));

      request.fields.addAll(body);

      request.headers.addAll(header);

      request.files
          .add(await http.MultipartFile.fromPath('file', image.absolute.path));

      print("request.fields => ${request.fields}");

      http.StreamedResponse streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      print("Response code of Login API ==> ${response.statusCode}");

      if (response.statusCode == 200) {
        print(response.body);
        return checkResponse(response);
      } else {
        print(response.reasonPhrase);
      }
    } catch (exception) {
      client.close();
      rethrow;
    }
  }

  dynamic checkResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        try {
          var json = jsonDecode(response.body);
          LogUtils.showLogs(message: '$json', tag: 'API RESPONSE');
          if (json is List<dynamic>) {
            return json;
          }
          if (json['status'] == 'error') {
            throw AppException(
                message: json['message'], errorCode: response.statusCode);
          }
          return json;
        } catch (e, stackTrace) {
          throw AppException.exceptionHandler(e, stackTrace);
        }
      case 400:
        var json = jsonDecode(response.body);
        throw AppException(
            message: json['message'][1], errorCode: json['statusCode']);
      case 401:
        throw AppException(
          message: ResponseString.unauthorized,
          errorCode: response.statusCode,
        );
      case 500:
      case 502:
        throw AppException(
            message: "Looks like our server is down for maintenance,"
                r'''\n\n'''
                "Please try again later.",
            errorCode: response.statusCode);
      default:
        throw AppException(
            message: "Unable to communicate with the server at the moment."
                r'''\n\n'''
                "Please try again later",
            errorCode: response.statusCode);
    }
  }
}
