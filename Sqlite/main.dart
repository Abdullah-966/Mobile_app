import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQlite',
      home: SQLiteHome(),
    );
  }
}

class SQLiteHome extends StatefulWidget {
  @override
  _SQLiteHomeState createState() => _SQLiteHomeState();
}

class _SQLiteHomeState extends State<SQLiteHome> {
  final TextEditingController _controller = TextEditingController();
  late Database _database;
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _initDB();
  }

  Future<void> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'demo.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE entries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            text TEXT
          )
        ''');
      },
    );

    _loadEntries();
  }

  Future<void> _insertEntry(String text) async {
    await _database.insert('entries', {'text': text});
    _controller.clear();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final List<Map<String, dynamic>> maps = await _database.query('entries');
    setState(() {
      _items = maps.map((e) => e['text'].toString()).toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQlite'),
        leading: Icon(Icons.storage), // Changed the icon here
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter something'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final text = _controller.text.trim();
                if (text.isNotEmpty) {
                  _insertEntry(text);
                }
              },
              child: Text('Submit'),
            ),
            Divider(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(_items[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
