import 'package:flutter/material.dart';
import 'package:parkassist/Screens/regsuccess.dart';
import 'package:parkassist/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final userId = user?.uid;
int length = 0;
final dbRef = FirebaseDatabase.instance.ref();

class RegisterVehicle extends StatefulWidget {
  const RegisterVehicle({Key? key}) : super(key: key);

  @override
  State<RegisterVehicle> createState() => _RegisterVehicleState();
}

class _RegisterVehicleState extends State<RegisterVehicle> {
  final TextEditingController vehiclenumber = TextEditingController();
  String dropdownValue = 'Car';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register New Vehicle"),
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: vehiclenumber,
                decoration: InputDecoration(labelText: "Enter Vehicle Number"),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 800,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 1,
                    color: Colors.black,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Car', 'Motorcycle']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  String vnum = vehiclenumber.text.trim().toUpperCase();
                  dbRef.child("userdata/$userId/vehicles/$vnum").set({
                    "vehiclenumber": vnum,
                    "vehiclecategory": dropdownValue,
                    "booked": false
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationSuccessfull()));
                },
                child: Text("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
