import 'package:flutter/material.dart';
import 'package:parkassist/Screens/signin.dart';
import 'package:parkassist/authentication_service.dart';
import 'package:provider/src/provider.dart';

class SignUp extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 300,
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.white,
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 150,
                child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthenticationService>().signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                      context.read<AuthenticationService>().signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                    },
                    child: Text("SignUp")),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                child: Text(
                  "Tap to SignUp",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
              ),
            ],
          ),
        ));
  }
}
