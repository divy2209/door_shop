import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDatabase{
  final CollectionReference order = FirebaseFirestore.instance.collection('orders');

  Future placeOrder({String orderID, String uid, List<String> crops, List<int> prices, List<int> discounts, List<int> quantities, List<String> address, int total, String dateTime, String status}) async{
    return await order.doc(orderID).set({
      'order uid': orderID,
      'user uid': uid,
      'crop list': crops,
      'price list': prices,
      'discount list': discounts,
      'quantity list': quantities,
      'total bill': total,
      'date & time': dateTime,
      'delivery address': address,
      'status': status,
    });
  }


}