import 'package:flutter/material.dart';
import 'package:parkassist/widgets/drawer.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      drawer: CustomDrawer(),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Parking Assistant is created by Team BUG_FOUND",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "This App is used for managing parking and also booking for the parking spaces in tight city areas.This app supports booking a parking space in the city and also other features include Displaying Slot Availability,Registering seperate vehicles,Viewing the registered vehicles, also can pay for the parking from the app in case of the prepaid parking",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Team Members: Anix, Alby, Moncy, Sangeeth",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Students of lahia Collge of Engineering and Technology",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
