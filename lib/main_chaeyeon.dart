import 'package:flutter/material.dart';
import 'screens/mainPage.dart';
import 'screens/recordPage.dart';
import 'screens/calendarPage.dart';
import 'screens/myPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar Example'),
      ),
      body: TabBarView(
        children: <Widget>[MainPage(), RecordPage(), CalendarPage(), MyPage()],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(tabs: <Tab>[
        Tab(icon: Icon(Icons.home, color: Color(0xFFB7B8AD)),),
        Tab(icon: Icon(Icons.location_on, color: Color(0xFFB7B8AD)),),
        Tab(icon: Icon(Icons.calendar_month, color: Color(0xFFB7B8AD)),),
        Tab(icon: Icon(Icons.account_circle, color: Color(0xFFB7B8AD)),)
      ], controller: controller,
      )
    );
  }

  TabController? controller;

  @override
  void initState(){
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }
}