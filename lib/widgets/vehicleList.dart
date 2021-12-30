import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icons.dart';

FirebaseDatabase databaseVehicle = FirebaseDatabase.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final dbRefVeh = FirebaseDatabase.instance.ref();

final User? user = auth.currentUser;
final userId = user?.uid;
DatabaseReference dbVehicle = databaseVehicle.ref("userdata/$userId");
Map vehicleData = {};
Map vehicleDetails = {};
Set<dynamic> vehicleid = {};
late var vehicleNumber;
late var vehicleCategory;
late var bookedStatus;

class Vehicles extends StatefulWidget {
  @override
  _VehiclesState createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  void initState() {
    readVehicleValue();
  }

  void readVehicleValue() async {
    DatabaseEvent dbvehicleevent = await dbVehicle.once();
    vehicleData = dbvehicleevent.snapshot.value as Map;
    vehicleid = vehicleData['vehicles'].keys.toSet();
    vehicleDetails = vehicleData['vehicles'];
    print(vehicleDetails[vehicleid.elementAt(0).toString()]
        .toString()
        .runtimeType);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(vehicleid.length, (index) {
          var vehicleNum =
              vehicleDetails[vehicleid.elementAt(index).toString()].toString();
          return Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ListTile(
                    title: Text(vehicleNum.toString()),
                  )
                ]),
                Container(
                  height: 1,
                  color: Colors.black,
                )
              ]));
        }));
  }
}
