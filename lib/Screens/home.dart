import 'package:flutter/material.dart';
import 'package:parkassist/Screens/payment.dart';
import 'package:parkassist/widgets/drawer.dart';
import 'package:parkassist/widgets/parking_lot..dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkassist/widgets/parking_space.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference dbRef = database.ref("parkingarea");

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

final String userid = firebaseAuth.currentUser!.uid.toString();

late int rows = 1, cols = 1;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    readValue();
  }

  void readValue() async {
    DatabaseEvent event = await dbRef.once();
    Map map = event.snapshot.value as Map;
    setState(() {
      rows = map['row'];
      cols = map['column'];
    });
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Parking Assist"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ParkingLot(row: rows, column: cols),
            SizedBox(height: 20),
            Text(
                "Number of Available Spaces : " +
                    checkAvailability().toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 50,
            ),
            Visibility(
              visible: checkAvailability() == 0 ? false : true,
              child: Container(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Payment()));
                  },
                  child: Text(
                    "Book Parking Space",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
