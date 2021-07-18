import 'package:door_shop/services/authentication_services/authorization.dart';
import 'package:door_shop/services/utility.dart';
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
        backgroundColor: Palette.primaryColor,
        elevation: 0,
        title: Text('Door Shop'),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text('Logout')
                  ],
                ),
              )
            ],
            onSelected: (item) async {
              Future.delayed(const Duration(milliseconds: 500),() async {
                if(item == 0){
                  setState(() {
                    loading = true;
                  });
                  await _authorization.signOutApp();
                }
              });
            },
          ),
        ],
      ),
    );
  }
}