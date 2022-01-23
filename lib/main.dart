// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:ahmad_ali_frehan/viewdatafromdatabase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'View.dart';

void main() {
  runApp(MyApp());
  //List l =[];
  //l = [{'id' :1 ,'name' : 'ahmad', 'value' :10}];
  //print(l[0]['name']);
//  String ff = '123456';
  // int i = int.parse(ff!);
  // print(i);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      //darkTheme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Database? database;
  List<File> s = [];
  List<Map<dynamic, dynamic>> elements = [];
  var nameController = TextEditingController();
  var vlaueController = TextEditingController();
  var idController = TextEditingController();
  void createDataBase() {
    openDatabase(
      'ahmad.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        database
            .execute(
                'CREATE TABLE alaa (id INTEGER PRIMARY KEY , name TEXT ,vlaue TEXT)')
            .then((value) {
          print('table created');
        }).catchError(
          (onError) =>
              print('the error happen when created database${onError}'),
        );
      },
      onOpen: (database) {
        elements.clear();
        GetDataFromDatabase(database);
        print('database opened ');
      },
    ).then((value) {
      database = value;
    });
  }

  void inserttoDataBase({required String name, required String vlaue}) async {
    await database!.transaction(
      (txn) => txn
          .rawInsert('INSERT INTO alaa (name,vlaue) VALUES("$name","$vlaue")')
          .then((value) {
        print('$value inserted successfully');
        elements.clear();
        GetDataFromDatabase(database);
      }).catchError(
        (onError) => print('error when insert to data base ${onError}'),
      ),
    );
  }

  void GetDataFromDatabase(database) {
    //  elements.clear();
    database!.rawQuery('SELECT * FROM alaa').then((value) {
      value.forEach((element) {
        setState(() {
          elements.add(element);
        });
      });
    });
  }

  void DeleteFromDataBase({required int id}) {
    database!.rawDelete('DELETE FROM alaa WHERE id=?', [id]).then((value) {
      elements.clear();
      GetDataFromDatabase(database);
    });
  }

  void Delete() {
    database!.delete('alaa');
    elements.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDataBase();
  }

  Color Color1 = Color(0xFF1A535C);
  Color Color2 = Color(0xFFFFE66D);
  double heights = 40;
  double widths = 350;
  File? fi;
  int? idd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color1,
        centerTitle: true,
        title: Text(
          'Home page ',
          style: TextStyle(
            color: Color2,
            fontWeight: FontWeight.bold,
            //fontSize: 18,
          ),
        ),
      ),
      body: Container(
        //height: double.infinity,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              37,
            ),
            topRight: Radius.circular(
              37,
            ),
            bottomLeft: Radius.circular(
              20,
            ),
            bottomRight: Radius.circular(
              20,
            ),
          ),
          color: Color(0xFFF7FFF7),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  30,
                  10,
                  30,
                  10,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Color1, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Color1, width: 2.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color1,
                      ),
                      labelText: " Name "),
                  //keyboardAppearance: Brightness.light,
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'the field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  30,
                  10,
                  30,
                  10,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Color1, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Color1, width: 2.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(Icons.details_outlined, color: Color1),
                      labelText: " Information "),
                  controller: vlaueController,
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'the field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Color1,
                    width: 2,
                  ),
                  elevation: 0.0,
                  primary: Color2,
                  fixedSize: Size(widths, heights),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  inserttoDataBase(
                    name: nameController.text,
                    vlaue: vlaueController.text,
                  );
                },
                child: Text(
                  ' insert ?!',
                  style: TextStyle(
                    color: Color1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Color1,
                    width: 2,
                  ),
                  elevation: 0.0,
                  primary: Color2,
                  fixedSize: Size(widths, heights),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  print(elements);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewDataFromDataBase(elements),
                    ),
                  );
                },
                child: Text(
                  'view the data ?!',
                  style: TextStyle(
                    color: Color1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Color1,
                    width: 2,
                  ),
                  elevation: 0.0,
                  primary: Color2,
                  fixedSize: Size(widths, heights),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  setState(() {
                    Delete();
                  });
                },
                child: Text(
                  ' Delete all ?',
                  style: TextStyle(
                    color: Color1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  30,
                  10,
                  30,
                  10,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Color1, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Color1, width: 2.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      prefixIcon: Icon(Icons.format_list_numbered_rounded,
                          color: Color1),
                      labelText: " ID "),
                  controller: idController,
                  keyboardType: TextInputType.text,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'the field must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Color1,
                    width: 2,
                  ),
                  elevation: 0.0,
                  primary: Color2,
                  fixedSize: Size(widths, heights),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  setState(() {
                    print(idd);
                    idd = int.parse(idController.text);
                    print(idd);
                    DeleteFromDataBase(id: idd!);
                  });
                },
                child: Text(
                  ' Delete by id ?',
                  style: TextStyle(
                    color: Color1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Color1,
                    width: 2,
                  ),
                  elevation: 0.0,
                  primary: Color2,
                  fixedSize: Size(widths, heights),
                  shape: StadiumBorder(),
                ),
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    dialogTitle: "Ahmad Alfrehan",
                    allowMultiple: true,
                  );
                  if (result == null) {
                    return;
                  } else {
                    setState(() {
                      final file = result.files.first;
                      //final files = result.paths.map((path) {
                      //return result.files.first;
                      //}); //File(path!)).toList();
                      savefiles(file);
                      OpenFile.open(file.path);
                    });
                  }
                },
                child: Text(
                  'pick files?',
                  style: TextStyle(
                    color: Color1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     side: BorderSide(
              //       color: Color1,
              //       width: 2,
              //     ),
              //     elevation: 0.0,
              //     primary: Color2,
              //     fixedSize: Size(widths, heights),
              //     shape: StadiumBorder(),
              //   ),
              //   onPressed: () {
              //     OpenFile.open(
              //         "/data/user/0/com.example.ahmad_ali_frehan/app_flutter/istockphoto-469201837-612x612.jpg");
              //   },
              //   child: Text(
              //     'show this file',
              //     style: TextStyle(
              //       color: Color1,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Color1,
                    width: 2,
                  ),
                  elevation: 0.0,
                  primary: Color2,
                  fixedSize: Size(widths, heights),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  OpenFile.open(fi!.path);
                },
                child: Text(
                  'show latest file',
                  style: TextStyle(
                    color: Color1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Color1,
                    width: 2,
                  ),
                  elevation: 0.0,
                  primary: Color2,
                  fixedSize: Size(widths, heights),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => View(s)));
                },
                child: Text(
                  'lets go !',
                  style: TextStyle(
                    color: Color1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Color1,
                    width: 2,
                  ),
                  elevation: 0.0,
                  primary: Color2,
                  fixedSize: Size(widths, heights),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text(
                  'Get Out ?!',
                  style: TextStyle(
                    color: Color1,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File> savefiles(PlatformFile file) async {
    final appstorage = await getApplicationDocumentsDirectory();
    final newfiles = File('${appstorage.path}/${file.name}');

    return File(file.path!).copy(newfiles.path);
  }
}
