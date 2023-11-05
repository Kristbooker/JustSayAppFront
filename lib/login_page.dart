import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    var response = await http.post(
      Uri.parse('http://192.168.17.175:8080/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);
      print(userData);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            title: 'Flutter Demo Home Page',
            userData: userData,
            userId: userData['id'],
          ),
        ),
      );
    } else {
      // Login failed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid username or password.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // You can use MediaQuery to get the screen size and adjust UI accordingly
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      // Set the background color of the scaffold
      backgroundColor: Colors.grey[100],

      // AppBar is optional; you might want to remove it for a full-screen experience
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white,
         fontSize: 35.0,
         fontWeight: FontWeight.bold),),
        backgroundColor:Color.fromARGB(255, 43, 39, 44),
      ),

      // Use SingleChildScrollView to avoid overflow when the keyboard is visible
      body: SingleChildScrollView(
        child: Container(
          // Use the screen height and width to make the UI responsive
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo or icon at the top
              CircleAvatar(
                radius: screenSize.width * 0.15, // Adjust the size of the icon
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.person,
                  color:Color.fromARGB(255, 34, 31, 35),
                  size: screenSize.width * 0.15,
                ),
              ),

              SizedBox(
                  height:
                      screenSize.height * 0.05), // Space between icon and form

              // Form container with rounded corners and padding
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                padding: EdgeInsets.all(screenSize.width * 0.05),
                child: Column(
                  children: <Widget>[
                    // Username text field
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),

                    // Password text field
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.04),

                    // Login button with gradient and rounded corners
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context)
                                .primaryColor, // Use an accent color if your theme has one
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.transparent, // Make the button transparent
                          shadowColor:
                              Colors.transparent, // Remove button shadow
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.width * 0.04),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _login,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.width * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
