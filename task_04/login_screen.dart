import 'package:flutter/material.dart';
import 'database_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _userData = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await _dbHelper.getAllUsers();
    setState(() {
      _userData = data;
    });
  }

  void _submitData() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    await _dbHelper.insertUser(email, password);
    _emailController.clear();
    _passwordController.clear();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data saved successfully')));

    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SQLite Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: _submitData, child: const Text('Submit')),
            const SizedBox(height: 32),
            Text(
              'Inserted Data:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child:
                  _userData.isEmpty
                      ? const Center(child: Text("No data available"))
                      : ListView.builder(
                        itemCount: _userData.length,
                        itemBuilder: (context, index) {
                          final user = _userData[index];
                          return ListTile(
                            title: Text('Email: ${user['email']}'),
                            subtitle: Text('Password: ${user['password']}'),
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
