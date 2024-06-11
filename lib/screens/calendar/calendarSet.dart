// 달력 위젯의 기본 세팅

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);


// Stream<QuerySnapshot> eventsStream = fetchRecordData(day);
//
// return StreamBuilder<QuerySnapshot>(
// stream: eventsStream, // 이벤트(산책기록 데이터)를 위한 스트림
// builder: (context, snapshot) {
// if (!snapshot.hasData) {
// return Container();
// }
//
// // 이벤트 목록을 가져오기
// List<DocumentSnapshot> events = snapshot.data!.docs;
//
// // 이벤트가 있는 경우 연두색 동그라미 표시
// if (events.isNotEmpty) {
// return Container(
// decoration: BoxDecoration(
// color: Colors.lightGreen,
// shape: BoxShape.circle,
// ),
// width: 5,
// height: 5,
// );
// } else {
// // 이벤트가 없는 경우 공란
// return Container();
// }
// },
// );