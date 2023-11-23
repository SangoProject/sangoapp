import 'dart:convert' as convert;
import 'package:sangoproject/screens/disaster/disasterMsg.dart';
import 'package:http/http.dart' as http;

class DisasterRepository {
  var apiKey = "5xDdK75doweBoYGR%2F3fMP7mx%2FNsKTlgvp%2FakCm7XgbFIe7kG71H8uq4YJnDY5abp0SoRpc4u%2BF5G8UL6UafQzQ%3D%3D";

  Future<List<DisasterMsg>?> loadDisaster() async {
    String baseUrl = "http://apis.data.go.kr/1741000/DisasterMsg3/getDisasterMsg1List?ServiceKey=$apiKey&type=json&pageNo=1&numOfRows=30";
    final response = await  http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final json = convert.utf8.decode(response.bodyBytes);

      Map<String, dynamic> jsonResult = convert.json.decode(json);

      if (jsonResult['DisasterMsg'] != null) {
        List<dynamic> jsonDisaster = jsonResult['DisasterMsg'];

        if(jsonDisaster[1]['row'] != null) {
          List<dynamic> list = jsonDisaster[1]['row'];

          return list.map<DisasterMsg>((item) => DisasterMsg.fromJson(item)).toList();
        }
      }
    }
  }
}