import 'package:flutter/material.dart';

void main() {
  runApp(RestaurantAttendanceApp());
}

class RestaurantAttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Worker Login',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController idController = TextEditingController();

  void handleLogin() {
    final workerId = idController.text.trim();
    if (workerId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your ID')),
      );
      return;
    }
    // Here you would save the login time to a database or file
    print('Worker $workerId logged in at ${DateTime.now()}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged in successfully')),
    );
    idController.clear();
  }

  void handleLogout() {
    final workerId = idController.text.trim();
    if (workerId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your ID')),
      );
      return;
    }
    // Here you would save the logout time to a database or file
    print('Worker $workerId logged out at ${DateTime.now()}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged out successfully')),
    );
    idController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(  // Center the widget here
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Center contents vertically
          children: [
            Image.asset(
              'assets/logo.png',  // Your logo image file path
              width: 350,  // Adjust width if necessary
              height: 100, // Adjust height if necessary
            ),
            const SizedBox(height: 20),  // Space between icon and text field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10), // Adds space from screen edges
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter ID',
                  hintText: 'Type your worker ID',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12), // Adjusted padding
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14), // Apple-style rounded edges
                    borderSide: BorderSide(color: Colors.grey, width: 1.5), // Subtle border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.blue, width: 2), // Blue focus border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5), // Default border
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),  // Space between text field and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: handleLogin,
                  child: Text('Login'),
                ),
                ElevatedButton(
                  onPressed: handleLogout,
                  child: Text('Logout'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
