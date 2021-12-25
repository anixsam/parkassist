import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../authentication_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: [
            Text("HOME PAGE"),
            ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                },
                child: Text("Signout"))
          ],
        ),
      ),
    );
  }
}
