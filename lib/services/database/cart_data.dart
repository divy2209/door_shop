import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/models/cart_model.dart';

class CartDatabase{
  final CollectionReference cart = FirebaseFirestore.instance.collection('carts');

  Future updateCart({List<String> identifiers, List<int> quantities, String uid}) async{
    return await cart.doc(uid).set({
      'veggie list': identifiers,
      'quantity list': quantities,
    });
  }

  Future<Cart> getCart() async{
    var t = await cart.doc(DoorShop.sharedPreferences.getString(DoorShop.userID)).get();
    Cart c = new Cart(
      identifiers: t.get('veggie list'),
      quantities: t.get('quantity list'),
    );
    return c;
  }
}