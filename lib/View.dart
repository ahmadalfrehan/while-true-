import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class View extends StatefulWidget {
  List s2 = [];
  View(this.s2);
  @override
  _ViewState createState() => _ViewState(this.s2);
}

class _ViewState extends State<View> {
  List s2 = [];
  _ViewState(this.s2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
          itemCount: s2.length,
          itemBuilder: (context, index) {
            File filee = s2[index];
            return Card(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                ),
                onPressed: () {
                  OpenFile.open(
                      //"/data/user/0/com.example.ahmad_ali_frehan/app_flutter/FB_IMG_1642350707497.jpg"
                      "${filee.path}");
                  print(filee.path);
                },
                child: Text(s2[index].toString()),
              ),
            );
          }),
    );
  }
}
