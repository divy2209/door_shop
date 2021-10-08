import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/models/order_model.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/order_widgets/order_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context);
    return Padding(
      padding: EdgeInsets.only(right: 3),
      child: orders==null ? Center(child: CircularProgressIndicator()) : Scrollbar(
        thickness: 4,
        radius: Radius.circular(5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: orders.length!=0 ? ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index){
              Order order = orders[index];
              return Card(
                elevation: 5,
                child: InkWell(
                  splashColor: Palette.primaryColor,
                  onTap: () async{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> OrderSummary(order: order))
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Order ID  ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                Text("#" + order.orderId, style: TextStyle(fontSize: 16),),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                              decoration: BoxDecoration(
                                color: Status.statusColor[order.status],
                                borderRadius: BorderRadius.all(Radius.circular(6))
                              ),
                              child: Text(Status.status[order.status], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                            )
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Order Placed", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                                Text(order.dateTime),
                                SizedBox(height: 20,),
                                Text(order.crops.length.toString() + ' items', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                              ],
                            ),
                            Container(
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Ship to:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                                  Text(DoorShop.sharedPreferences.getString(DoorShop.name), style: TextStyle(fontSize: 14), overflow: TextOverflow.visible,)
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              );
            },
          ) : Center(child: Text("No orders yet, how about some veggies!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
        ),
      ),
    );
  }
}
