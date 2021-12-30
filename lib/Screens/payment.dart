import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkassist/Screens/paymentsuccess.dart';
import 'package:parkassist/Screens/registerVehicle.dart';
import 'package:parkassist/widgets/parking_space.dart';

final dbData = FirebaseDatabase.instance.ref();
FirebaseDatabase database = FirebaseDatabase.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
var vehicleNum;
var userId = user?.uid;

DatabaseReference dbRet = database.ref("parkingslot");
DatabaseReference dbWallet = database.ref("userdata");
Set<dynamic> keys = {};
Map slotVal = {};
Set<dynamic> keyWallet = {};
Map walletMap = {};
int wallet = 0;
TextEditingController bookingVehicleNum = TextEditingController();
bool error = false;

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  void initState() {
    readValue();
    readWallet();
  }

  void readWallet() async {
    DatabaseEvent dbevent = await dbWallet.once();
    walletMap = dbevent.snapshot.value as Map;
    keyWallet = walletMap.keys.toSet();
    wallet = walletMap['$userId']['wallet'];
    print(wallet);
  }

  void readValue() async {
    DatabaseEvent dbevent = await dbRet.once();
    slotVal = dbevent.snapshot.value as Map;
    keys = slotVal.keys.toSet();
  }

  int slotsAvailable() {
    for (int i = 0; i < slotVal.length; i++)
      if (slotVal[keys.elementAt(i)] == 0) {
        print(keys.elementAt(i));

        return i;
      }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    initState();
    int i = slotsAvailable();
    var name = keys.elementAt(i);
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: bookingVehicleNum,
                decoration: InputDecoration(
                    labelText: "Enter Vehicle Number",
                    errorText: error ? "Vehicle not Registered" : null),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Available Slot : $name",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Amount to pay : 20",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    int walletUpdate = wallet - 20;
                    vehicleNum = bookingVehicleNum.text.trim();
                    print(vehicleNum);
                    dbData
                        .child("userdata/$userId")
                        .update({'wallet': walletUpdate});
                    dbData
                        .child("userdata/$userId/vehicles/$vehicleNum")
                        .update({'booked': true});
                    dbData.child("parkingslot").update({name: 1});

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentSuccessfull()));
                  },
                  child: Text("Pay"))
            ],
          ),
        ),
      ),
    );
  }
}
