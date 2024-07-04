// ignore_for_file: use_build_context_synchronously

import 'package:clean_cycle/components/my_button.dart';
import 'package:clean_cycle/services/auth/auth_service.dart';
import 'package:clean_cycle/services/controllers/signup_controller.dart';
import 'package:clean_cycle/services/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //register method
  void register() async {
    //get auth service
    final _authService = AuthService();

    //check if passwords match -> create user
    if (passwordController.text == confirmPasswordController.text) {
      //try creating user
      try {
        await _authService.signInWithEmailPassword(
          emailController.text,
          passwordController.text,
        );
      }

      //display any errors
      catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }

    //if passwords don't match -> show error
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CleanCycle Title
                    const Text(
                      'CleanCycle',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(height: 25),
                    // Welcome message
                    const Text(
                      'Welcome aboard Recycler!',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),

                    // First name textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: controller.fnameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'First Name',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Last name textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: controller.lnameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Last Name',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Username textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: controller.usernameController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Username',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email Address textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: controller.emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email Address',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: controller.passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Confirm password textfield
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Sign Up button
                    MyButton(
                      text: 'Sign Up',
                      onTap: () {
                        // Sign up logic here

                        // 1. Validate form
                        if (formKey.currentState!.validate()) {
                          // 2. If form is valid, create user account
                          final user = UserModel(
                              fname: controller.fnameController.text.trim(),
                              lname: controller.lnameController.text.trim(),
                              username:
                                  controller.usernameController.text.trim(),
                              email: controller.emailController.text.trim(),
                              password:
                                  controller.passwordController.text.trim());

                          // 3. Save user to database
                          SignUpController.instance.createUser(user, context);

                          Navigator.pushNamed(context, '/homepage');
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                    // or log in text with clickable log in
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'or ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/login'); // Navigate to LoginPage
                          },
                          child: const Text(
                            'log in',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
