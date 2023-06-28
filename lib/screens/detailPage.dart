import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class ApiExample {
  final String baseUrl = 'http://openapi.seoul.go.kr:8088';
  final String apiKey = '79564d655a7468693439717179677a'; // 인증키

  Future<void> fetchData() async {
    final endpoint = '/$apiKey/xml/SeoulGilWalkCourse/1/5/고덕산/고덕중학교/';
    final url = Uri.parse(baseUrl + endpoint);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final xmlDoc = xml.XmlDocument.parse(response.body);
      final resultList = xmlDoc.findAllElements('row');

      for (final result in resultList) {
        final title = result.findElements('COURSE_NAME').single.text;
        final distance = result.findElements('DISTANCE').single.text;

        print('Title: $title');
        print('Distance: $distance');
        print('----------------');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }
}

void main() {
  final apiExample = ApiExample();
  apiExample.fetchData();
}
