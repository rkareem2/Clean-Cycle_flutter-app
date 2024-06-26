import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        // ignore: prefer_const_constructors
        body: SafeArea(
          // ignore: prefer_const_constructors
          child: Center(
            // ignore: prefer_const_literals_to_create_immutables, prefer_const_constructors
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Welcome back Cycler
              // ignore: prefer_const_constructors
              Text(
                'CleanCycle',
                // ignore: prefer_const_constructors
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              // ignore: prefer_const_constructors
              SizedBox(height: 25),
              // ignore: prefer_const_constructors
              Text(
                'Welcome back Recycler',
                // ignore: prefer_const_constructors
                style: TextStyle(fontSize: 20),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),
              // username / email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // ignore: prefer_const_constructors
                  child: Padding(
                    // ignore: prefer_const_constructors
                    padding: EdgeInsets.only(left: 20.0),
                    // ignore: prefer_const_constructors
                    child: TextField(
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username/Email Address',
                      ),
                    ),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(height: 20),

              // password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // ignore: prefer_const_constructors
                  child: Padding(
                    // ignore: prefer_const_constructors
                    padding: EdgeInsets.only(left: 20.0),
                    // ignore: prefer_const_constructors
                    child: TextField(
                      obscureText: true,
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(height: 20),

              // sign in button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // ignore: prefer_const_constructors
                  child: Center(
                    // ignore: prefer_const_constructors
                    child: Text('Log in',
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                  ),
                ),
              ), // ignore: prefer_const_constructors
              SizedBox(height: 20),

              // ignore: prefer_const_constructors
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text('Not a member?',
                      // ignore: prefer_const_constructors
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  // ignore: prefer_const_constructors
                  Text(
                    ' Sign up',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // not rgistered
            ]),
          ),
        ));
  }
}
