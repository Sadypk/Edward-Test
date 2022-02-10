import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:interview_test/api/api_handler.dart';
import 'package:interview_test/model/employees_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Interview Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Employees> employees = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<Uint8List> getFile(String url) async {
    Uri uri = Uri.parse(url);
    File file = File.fromUri(uri);
    Uint8List? byte;
    await file.readAsBytes().then((value) {
      byte = Uint8List.fromList(value);
    });
    return byte!;
  }

  void getData() async {
    List<dynamic> data = await ApiHandler.apiCall();
    for (var element in data) {
      employees.add(Employees.fromJson(element));
    }
    setState(() {
      isLoading = false;
    });
  }

  showAlertDialog(BuildContext context, Employees employees) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Employee Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              const Text('Employee Photo'),
              Image.memory(employees.employeePic!),
              const SizedBox(
                height: 5,
              ),
              Text('ID: ${employees.id!.toString()}'),
              const SizedBox(
                height: 5,
              ),
              Text('First Name: ${employees.firstName!}'),
              const SizedBox(
                height: 5,
              ),
              Text('Last Name: ${employees.lastName!}'),
              const SizedBox(
                height: 5,
              ),
              Text('Email Address: ${employees.email!}'),
              const SizedBox(
                height: 5,
              ),
              Text('Gender: ${employees.email!}'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Project'),
      ),
      body: isLoading
          ? Container()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: employees.length,
              itemBuilder: (_, int index) => InkWell(
                onTap: () => showAlertDialog(context, employees[index]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.person),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(employees[index].firstName!),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(employees[index].lastName!),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
