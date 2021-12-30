import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkassist/Screens/about.dart';
import 'package:parkassist/Screens/home.dart';
import 'package:parkassist/Screens/registerVehicle.dart';
import 'package:parkassist/Screens/viewVehicle.dart';
import 'package:provider/src/provider.dart';

import '../authentication_service.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final userEmail = user?.email;
final userName = user?.displayName;
final userPhone = user?.phoneNumber;

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              child: CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 60,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(userName.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 20,
            ),
            Text(userEmail.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text("Home"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              title: Text("Register Vehicle"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterVehicle()));
              },
            ),
            ListTile(
              title: Text("View Vehicles"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewVehicle()));
              },
            ),
            ListTile(
              title: Text("About"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () =>
                        context.read<AuthenticationService>().signOut(),
                    child: Text("Sign-Out"))
              ],
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.start, //drawer alignment
        ),
      ),
    );
  }
}
