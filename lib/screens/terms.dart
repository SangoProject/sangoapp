import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sangoproject/config/palette.dart';
import 'package:sangoproject/mainPage.dart';
import 'package:sangoproject/screens/settingSP.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _Terms();
}

class _Terms extends State<Terms> {
  List<bool> _isChecked = List.generate(3, (index) => false);

  bool get _buttonActive => _isChecked[1] && _isChecked[2];

  void _updateCheckState(int index) {
    setState(() {
      if (index == 0) {
        bool isAllChecked = !_isChecked.every((element) => element);
        _isChecked = List.generate(3, (index) => isAllChecked);
      }
      else {
        _isChecked[index] = !_isChecked[index];
        _isChecked[0] = _isChecked.getRange(1, 3).every((element) => element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '약관 동의',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...renderCheckList(),
              const Spacer(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_buttonActive) {
                              //updateTerms();
                              saveTerms(true);
                              await loadGoal();

                              Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => MainPage()),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Palette.backgroundColor,
                            backgroundColor: _buttonActive ? Palette.logoColor : Palette.iconColor, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // Rounded corners
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '동의합니다.',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        )
                    )
                  ]
              ),
            ],
          )
      ),
    );
  }

  List<Widget> renderCheckList() {
    List<String> labels = [
      '모두 동의',
      '이용 약관(필수) >',
      '개인정보수집이용동의(필수) >',
    ];

    List<String> uris = [
      'https://akaseoyoung.notion.site/13cf9e28310c4f4f9f36a8e57b830286?pvs=4',
      'https://akaseoyoung.notion.site/19ec0893e246478582c30d31260f49cf?pvs=4',
    ];

    List<Widget> list = [
      renderContainer(_isChecked[0], labels[0], () => _updateCheckState(0), -1),
      const Divider(thickness: 1.0),
    ];
    list.addAll(List.generate(2, (index) => renderContainer(_isChecked[index + 1], labels[index + 1], () => _updateCheckState(index + 1), uris[index])));
    return list;
  }

  Widget renderContainer(bool checked, String text, VoidCallback onTap, dynamic uri) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      color: Colors.white,
        child: Row(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: checked ? Palette.logoColor : Palette.iconColor,
                      width: 2.0),
                  color: checked ? Palette.logoColor : Palette.iconColor,
                ),
                child: Icon(Icons.check, color: Palette.iconColor, size: 18),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            GestureDetector(
                onTap: () {
                  if (uri.runtimeType == String) {
                    launchUrl(Uri.parse(uri));
                  }
                },
                child: Text(text)
            )
          ],
        )
    );
  }
}

/*
void updateTerms() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.email!;

  await firestore.collection('users')
      .doc(userId)
      .update({'terms' : true});
}*/