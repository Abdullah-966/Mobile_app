import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BGNU",
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const Dashboard(),
    );
  }
}

// -------------------- Dashboard Page --------------------
class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar("BGNU"),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(110),
                child: Image.asset(
                  'assets/bgnu_vc.png',
                  height: 220,
                  width: 220,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Text("Vice Chancellor", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              // Dummy Subject List
              _buildSubjectCard("Computer Science", "Dr. Ahsan Ali", 3),
              const SizedBox(height: 15),
              _buildSubjectCard("Mathematics I", "Prof. Saima Riaz", 4),
              const SizedBox(height: 15),
              _buildSubjectCard("English Communication", "Ms. Fatima Shah", 2),
              const SizedBox(height: 15),
              _buildSubjectCard("Introduction to Programming", "Mr. Imran Khan", 3),
              const SizedBox(height: 15),
              _buildSubjectCard("Pakistan Studies", "Dr. Naveed Ahmad", 2),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildFooter(),
    );
  }
}
Widget _buildSubjectCard(String subject, String teacher, int credits) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("📘 $subject", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text("👨‍🏫 Teacher: $teacher", style: const TextStyle(fontSize: 16)),
        Text("⏱️ Credit Hours: $credits", style: const TextStyle(fontSize: 16)),
      ],
    ),
  );
}

// -------------------- "Just Name" Page --------------------
class NamePage extends StatelessWidget {
  const NamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar("Just Name"),
      body: const Center(
        child: Text("Abdullah Tariq", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: _buildFooter(),
    );
  }
}

// -------------------- "Just Button" Page --------------------
class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: _buildAppBar("Just Button"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: "Enter text", border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: const Text("Submit")),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildFooter(),
    );
  }
}

// -------------------- Drawer Menu --------------------
Widget _buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.grey),
          child: Text("Menu", style: TextStyle(fontSize: 24, color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.calculate,color: Colors.orangeAccent),
          title: const Text("Calculator"),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CalculatorPage())),
        ),
        ListTile(
          leading: const Icon(Icons.book,color: Colors.blueAccent,),
          title: const Text("Grade Book"),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GradebookPage())),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.person,color: Colors.black),
          title: const Text("Just Name"),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NamePage())),
        ),
        ListTile(
          leading: const Icon(Icons.edit,color: Colors.redAccent),
          title: const Text("Name + Button"),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NameButtonPage())),
        ),
        ListTile(
          leading: const Icon(Icons.touch_app,color: Colors.green),
          title: const Text("Just Button"),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ButtonPage())),
        ),
        ListTile(
          leading: const Icon(Icons.input, color: Colors.purple),
          title: const Text("Input"),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InputPage())),
        ),
      ],
    ),
  );
}

// -------------------- Common AppBar --------------------
PreferredSizeWidget _buildAppBar(String title) {
  return AppBar(
    backgroundColor: Colors.grey,
    title: Row(
      children: [
        Image.asset('assets/bgnu_logo.png', height: 40), // ✅ Logo added back
        const SizedBox(width: 10),
        Expanded(
          child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ],
    ),
  );
}

// -------------------- Common Footer --------------------
Widget _buildFooter() {
  return Container(
    color: Colors.grey,
    height: 50,
    child: const Center(child: Text("© 2025 Baba Guru Nanak University.", style: TextStyle(color: Colors.white, fontSize: 17))),
  );
}

// -------------------- Calculator Page --------------------
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  double result = 0;

  void calculate(String operation) {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;

    setState(() {
      switch (operation) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '*':
          result = num1 * num2;
          break;
        case '/':
          result = num2 != 0 ? num1 / num2 : 0;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar("Calculator"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildTextField(num1Controller, "Enter first number", Icons.looks_one),
            const SizedBox(height: 15),
            _buildTextField(num2Controller, "Enter second number", Icons.looks_two),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['+', '-', '*', '/'].map((op) {
                return ElevatedButton(onPressed: () => calculate(op), child: Text(op, style: const TextStyle(fontSize: 24)));
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text("Result: $result", style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
      bottomNavigationBar: _buildFooter(),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
    );
  }
}
// -------------------- Gradebook Page (Added Back) --------------------
class GradebookPage extends StatelessWidget {
  const GradebookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar("Grade Book"),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade300),
            border: TableBorder.all(color: Colors.grey.shade400),
            columns: ["Subject", "Grade Marks", "Grade", "Credit Hours"]
                .map((title) => DataColumn(label: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))).toList(),
            rows: [
              ["Math", "85", "A", "3"],
              ["Science", "78", "B", "4"],
              ["English", "92", "A+", "2"],
            ].map((data) => DataRow(cells: data.map((value) => DataCell(Text(value))).toList())).toList(),
          ),
        ),
      ),
      bottomNavigationBar: _buildFooter(),
    );
  }
}
// -------------------- Name + Button Page --------------------
class NameButtonPage extends StatefulWidget {
  const NameButtonPage({super.key});

