import 'package:cached_network_image/cached_network_image.dart';
import 'package:door_shop/screens/cart.dart';
import 'package:door_shop/screens/my_account.dart';
import 'package:door_shop/screens/orders.dart';
import 'package:door_shop/services/authentication_services/authorization.dart';
import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/connection.dart';
import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  final AuthorizationService _authorization = AuthorizationService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      width: size.width*0.68,
      child: Drawer(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(left: 15, top: 45, right: 15),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 70,
                  child: CachedNetworkImage(
                      imageUrl: DoorShop.sharedPreferences.getString(DoorShop.url),
                      progressIndicatorBuilder: (context, url,
                          downloadProgress) =>
                          CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: Colors.black,),
                      imageBuilder: (context, imageProvider) =>
                          Container(
                            decoration: BoxDecoration(
                                shape:BoxShape.circle,
                                image:DecorationImage(
                                    image:imageProvider,
                                    fit: BoxFit.cover
                                )
                            ),
                          )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text(
                  "Hello, " + (DoorShop.sharedPreferences.getString(DoorShop.name) ?? ''),
                  style: TextStyle(
                      fontSize: 20,
                      color: Palette.primaryColor
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Divider(color: Colors.black, thickness: 0.5, )
              ),
              SizedBox(height: 12,),
              InkWell(
                splashColor: Palette.primaryColor,
                onTap: () async {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> MyAccount())
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.solidUserCircle,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('My Account')
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              InkWell(
                splashColor: Palette.primaryColor,
                onTap: () async {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> CartScreen())
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.shoppingCart,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('Cart')
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              InkWell(
                splashColor: Palette.primaryColor,
                onTap: () async {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> OrdersScreen())
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.shoppingBag,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('Orders')
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              InkWell(
                onTap: () async {
                  if(await Connection().hasNetwork()){
                    Future.delayed(const Duration(milliseconds: 500),() async {
                      await _authorization.signOutApp();
                    });
                  } else{
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please connect to Internet first!"),
                        backgroundColor: Palette.primaryColor.withOpacity(0.4),
                        duration: Duration(seconds: 5),
                      )
                    );
                  }
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('Logout')
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}