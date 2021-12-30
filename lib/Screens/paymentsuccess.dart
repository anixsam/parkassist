import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:parkassist/Screens/home.dart';
import 'package:parkassist/Screens/payment.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference dbWallet = database.ref("userdata/$userId");

Map walletData = {};
int walletValue = 0;

class PaymentSuccessfull extends StatefulWidget {
  const PaymentSuccessfull({Key? key}) : super(key: key);

  @override
  _PaymentSuccessfullState createState() => _PaymentSuccessfullState();
}

class _PaymentSuccessfullState extends State<PaymentSuccessfull> {
  void initState() {
    readValue();
  }

  void readValue() async {
    DatabaseEvent dbevent = await dbWallet.once();
    walletData = dbevent.snapshot.value as Map;
    print(walletData['$userId']['wallet']);
    setState(() {
      walletValue = walletData['$userId']['wallet'];
    });
  }

  @override
  Widget build(BuildContext context) {
    initState();
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 180,
                width: 180,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 150,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Payment Succesfull",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Remaining Balance in Wallet : $walletValue",
                  style: TextStyle(fontSize: 15)),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text("Continue "))
            ],
          ),
        ),
      ),
    );
  }
}
