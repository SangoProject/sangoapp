// import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sangoproject/screens/course_data/courseInfo.dart';

class SearchDetailPage extends StatefulWidget{
// <<<<<<< HEAD
//   final CourseInfo data;
//   SearchDetailPage(this.data, {super.key});
// =======
  dynamic data; // 코스명, 시간, 거리, 난이도
  dynamic detail; // 포인트번호, 포인트명칭, x좌표, y좌표 (courseInfo.dart 참고)
  SearchDetailPage(this.data, this.detail);
// >>>>>>> 8d7508d47e012dfb24d939465f54721d5f5e233a
  @override
  State<StatefulWidget> createState(){
    return _SearchDetailPage(data, detail);
  }
}

// <<<<<<< HEAD
// class _SearchDetailPage extends State<SearchDetailPage> {
//   GoogleMapController? _controller;
//   Position? _currentPosition;
//   CourseInfo data;
//   _SearchDetailPage(this.data);
//
//   final List<Marker> markers = [];
//
//   // 각 자치구에 해당하는 위도와 경도를 설정합니다.
//   Map<String, LatLng> areaGuLocations = {
//     '관악구': LatLng(37.4788, 126.9519),
//     '종로구': LatLng(37.5726, 126.9733),
//     '중구': LatLng(37.5644, 126.9910),
//   };
//
//   // 각 자치구에 해당하는 줌 레벨을 설정합니다.
//   Map<String, double> areaGuZoomLevels = {
//     '관악구': 14.0,
//     '종로구': 14.0,
//     '중구': 14.0,
//   };
//
// =======
class _SearchDetailPage extends State<SearchDetailPage>{
  dynamic data;
  dynamic detail;
  _SearchDetailPage(this.data, this.detail);
// >>>>>>> 8d7508d47e012dfb24d939465f54721d5f5e233a
  @override
  Widget build(BuildContext context) {
    // LatLng? location = areaGuLocations[data.area_gu];
    // double? zoomLevel = areaGuZoomLevels[data.area_gu];

    return Scaffold(
      appBar: AppBar(
        title: Text('산책로 세부 정보'),
      ),
// <<<<<<< HEAD
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: MediaQuery.of(context).size.height * 0.4,
//               decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(50),
//               ),
//               child: GoogleMap(
//                 onMapCreated: (controller) {
//                   setState(() {
//                     _controller = controller;
//                     if (location != null && zoomLevel != null) {
//                       _controller!.animateCamera(CameraUpdate.newLatLngZoom(location, zoomLevel));
//                     }
//                   });
//                 },
//                 markers: markers.toSet(),
//                 onTap: (coordinate) {
//                   _controller?.animateCamera(CameraUpdate.newLatLng(coordinate));
//                   // addMarker(coordinate);
//                 },
//                 initialCameraPosition: location != null && zoomLevel != null
//                     ? CameraPosition(target: location, zoom: zoomLevel)
//                     : CameraPosition(target: LatLng(37.541, 126.986), zoom: 11.0),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text(data.course_name), // 수정 필요
//             SizedBox(
//               height: 8,
//             ),
//             Text("자치구 : ${data.area_gu}"),
//             Text("산책시간 : ${data.lead_time}"),
//             Text("거리 : ${data.distance}"),
//             Text("난이도 : ${data.course_level}"),
//             Text("세부 코스 : ${data.detail_course}"),
//           ],
//         ),
// =======
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(data["course_name"]),
          Text("산책시간: " + data["lead_time"].toString() + "분"),
          Text("산책거리: " + data["distance"].toString() + "km"),
          Text("난이도: " + data["course_level"].toString()),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index){
                return Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.swipe_down_alt),
                      Text(detail[index].cpi_idx.toString() + " " + detail[index].cpi_name),
                    ],
                  ),
                );
              },
              itemCount: detail.length,
            ),
          )
        ],
// >>>>>>> 8d7508d47e012dfb24d939465f54721d5f5e233a
      ),
    );
  }
}
