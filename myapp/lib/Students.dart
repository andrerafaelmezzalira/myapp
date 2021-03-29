import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/Http.dart';
import 'package:myapp/Student.dart';
import 'package:myapp/StudentStorage.dart';
import 'package:myapp/SynchronizedStudents.dart';

class Students extends StatelessWidget {
  final bool connected;

  Students(this.connected);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Student>>(
        future: students(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listView(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }

  ListView listView(final students) {
    return ListView.builder(
        padding: EdgeInsetsDirectional.fromSTEB(10, 150, 10, 10),
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${students[index].name}'),
          );
        });
  }

  Future<List<Student>> students() async {
    if (connected) {
      SynchronizedStudents.synchronized();
      final response = await Http.get();
      if (response.statusCode == 200) {
        final List<Student> students = load(response);
        StudentStorage.addAll(students);
        return students;
      }
    }
    return StudentStorage.loadStudents();
  }

  List<Student> load(final response) {
    return json
        .decode(response.body)
        .map<Student>((job) => new Student.fromJson(job))
        .toList();
  }
}