  @override
  State<NameButtonPage> createState() => _NameButtonPageState();
}

class _NameButtonPageState extends State<NameButtonPage> {
  final TextEditingController _controller = TextEditingController();
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar("Enter Your Name"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: "Enter your name", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => setState(() => _name = _controller.text),
              child: const Text("Submit"),
            ),
            if (_name.isNotEmpty) ...[
              const SizedBox(height: 15),
              Text("Your Name: $_name", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ],
        ),
      ),
      bottomNavigationBar: _buildFooter(),
    );
  }
}
//----------------input page-----------
class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  String _status = "Active"; // Default status

  // Save multiple profiles in SharedPreferences
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? profilesString = prefs.getString("profiles");

    List<Map<String, String>> profiles = profilesString != null
        ? List<Map<String, String>>.from(
        jsonDecode(profilesString).map((item) => Map<String, String>.from(item))
    )
        : [];

    // Add new profile
    profiles.add({
      "email": _emailController.text,
      "mobile": _mobileController.text,
      "status": _status,
    });

    // Save updated list
    await prefs.setString("profiles", jsonEncode(profiles));

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Saved Successfully!")));

    // Clear fields
    _emailController.clear();
    _mobileController.clear();
    setState(() {
      _status = "Active";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage())),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Mobile Number", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),

            // Radio Buttons for Status
            Row(
              children: [
                const Text("Status:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Radio(
                  value: "Active",
                  groupValue: _status,
                  onChanged: (value) => setState(() => _status = value.toString()),
                ),
                const Text("Active"),
                Radio(
                  value: "Inactive",
                  groupValue: _status,
                  onChanged: (value) => setState(() => _status = value.toString()),
                ),
                const Text("Inactive"),
              ],
            ),
            const SizedBox(height: 20),

            // Submit Button
            ElevatedButton(
              onPressed: _saveData,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildFooter(),
    );
  }
}

//------------profile page------

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, String>> _profiles = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load stored profiles from SharedPreferences
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? profilesString = prefs.getString("profiles");

    if (profilesString != null && profilesString.isNotEmpty) {

      List<dynamic> decodedList = jsonDecode(profilesString);

      setState(() {
        _profiles = decodedList.map((item) => Map<String, String>.from(item)).toList();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar("Profiles"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _profiles.isEmpty
            ? const Center(child: Text("No profiles found!", style: TextStyle(fontSize: 18)))
            : ListView.builder(
          itemCount: _profiles.length,
          itemBuilder: (context, index) {
            final profile = _profiles[index];
            return _buildProfileBox(profile);
          },
        ),
      ),
      bottomNavigationBar: _buildFooter(),
    );
  }

  // Build profile box for each user
  Widget _buildProfileBox(Map<String, String> profile) {
    String status = profile["status"] ?? "No Status Selected";
    Color boxColor = status == "Active" ? Colors.lightGreen.shade100 : Colors.red.shade100;
    IconData statusIcon = status == "Active" ? Icons.check_circle : Icons.cancel;
    Color iconColor = status == "Active" ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("User Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Icon(statusIcon, color: iconColor, size: 28), // Status Icon
            ],
          ),
          const Divider(thickness: 1),
          _buildProfileRow("📧 Email", profile["email"] ?? "No Email"),
          _buildProfileRow("📞 Mobile", profile["mobile"] ?? "No Mobile"),
          _buildProfileRow("🔹 Status", status),
        ],
      ),
    );
  }

  // Helper widget for profile details
  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}