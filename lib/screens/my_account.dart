import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/checkout_widgets/address_display.dart';
import 'package:flutter/material.dart';


class MyAccount extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        elevation: 0,
        title: Text('My Account'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: size.width*0.16,
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
                SizedBox(width: 30,),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DoorShop.sharedPreferences.getString(DoorShop.name), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    SizedBox(height: 25,),
                    Text(DoorShop.sharedPreferences.getString(DoorShop.email), style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                    Text("+91 " + DoorShop.sharedPreferences.getInt(DoorShop.phone).toString(), style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,)
                  ],
                )
              ],
            ),
            SizedBox(height: 50,),
            Text("Saved Address", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
            SizedBox(height: 8,),
            Divider(thickness: 1, color: Colors.grey,),
            SizedBox(height: 15,),
            AddressDisplay(),
          ],
        ),
      ),
    );
  }
}
