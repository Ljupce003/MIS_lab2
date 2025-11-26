import 'package:flutter/material.dart';

import '../models/exam_model.dart';
import '../widgets/exam_grid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ExamModel> exams;

  @override
  void initState() {
    super.initState();

    exams = [
      ExamModel(name: "Data Structures",dateTime:  DateTime(2026, 1, 10, 9, 0),examRooms:  [
        "Room 101",
        "Room 102",
      ]),
      ExamModel(name: "Algorithms", dateTime: DateTime(2025, 1, 13, 14, 0),examRooms:  [
        "Room 201",
        "Room 203",
      ]),
      ExamModel(name: "Database Systems",dateTime: DateTime(2026, 1, 15, 10, 0),examRooms:  [
        "Lab A",
        "Lab B",
      ]),
      ExamModel(name: "Operating Systems",dateTime: DateTime(2025, 1, 17, 9, 0),examRooms:  ["Room 105"]),
      ExamModel(name: "Computer Networks",dateTime: DateTime.now().add(Duration(minutes: 15)),examRooms:  [
        "Room 207",
        "Room 208",
      ]),
      ExamModel(name: "Artificial Intelligence",dateTime: DateTime(2025, 1, 22, 9, 0),examRooms:  [
        "Room 110",
      ]),
      ExamModel(name: "Machine Learning",dateTime: DateTime(2025, 1, 25, 11, 0),examRooms:  ["Lab C"]),
      ExamModel(name: "Software Engineering",dateTime: DateTime(2025, 1, 27, 10, 0),examRooms:  [
        "Room 202",
        "Room 204",
      ]),
      ExamModel(name: "Web Development",dateTime: DateTime(2025, 1, 29, 15, 0),examRooms:  ["Lab D"]),
      ExamModel(name: "Computer Architecture",dateTime: DateTime(2025, 2, 2, 9, 0),examRooms:  [
        "Room 301",
      ]),
      ExamModel(name: "Cyber Security",dateTime: DateTime(2025, 2, 4, 14, 0),examRooms:  ["Room 107"]),
      ExamModel(name: "Compiler Design",dateTime: DateTime(2025, 2, 6, 10, 30),examRooms:  ["Room 206"]),
      ExamModel(name: "Human-Computer Interaction",dateTime: DateTime(2025, 2, 8, 9, 0),examRooms:  [
        "Lab UX1",
      ]),
      ExamModel(name: "Parallel Computing",dateTime: DateTime(2025, 2, 10, 13, 0),examRooms:  [
        "Room 309",
      ]),
      ExamModel(name: "Cloud Computing",dateTime: DateTime(2025, 2, 12, 11, 0),examRooms:  [
        "Room 401",
        "Room 402",
      ]),
    ];

    exams.sort((e1, e2) => e1.dateTime.compareTo(e2.dateTime));

    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("Распоред за испити - 221563", textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            ExamGrid(exams: exams),
            SizedBox(height: 10),

            Container(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 0,),
              alignment: Alignment.centerRight,
              child: Badge(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                label: Text("${exams.length}", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
