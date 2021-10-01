import 'package:door_shop/screens/input_address.dart';
import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/provider_data/address_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressDisplay extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool data = DoorShop.sharedPreferences.getString(DoorShop.address)!=null;
    return Consumer<AddressData>(
      builder: (_,address,__){
        return data ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DoorShop.sharedPreferences.getString(DoorShop.address), overflow: TextOverflow.visible, style: TextStyle(fontSize: 16),),
                  Text(DoorShop.sharedPreferences.getString(DoorShop.city) + ", " + DoorShop.sharedPreferences.getString(DoorShop.state), style: TextStyle(fontSize: 16)),
                  Text(DoorShop.sharedPreferences.getInt(DoorShop.pin).toString(), style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){
                Provider.of<AddressData>(context, listen: false).store();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> Address())
                );
              },
            )
          ],
        ) : Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: Palette.primaryColor,
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> Address())
              );
            },
            child: Container(
              height: 35,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Palette.primaryColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(child: Text("Add Address", style: TextStyle(fontWeight: FontWeight.bold),)),
            ),
          ),
        );
      },
    );
  }
}
