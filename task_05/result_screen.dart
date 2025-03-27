import 'package:flutter/material.dart';
import 'database_helper.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Map<String, dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  void fetchResults() async {
    results = await DatabaseHelper.instance.getResults();
    setState(() {});
  }

  double calculateGPA() {
    double totalPoints = results.fold(0, (sum, item) => sum + (item['gradePoints'] as double));
    int totalCredits = results.fold(0, (sum, item) => sum + (item['creditHours'] as int));
    return totalCredits == 0 ? 0.0 : totalPoints / totalCredits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: results.isEmpty
          ? const Center(child: Text('No data available'))
          : SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Student Grade Report',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder.all(),
                columns: const [
                  DataColumn(label: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Marks', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Credit Hours', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Grade', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Grade Points', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: results.map((result) {
                  return DataRow(cells: [
                    DataCell(Text(result['subject'])),
                    DataCell(Text('${result['marks']}%')),
                    DataCell(Text('${result['creditHours']}')),
                    DataCell(Text(result['grade'])),
                    DataCell(Text(result['gradePoints'].toString())),
                  ]);
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'GPA: ${calculateGPA().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
