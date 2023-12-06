// 재난 정보 API를 가져오고 파싱해서 필요한 정보를 리스트로 만들어주는 역할
import 'dart:convert' as convert;
import 'package:sangoproject/screens/disaster/disasterMsg.dart';
import 'package:http/http.dart' as http;

class DisasterRepository {
  var apiKey = "5xDdK75doweBoYGR%2F3fMP7mx%2FNsKTlgvp%2FakCm7XgbFIe7kG71H8uq4YJnDY5abp0SoRpc4u%2BF5G8UL6UafQzQ%3D%3D";

  Future<List<DisasterMsg>?> loadDisaster() async {
    // 재난 정보를 30개 불러옴.
    String baseUrl = "http://apis.data.go.kr/1741000/DisasterMsg3/getDisasterMsg1List?ServiceKey=$apiKey&type=json&pageNo=1&numOfRows=30";
    final response = await  http.get(Uri.parse(baseUrl));

    // 데이터 불러오는 것을 성공했을 경우.
    if (response.statusCode == 200) {

      final json = convert.utf8.decode(response.bodyBytes);

      Map<String, dynamic> jsonResult = convert.json.decode(json);

      // 필요한 데이터 그룹이 있다면
      if (jsonResult['DisasterMsg'] != null) {
        List<dynamic> jsonDisaster = jsonResult['DisasterMsg'];
        if(jsonDisaster[1]['row'] != null) {
          // 리스트로 만듦.
          List<dynamic> list = jsonDisaster[1]['row'];

          // map을 통해 DisasterMsg 형태로 item을 => DisasterMsg.fromJson으로 전달
          return list.map<DisasterMsg>((item) => DisasterMsg.fromJson(item)).toList();
        }
      }
    }
  }
}