import 'dart:convert';
import 'package:http/http.dart' as http;

const int maxId = 1010;
const String geoCodingApiRoute =
    "https://geocoding-api.open-meteo.com/v1/search";

class GeoCoding {
  final List<Map<String, dynamic>> geoData;

  GeoCoding({
    required this.geoData,
  });

  factory GeoCoding.fromJson(Map<String, dynamic>? json) {
    if (json == null || json['results'] == null) {
      return GeoCoding(geoData: []);
    }
    return GeoCoding(
      geoData: List<Map<String, dynamic>>.from(json['results']),
    );
  }
}

Future<GeoCoding> fetchGeoCoding(String cityName) async {
  final res = await http.get(Uri.parse('$geoCodingApiRoute?name=$cityName'));
  if (res.statusCode == 200) {
    return GeoCoding.fromJson(jsonDecode(res.body));
  } else {
    throw Exception('Failed to Load GeoCoding');
  }
}
