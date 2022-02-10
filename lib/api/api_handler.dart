import 'package:dio/dio.dart';

class ApiHandler {
  static Future<dynamic> apiCall() async {
    try {
      var response = await Dio()
          .get('https://my.api.mockaroo.com/users.json?key=aa22fa40');
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
