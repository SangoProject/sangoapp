import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _LibraryPage();
  }
}

class _LibraryPage extends State<LibraryPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('library page'),
      ),
    );
  }
}