import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference dbRef = database.ref("parkingslot");
Map slot = {};
late Set<dynamic> keys;
var slotName;

class ParkingSpace extends StatefulWidget {
  ParkingSpace(this.rowIndex, this.columnIndex);

  final int rowIndex;
  final int columnIndex;

  @override
  State<ParkingSpace> createState() => _ParkingSpaceState();
}

void initState() async {
  DatabaseEvent event = await dbRef.once();
  slot = event.snapshot.value as Map;
  keys = slot.keys.toSet();
}

int checkAvailability() {
  int available = 0;
  for (int i = 0; i < slot.length; i++)
    if (slot[keys.elementAt(i)] == 0) available++;

  return available;
}

class _ParkingSpaceState extends State<ParkingSpace> {
  final String alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  @override
  Widget build(BuildContext context) {
    initState();
    slotName =
        alpha[widget.rowIndex].toString() + (widget.columnIndex + 1).toString();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: slot[slotName.toString()] == 1 ? Colors.red : Colors.green,
          width: 4,
        ),
      ),
      color: Colors.white,
      child: Container(
        width: 53,
        height: 53,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              slotName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
