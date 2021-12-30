import 'package:flutter/material.dart';
import 'package:parkassist/widgets/drawer.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(title: Text("Admin Panel")),
    );
  }
}
