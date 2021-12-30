import 'package:flutter/material.dart';
import 'package:parkassist/widgets/drawer.dart';
import 'package:parkassist/widgets/vehicleList.dart';

int length = 0;

class ViewVehicle extends StatelessWidget {
  const ViewVehicle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registered Devices"),
      ),
      drawer: CustomDrawer(),
      body: Container(
        child: Vehicles(),
      ),
    );
  }
}
