import 'package:door_shop/screens/cart.dart';
import 'package:door_shop/services/connection.dart';
import 'package:door_shop/services/provider_data/cart_data.dart';
import 'package:door_shop/services/provider_data/home_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/drawer.dart';
import 'package:door_shop/widgets/network_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Palette.primaryColor,
            elevation: 0,
            title: Center(child: Text('Door Shop')),
            centerTitle: true,
            actions: [
              Container(
                height: 150,
                width: 50,
                child: Center(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CartScreen())
                          );
                        },
                        child: Container(
                            height: 50,
                            width: 45,
                            child: Icon(Icons.shopping_cart)
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                            radius: 9,
                            backgroundColor: Colors.red,
                            child: Consumer<CartData>(
                              builder: (_,cart,___){
                                return Text(cart.count.toString(), style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),);
                              },
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          drawer: CustomDrawer(),
          body: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Container(
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: Palette.primaryColor),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))],
                    cursorColor: Palette.primaryColor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: Palette.primaryColor,),
                        hintText: "Search..."
                    ),
                    onChanged: (value){
                      Provider.of<HomeData>(context, listen: false).search(value);
                    },
                  ),
                ),
              ),
            ),
            body: Provider<Connection>(
              create: (context) => Connection(),
              child: Consumer<Connection>(
                builder: (context, value, _){
                  return Consumer<HomeData>(
                    builder: (_,__,___){
                      return NetworkWrapper(connection: value, screen: 'home');
                    },
                  );
                },
              ),
            ),
          )
      ),
    );
  }
}
