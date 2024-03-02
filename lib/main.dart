import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

typedef OnPressed = void Function();
typedef OnChanged<T> = void Function(T value);
typedef OnChangedAsync<T> = Future<void> Function(T value);
typedef OnCheck<T> = bool Function(T value);
typedef OnValidate<T> = String Function(T value);
typedef ItemBuilder = Widget Function(BuildContext context, int index);
typedef ListenerBuilder<T> = Widget Function(
    BuildContext context, T listenedData);

void main() {
  runApp(MyApp());
}

List<TextEditingController> instructorNameControllers =
    List.generate(9, (index) => TextEditingController());

List<TextEditingController> courseCodeControllers =
    List.generate(9, (index) => TextEditingController());
List<TextEditingController> meetingTimeControllers =
    List.generate(9, (index) => TextEditingController());
String? require(String? text) {
  if (text == null || text.isEmpty) return "\u26A0  This field cannot be empty";

  return null;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scheduler AI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text(
            "Teachers",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < 9; i++) ...[
                    const SizedBox(height: 16),
                    // BuildTextField(
                    //     "Instructor ID ${i + 1}", instructorIdControllers[i]),
                    TextFormField(
                      controller: instructorNameControllers[i],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Enter Instructor Name ${i + 1}',
                      ),
                      validator: require,
                    ),
                  ],
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (form.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const CourseName(),
                            ),
                          );
                        }
                      },
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.all(12),
                        ),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class CourseName extends StatefulWidget {
  const CourseName({super.key});

  @override
  State<CourseName> createState() => _CourseNameState();
}

class _CourseNameState extends State<CourseName> {
  final GlobalKey<FormState> form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Course Code",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int i = 0; i < 9; i++) ...[
                  const SizedBox(height: 16),
                  // BuildTextField(
                  //     "Instructor ID ${i + 1}", instructorIdControllers[i]),
                  TextFormField(
                    controller: courseCodeControllers[i],
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter Course Code ${i + 1}',
                    ),
                    validator: require,
                  ),
                ],
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (form.currentState!.validate()) {
                        EasyLoading.show(status: 'loading...');

                        var headers = {'Content-Type': 'application/json'};
                        var data = json.encode({
                          "rooms": [
                            {"number": "33-501", "seatingCapacity": 70},
                            {"number": "34-203", "seatingCapacity": 35}
                          ],
                          "meetingTimes": [
                            {"id": "MT1", "time": "MON 08:00 - 10:00"},
                            {"id": "MT2", "time": "MON 10:00 - 12:00"},
                            {"id": "MT3", "time": "MON 12:00 - 14:00"},
                            {"id": "MT4", "time": "MON 14:00 - 16:00"},
                            {"id": "MT5", "time": "MON 16:00 - 18:00"},
                            {"id": "MT6", "time": "TUES 08:00 - 10:00"},
                            {"id": "MT7", "time": "TUES 10:00 - 12:00"},
                            {"id": "MT8", "time": "TUES 12:00 - 14:00"},
                            {"id": "MT9", "time": "TUES 14:00 - 16:00"},
                            {"id": "MT10", "time": "TUES 16:00 - 18:00"},
                            {"id": "MT11", "time": "WED 08:00 - 10:00"},
                            {"id": "MT12", "time": "WED 10:00 - 12:00"},
                            {"id": "MT13", "time": "WED 12:00 - 14:00"},
                            {"id": "MT14", "time": "WED 14:00 - 16:00"},
                            {"id": "MT15", "time": "WED 16:00 - 18:00"},
                            {"id": "MT16", "time": "THUR 08:00 - 10:00"},
                            {"id": "MT17", "time": "THUR 10:00 - 12:00"},
                            {"id": "MT18", "time": "THUR 12:00 - 14:00"},
                            {"id": "MT19", "time": "THUR 14:00 - 16:00"},
                            {"id": "MT20", "time": "THUR 16:00 - 18:00"},
                            {"id": "MT21", "time": "FRI 08:00 - 10:00"},
                            {"id": "MT22", "time": "FRI 10:00 - 12:00"},
                            {"id": "MT23", "time": "FRI 12:00 - 14:00"},
                            {"id": "MT24", "time": "FRI 14:00 - 16:00"}
                          ],
                          "instructors": List.generate(
                              instructorNameControllers.length,
                              (index) => {
                                    "id": "AP${index + 1}",
                                    "name":
                                        instructorNameControllers[index].text
                                  }),
                          "courses": [
                            {
                              "number": "C1",
                              "name": "Course1",
                              "instructors": ["AP1"],
                              "maxNumbOfStudents": 70
                            },
                            {
                              "number": "C2",
                              "name": "Course2",
                              "instructors": ["AP2"],
                              "maxNumbOfStudents": 70
                            },
                            {
                              "number": "C3",
                              "name": "Course3",
                              "instructors": ["AP3"],
                              "maxNumbOfStudents": 35
                            },
                            {
                              "number": "C4",
                              "name": "Course4",
                              "instructors": ["AP4"],
                              "maxNumbOfStudents": 70
                            },
                            {
                              "number": "C5",
                              "name": "Course5",
                              "instructors": ["AP3"],
                              "maxNumbOfStudents": 70
                            },
                            {
                              "number": "C6",
                              "name": "Course6",
                              "instructors": ["AP5"],
                              "maxNumbOfStudents": 70
                            },
                            {
                              "number": "C7",
                              "name": "Course7",
                              "instructors": ["AP6"],
                              "maxNumbOfStudents": 70
                            },
                            {
                              "number": "C8",
                              "name": "Course8",
                              "instructors": ["AP7"],
                              "maxNumbOfStudents": 70
                            },
                            {
                              "number": "C9",
                              "name": "Course9",
                              "instructors": ["AP8"],
                              "maxNumbOfStudents": 35
                            }
                          ]
                        });
                        var dio = Dio();

                        log("data  -- $data");
                        try {
                          var response = await dio.request(
                            'https://scheduler-yptv.onrender.com/schedule',
                            options: Options(
                              method: 'POST',
                              headers: headers,
                            ),
                            data: data,
                          );

                          if (response.statusCode == 200) {
                            EasyLoading.showSuccess('Great Success!');

                            EasyLoading.dismiss();

                            List<Map<String, dynamic>> mapList = response
                                .data["schedule"]
                                .cast<Map<String, dynamic>>();

                            print("data -- $mapList");

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) =>
                                    CourseSchedule(schedule: mapList),
                              ),
                            );
                          } else {
                            EasyLoading.showError('Failed with Error');

                            print(response.statusMessage);
                          }
                        } catch (e) {
                          EasyLoading.showError('Failed with Error $e');

                          print(e);
                        }
                      }
                    },
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.all(12),
                      ),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseSchedule extends StatelessWidget {
  final List<Map<String, dynamic>> schedule;

  const CourseSchedule({super.key, required this.schedule});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RotatedBox(
        quarterTurns: 1,
        child: Center(
          child: SingleChildScrollView(
            child: DataTable(
              columns: [
                DataColumn(label: Text('Course Number')),
                DataColumn(label: Text('Instructor ID')),
                DataColumn(label: Text('Meeting Time ID')),
                DataColumn(label: Text('Room Number')),
              ],
              rows: schedule.map((course) {
                return DataRow(cells: [
                  DataCell(Text(course['course_number'] ?? '')),
                  DataCell(Text(course['instructor_id'] ?? '')),
                  DataCell(Text(course['meeting_time_id'] ?? '')),
                  DataCell(Text(course['room_number'] ?? '')),
                ]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
