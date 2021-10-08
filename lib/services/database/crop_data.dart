import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'crop_model.dart';

class CropDatabase{
  final CollectionReference crop = FirebaseFirestore.instance.collection('crops');
  dynamic rupee = FontAwesomeIcons.rupeeSign;

  List<Crop> _cropsDataList(QuerySnapshot snap){
    return snap.docs.map((doc){
      return Crop(
          identifier: doc.get('crop uid'),
          name: doc.get('crop name'),
          price: doc.get('price $rupee'),
          quantity: doc.get('quantity'),
          unit: doc.get('pricing and quantity unit'),
          discount: doc.get('discount'),
          url: doc.get('image url')
      );
    }).toList();
  }

  Stream<List<Crop>>get cropsData{
    return crop.snapshots().map(_cropsDataList);
  }

  Future<int> getQuantity(String uid) async {
    var c = await crop.doc(uid).get();
    return c.get('quantity');
  }

  Future<Crop> getCrop(String uid) async {
    var t = await crop.doc(uid).get();
    Crop c = new Crop(
      identifier: t.get('crop uid'),
      name: t.get('crop name'),
      discount: t.get('discount'),
      url: t.get('image url'),
      price: t.get('price $rupee'),
      quantity: t.get('quantity'),
      unit: t.get('pricing and quantity unit')
    );
    return c;
  }

  Future updateQuantity({String uid, int count}) async {
    int quantity = await getQuantity(uid);
    int newQuantity = quantity-count;
    return await crop.doc(uid).update({
      'quantity': newQuantity,
    });
  }
}