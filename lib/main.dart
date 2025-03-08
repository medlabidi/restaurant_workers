import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void handleLogin() async {
    final workerId = idController.text.trim();
    if (workerId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your ID')),
      );
      return;
    }

    await _firestore.collection('attendance').add({
      'workerId': workerId,
      'timestamp': Timestamp.now(),
      'status': 'login',
    });

    print('Worker $workerId logged in at ${DateTime.now()}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged in successfully')),
    );
    idController.clear();
  }

  void handleLogout() async {
    final workerId = idController.text.trim();
    if (workerId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your ID')),
      );
      return;
    }

    await _firestore.collection('attendance').add({
      'workerId': workerId,
      'timestamp': Timestamp.now(),
      'status': 'logout',
    });

    print('Worker $workerId logged out at ${DateTime.now()}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged out successfully')),
    );
    idController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 350,
              height: 100,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: 'Enter ID',
                  hintText: 'Type your worker ID',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
