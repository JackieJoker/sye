import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class RealTimeCurrency {
  final Map<String, dynamic> data;

  RealTimeCurrency({required this.data});

  factory RealTimeCurrency.fromJson(Map<String, dynamic> json) {
    return RealTimeCurrency(data: json['data']);
  }

  static Future<RealTimeCurrency?> fetchCurrency(String baseCurrency) async {
    final response = await http
        .get(Uri.parse('https://freecurrencyapi.net/api/v2/latest?apikey=6b0e8720-6758-11ec-a0f8-ad20fa2df397&base_currency=' + baseCurrency));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return RealTimeCurrency.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.

      //This line is to make unit and widget testing without calling Firebase
      if(!Platform.environment.containsKey('FLUTTER_TEST')) {
        throw Exception('Failed to load Currencies.');
      }
    }
  }
}