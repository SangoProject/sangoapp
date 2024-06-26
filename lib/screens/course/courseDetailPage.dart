// 산책코스 세부 정보를 보여주는 페이지
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proj4dart/proj4dart.dart';

import '../../config/palette.dart';
import 'package:sangoproject/screens/course/courseData.dart';
import 'package:sangoproject/screens/course/courseRepository.dart';

class CourseDetailPage extends StatefulWidget{
  final dynamic data;
  CourseDetailPage(this.data, {super.key});

  @override
  State<StatefulWidget> createState(){
    return _CourseDetailPage(data);
  }
}

class _CourseDetailPage extends State<CourseDetailPage>{
  dynamic data; // 코스명, 시간, 거리, 난이도
  _CourseDetailPage(this.data);

  final CourseRepository _courseRepository = CourseRepository();
  final Completer<GoogleMapController> _controller = Completer();
  final _markers = <Marker>{};
  final List<LatLng> _points = [];
  final Set<Polyline> _polylines = <Polyline>{};
  final Set<Polyline> _routePolylines = <Polyline>{};

  @override
  void initState() {
    super.initState();
    // _setupMarkersAndPolylines();
  }

  // proj4 라이브러리를 통해 좌표계를 GRS80에서 WGS84로 적절히 변환
  final _tupleUtmkGoogle = ProjectionTuple(
    fromProj: Projection.parse(
      '+proj=tmerc +lat_0=37.509400 +lon_0=127.062559 +k=1 +x_0=205525.1279 +y_0=445538.6724 +ellps=GRS80 +units=m +no_defs',
    ),
    toProj: Projection.parse('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'),
  );

  LatLng utmkToGoogle(String x, String y) {
    var utmkPoint = Point(x: double.parse(x), y: double.parse(y));
    var googlePoint = _tupleUtmkGoogle.forward(utmkPoint);

    return LatLng(googlePoint.y, googlePoint.x);
  }

  // 세부정보 지도의 중앙 좌표
  LatLng _calculateCenterPoint(List<dynamic> detail) {
    if (detail.isEmpty) {
      return LatLng(37.541, 126.986); // 기본값 설정
    }

    double centerX = 0.0;
    double centerY = 0.0;

    // 가장 처음 포인트 X, Y값
    centerX = double.parse(detail[0].x);
    centerY = double.parse(detail[0].y);

    return utmkToGoogle(centerX.toString(), centerY.toString());
  }

  Future<void> _setupMarkersAndPolylines(List<CourseData> detail) async {
    LatLng? prevPoint; // 이전 포인트를 저장하기 위한 변수
    for (int index = 0; index < detail.length; index++) {
      final LatLng point = utmkToGoogle(detail[index].x, detail[index].y);

      _points.add(point);

      final marker = Marker(
        markerId: MarkerId(index.toString()),
        position: point,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
            title: '$index.${detail[index].cpi_name}'
        ), // 마커에 정보 표시
      );
      _markers.add(marker);

      // prevPoint가 null이 아니고 마지막-처음 구간 아닌 경우에만 폴리라인 추가
      if (prevPoint != null && index < detail.length) {
        _polylines.add(Polyline(
          polylineId: PolylineId('path$index'),
          points: [prevPoint, point],
          color: Colors.blue, // 선 색상
          width: 3, // 선 두께
        ));
      }

      prevPoint = point; // 이전 포인트 업데이트
    }

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    double? zoomLevel = 16;
    int courseLevel = data["course_level"]; // 난이도 변수
    int courseNegative = 3 - courseLevel; // 최대 난이도(3) - 난이도 (난이도 표시를 위한 변수)

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '산책로 세부 정보',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _courseRepository.loadCourse(data["course_name"]),
        builder: (context, AsyncSnapshot<List<CourseData>?> snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<CourseData> detail = snapshot.data!; //포인트번호, 포인트명칭, x좌표, y좌표 (courseData.dart 참고)
          detail.sort((a, b) => a.cpi_idx.compareTo(b.cpi_idx));

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      _setupMarkersAndPolylines(detail);
                    },
                    initialCameraPosition: CameraPosition(
                      target: _calculateCenterPoint(detail),
                      zoom: zoomLevel,
                    ),
                    markers: Set<Marker>.of(_markers),
                    polylines: _routePolylines.union(_polylines),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 코스명
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                            child: Text(
                              data["course_name"],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "산책시간: ${data["lead_time"]}분", style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "산책거리: ${data["distance"]}km", style: TextStyle(fontSize: 16),
                          ),
                          // 난이도
                          Row(
                              children: [
                                Text(
                                  "난이도: ", style: TextStyle(fontSize: 16),
                                ),
                                Row(
                                  children: List.generate(courseLevel, (index) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    );
                                  }),
                                ),
                                Row(
                                  children: List.generate(courseNegative, (index) {
                                    return Icon(
                                      Icons.star_border,
                                      color: Colors.amber,
                                    );
                                  }),
                                ),
                              ]
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 24.0),
                    //   child: Ink(
                    //     decoration: const ShapeDecoration(
                    //       color: Palette.logoColor, // 동그라미 배경색
                    //       shape: CircleBorder(), // 동그라미 모양
                    //     ),
                    //     child: InkWell(
                    //       onTap: () {
                    //         // 첫번째 포인트 매개변수 넘겨주기
                    //       },
                    //       customBorder: CircleBorder(), // 클릭 영역을 동그라미로 설정
                    //       child: Container(
                    //         width: 50,
                    //         height: 50,
                    //         child: Icon(
                    //           Icons.map, // 지도 모양 아이콘
                    //           color: Colors.white, // 아이콘 색상
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                // 포인트 명칭을 리스트로 나타냄.
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Scrollbar(
                      trackVisibility: true,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: Palette.logoColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10.0), // 둥근 모서리 설정
                                border: Border.all(width: 1.0, color: Palette.logoColor),
                              ),// 외곽선 설정
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.swipe_down_alt),
                                  Text(detail[index].cpi_idx.toString() + " " + detail[index].cpi_name),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: detail.length,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}
