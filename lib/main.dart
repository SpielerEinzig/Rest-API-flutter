import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Dio dio = Dio();
  late Map<String, dynamic> dataModel;
  late String mockData;

  dynamic data = {
    "title": 'flutter dio post',
    "body": 'testing dio package for posting data with rest api',
    "userId": 1,
  };

  dioDecodeData() async {
    final Map parsedData = await jsonDecode(mockData);
    print(parsedData["title"]);
  }

  dioPostData() async {
    String pathUrl = "https://jsonplaceholder.typicode.com/posts";

    var response = await dio.post(pathUrl,
        data: data,
        options: Options(
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
        ));

    mockData = response.toString();

    return response.data;
  }

  httpPostData() async {
    String pathUrl = "https://jsonplaceholder.typicode.com/posts";

    var response = await http.post(
      Uri.parse(pathUrl),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
    );

    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () async {
              print("posting data");
              var receivedData = await dioPostData();
              print(receivedData);
            },
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Text(
              "Post data with dio package",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Colors.black,
          ),
          const SizedBox(
            height: 100,
          ),
          MaterialButton(
            onPressed: () async {
              print("posting data");
              var receivedData = await httpPostData();
              print(receivedData);
            },
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Text(
              "Post data with http package",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
