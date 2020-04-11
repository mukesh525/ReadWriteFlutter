import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  var data = await readData();
  if (data != null) {
    print(data.toString());
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Read/Write'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _enterDataController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(13.4),
          alignment: Alignment.topCenter,
          child: ListTile(
            title: TextField(
              controller: _enterDataController,
              decoration: InputDecoration(labelText: 'Write Something'),
            ),
            subtitle: FlatButton(
              onPressed: () {
                // saveTofile
                writeData(_enterDataController.text);
              },
              child: Column(
                children: <Widget>[
                  Text('Save Data'),
                  Padding(padding: EdgeInsets.all(14.5)),
                  FutureBuilder(
                      future: readData(),
                      builder:
                          (BuildContext contex, AsyncSnapshot<String> data) {
                        if (data.hasData != null) {
                          return Text(data.data.toString(),style: TextStyle(
                            color: Colors.blueAccent
                          ),);
                        }else {
                          return Text('Empty');
                        }
                      })
                ],
              ),
            ),
          ),
        ));
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/demo.txt');
}

Future<File> writeData(String message) async {
  final file = await _localFile;
  return file.writeAsString("$message");
}

Future<String> readData() async {
  try {
    final file = await _localFile;
    //Read
    return await file.readAsString();
  } catch (e) {
    return 'Nothing Saved Yet';
  }
}
