import 'package:cached_network_image/cached_network_image.dart';
import 'package:door_shop/screens/my_account.dart';
import 'package:door_shop/services/authentication_services/authorization.dart';
import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/provider_data/authenticate_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final AuthorizationService _authorization = AuthorizationService();

  @override
  Widget build(BuildContext context) {
    final authenticate = Provider.of<AuthenticatingData>(context, listen: false);
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(left: 25, top: 45, right: 25),
        child: Column(
          children: [
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: CachedNetworkImage(
                        imageUrl: DoorShop.sharedPreferences.getString(DoorShop.url),
                        progressIndicatorBuilder: (context, url,
                            downloadProgress) =>
                            CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: Colors.black,),
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              width: 60,
                              height: 60,
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
                  SizedBox(width: 15),
                  Text(
                    "Hello " + (DoorShop.sharedPreferences.getString(DoorShop.name) ?? ''),
                    style: TextStyle(
                        fontSize: 22,
                        color: Palette.primaryColor
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.black, height: 2,),
            TextButton(
              child: Text("My Account"),
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> MyAccount())
                );
              },
            ),
            InkWell(
              onTap: () async {
                authenticate.pageLoading();
                Future.delayed(const Duration(milliseconds: 500),() async {
                  await _authorization.signOutApp();
                });
                authenticate.pageLoading();
              },
              child: Container(
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
              ),
            )
          ],
        ),
      )
    );
  }
}