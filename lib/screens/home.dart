import 'package:door_shop/services/authentication_services/authorization.dart';
import 'package:door_shop/widgets/loading.dart';
import 'package:flutter/material.dart';

// TODO: Add refresh functionality to update the pricing

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthorizationService _authorization = AuthorizationService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text('Door Shop'),
        ),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              setState(() {
                loading = true;
              });
              await _authorization.signOutApp();
            },
          )
        ],
      ),
    );
  }
}