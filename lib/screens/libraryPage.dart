import 'package:flutter/material.dart';

import 'package:sangoproject/screens/components/libraryList.dart';

class LibraryPage extends StatefulWidget{
  List<dynamic> userLibrary;
  LibraryPage(this.userLibrary);

  @override
  State<StatefulWidget> createState(){
    return _LibraryPage(userLibrary);
  }
}

class _LibraryPage extends State<LibraryPage>{
  List<dynamic> userLibrary;
  _LibraryPage(this.userLibrary);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('찜목록'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // An Expanded widget must be a descendant of a Row, Column, or Flex,and the path from
            // the Expanded widget to its enclosing Row, Column, or Flex must contain only
            // StatelessWidgets or StatefulWidgets (not other kinds of widgets, like RenderObjectWidgets).
            Expanded(child: LibraryList(userLibrary)),
          ],
        )
    );
  }
}