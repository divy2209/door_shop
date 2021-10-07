import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/models/order_model.dart';

class OrderDatabase{
  final CollectionReference order = FirebaseFirestore.instance.collection('orders');

  Future placeOrder({String orderID, String uid, List<String> crops, List<int> prices, List<int> discounts, List<int> quantities, List<String> address, List<String> units, int subtotal, int total, String dateTime, int status}) async{
    return await order.doc(orderID).set({
      'order uid': orderID,
      'user uid': uid,
      'crop list': crops,
      'price list': prices,
      'discount list': discounts,
      'quantity list': quantities,
      'unit list': units,
      'subtotal': subtotal,
      'total bill': total,
      'date & time': dateTime,
      'delivery address': address,
      'status': status,
      'email': DoorShop.sharedPreferences.getString(DoorShop.email),
      'phone number': DoorShop.sharedPreferences.getInt(DoorShop.phone)
    });
  }

  List<Order> _orderList(QuerySnapshot snap){
    return snap.docs.map((doc){
      return Order(
          orderId: doc.get('order uid'),
          crops: doc.get('crop list'),
          prices: doc.get('price list'),
          discounts: doc.get('discount list'),
          quantities: doc.get('quantity list'),
          units: doc.get('unit list'),
          subtotal: doc.get('subtotal'),
          total: doc.get('total bill'),
          dateTime: doc.get('date & time'),
          address: doc.get('delivery address'),
          status: doc.get('status')
      );
    }).toList();
  }

  Stream<List<Order>> get ordersData{
    return order.where('user uid', isEqualTo: DoorShop.sharedPreferences.getString(DoorShop.userID)).orderBy('order uid', descending: true).snapshots().map(_orderList);
  }

  Future<String> getDeliveryDate(String uid) async {
    var c = await order.doc(uid).get();
    return c.get('delivery date');
  }
}