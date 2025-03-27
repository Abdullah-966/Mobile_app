import 'package:flutter/material.dart';
import 'database_helper.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController marksController = TextEditingController();
  final TextEditingController creditHoursController = TextEditingController();

  String calculateGrade(int marks) {
    if (marks >= 80) return 'A';
    if (marks >= 70) return 'B';
    if (marks >= 60) return 'C';
    if (marks >= 50) return 'D';
    return 'F';
  }

  double getGradePoints(String grade, int creditHours) {
    Map<String, double> gradeToPoint = {
      'A': 4.0,
      'B': 3.0,
      'C': 2.0,
      'D': 1.0,
      'F': 0.0
    };
    return (gradeToPoint[grade] ?? 0.0) * creditHours;
  }

  void saveResult() async {
    String subject = subjectController.text;
    int marks = int.tryParse(marksController.text) ?? 0;
    int creditHours = int.tryParse(creditHoursController.text) ?? 0;

    String grade = calculateGrade(marks);
    double gradePoints = getGradePoints(grade, creditHours);

    await DatabaseHelper.instance.insertResult({
      'subject': subject,
      'marks': marks,
      'creditHours': creditHours,
      'grade': grade,
      'gradePoints': gradePoints
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Result Saved!')));
    subjectController.clear();
    marksController.clear();
    creditHoursController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter Course Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: subjectController, decoration: const InputDecoration(labelText: "Subject Name")),
            TextField(controller: marksController, decoration: const InputDecoration(labelText: "Marks"), keyboardType: TextInputType.number),
            TextField(controller: creditHoursController, decoration: const InputDecoration(labelText: "Credit Hours"), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: saveResult, child: const Text("Save Result")),
          ],
        ),
      ),
    );
  }
}
