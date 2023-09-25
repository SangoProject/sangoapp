// import 'package:proj4dart/proj4dart.dart';
//
// void main() {
//   // 좌표계 변환 설정
//   var _tuple_utmk_google = ProjectionTuple(
//     fromProj: Projection.parse(
//         '+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs'),
//     toProj: Projection.parse('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'),
//   );
//
//   // detail 리스트의 좌표를 변환하고 출력
//   for (int index = 0; index < detail.length; index++) {
//     var utmkX = detail[index]['x'];
//     var utmkY = detail[index]['y'];
//
//     // UTMK 좌표를 Google 좌표로 변환
//     var utmkPoint = Point(utmkX, utmkY);
//     var googlePoint = _tuple_utmk_google.forward(utmkPoint);
//
//     // 변환된 Google 좌표 출력
//     print('Point $index - Google X: ${googlePoint.x}, Google Y: ${googlePoint.y}');
//   }
// }