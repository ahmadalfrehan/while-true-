import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class ViewDataFromDataBase extends StatefulWidget {
  List<Map<dynamic, dynamic>> list = [];

  ViewDataFromDataBase(this.list);
  @override
  _ViewDataFromDataBaseState createState() =>
      _ViewDataFromDataBaseState(this.list);
}

class _ViewDataFromDataBaseState extends State<ViewDataFromDataBase> {
  List<Map<dynamic, dynamic>> list = [];
  _ViewDataFromDataBaseState(this.list);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A535C),
        centerTitle: true,
        title: const Text('Information page !',
          style: TextStyle(
            color:Color(0xFFFFE66D) ,
            fontWeight: FontWeight.bold,
            //fontSize: 18,
          ),),

      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(1, 1, 14, 10),
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A535C),
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(2, 2, 18, 10),
                    height: 97,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE66D),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  ListTile(
                    isThreeLine: true,
                    onLongPress: () {},
                    title: Text(
                      list[index]['name'],
                      style: const TextStyle(
                        color: Color(0xFF1A535C),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    subtitle: Text(
                      list[index]['vlaue'],
                      style: const TextStyle(
                          //color: Colors.teal,
                          ),
                    ),
                    leading: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF1A535C),
                        child: Text(
                          list[index]['id'].toString(),
                          style: const TextStyle(
                            color: Color(0xFFFFE66D),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
