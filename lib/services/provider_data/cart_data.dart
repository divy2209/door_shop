import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/database/cart_data.dart';
import 'package:door_shop/services/database/crop_data.dart';
import 'package:door_shop/services/database/crop_model.dart';
import 'package:door_shop/services/database/order_data.dart';
import 'package:door_shop/services/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartData extends ChangeNotifier{
  int count = 0;
  List<CartCrop> cart = [];
  int total = 0;
  int gtotal = 0;

  bool loading = false;
  bool running = false;

  List<String> crops = [];
  List<int> prices = [];
  List<int> discounts = [];
  List<int> quantities = [];
  List<String> units = [];

  List<String> identifiers = [];

  Future<int> addToCart(Crop crop) async{
    int flag = 0;
    int index;
    int n = cart.length;
    for(int i = 0; i<n; i++){
      if(cart[i].identifier==crop.identifier){
        if(crop.quantity>cart[i].count){
          index = i;
          cart[i].count += 1;
          quantities[i]+=1;
          gtotal+=cart[i].dPrice;
          total+=cart[i].price;
        } else {
          index = -1;
          if(crop.quantity<cart[i].count){
            flag = 2;
            gtotal-=(cart[i].count-crop.quantity)*cart[i].dPrice;
            total-=(cart[i].count-crop.quantity)*cart[i].price;
            cart[i].count = crop.quantity;
            quantities[i] = crop.quantity;
          } else flag = 1;
        }
        break;
      }
    }

    if(index==null){
      CartCrop c = CartCrop(
          identifier: crop.identifier,
          name: crop.name,
          unit: crop.unit,
          quantity: crop.quantity,
          price: crop.price,
          discount: crop.discount,
          dPrice: (crop.price*(1-crop.discount/100)).round(),
          url: crop.url,
          count: 1
      );
      gtotal+=c.dPrice;
      total+=c.price;
      cart.add(c);
      count = cart.length;

      identifiers.add(crop.identifier);
      crops.add(crop.name);
      prices.add(crop.price);
      discounts.add(crop.discount);
      quantities.add(1);
      units.add(crop.unit);
    }
    await CartDatabase().updateCart(identifiers: identifiers, quantities: quantities, uid: DoorShop.sharedPreferences.getString(DoorShop.userID));
    notifyListeners();
    return flag;
  }

  Future<int> addCart(int index) async {
    int flag = 0;
    int quantity = await CropDatabase().getQuantity(cart[index].identifier);
    if(quantity>cart[index].count){
      cart[index].count += 1;
      quantities[index] += 1;
      gtotal+=cart[index].dPrice;
      total+=cart[index].price;
    } else if(quantity==cart[index].count){
      flag = 1;
    } else {
      gtotal-=(cart[index].count-quantity)*cart[index].dPrice;
      total-=(cart[index].count-quantity)*cart[index].price;
      cart[index].count = quantity;
      quantities[index] = quantity;
    }
    await CartDatabase().updateCart(identifiers: identifiers, quantities: quantities, uid: DoorShop.sharedPreferences.getString(DoorShop.userID));
    notifyListeners();
    return flag;
  }

  Future<int> substractCart(int index) async{
    int flag = 0;
    int quantity = await CropDatabase().getQuantity(cart[index].identifier);
    if(quantity>=cart[index].count || quantity==cart[index].count-1){
      gtotal-=cart[index].dPrice;
      total-=cart[index].price;
      if(cart[index].count>1){
        cart[index].count -= 1;
        quantities[index] -= 1;
      } else {
        cart.removeAt(index);
        count--;

        identifiers.removeAt(index);
        crops.removeAt(index);
        prices.removeAt(index);
        discounts.removeAt(index);
        quantities.removeAt(index);
        units.removeAt(index);
      }
    } else {
      gtotal-=(cart[index].count-quantity)*cart[index].dPrice;
      total-=(cart[index].count-quantity)*cart[index].price;
      cart[index].count = quantity;
      quantities[index] = quantity;
      flag = 1;
    }
    await CartDatabase().updateCart(identifiers: identifiers, quantities: quantities, uid: DoorShop.sharedPreferences.getString(DoorShop.userID));
    notifyListeners();
    return flag;
  }

  Future<int> placeOrder(List<String> address) async {
    for(int i = 0; i<count; i++){
      await CropDatabase().updateQuantity(uid: cart[i].identifier, count: cart[i].count);
    }

    String dateTime = DateFormat.yMMMMd('en_US').add_jm().format(DateTime.now());
    await OrderDatabase().placeOrder(
      uid: DoorShop.sharedPreferences.getString(DoorShop.userID),
      orderID: DateTime.now().millisecondsSinceEpoch.toString(),
      crops: crops,
      prices: prices,
      discounts: discounts,
      quantities: quantities,
      units: units,
      subtotal: total,
      total: gtotal,
      status: 0,
      address: address,
      dateTime: dateTime,
    );
    notifyListeners();
    return gtotal;
  }

  void retrieveCart() async{
    Cart c = await CartDatabase().getCart();
    int n = c.identifiers.length;

    for(int i = 0; i<n; i++){
      String uid = c.identifiers[i].toString();
      Crop crop = await CropDatabase().getCrop(uid);
      if(crop.quantity>=c.quantities[i]){
        CartCrop cc = CartCrop(
            identifier: crop.identifier,
            name: crop.name,
            unit: crop.unit,
            quantity: crop.quantity,
            price: crop.price,
            discount: crop.discount,
            dPrice: (crop.price*(1-crop.discount/100)).round(),
            url: crop.url,
            count: c.quantities[i]
        );
        gtotal+=cc.dPrice;
        total+=cc.price;
        cart.add(cc);
        count = cart.length;

        identifiers.add(crop.identifier);
        crops.add(crop.name);
        prices.add(crop.price);
        discounts.add(crop.discount);
        quantities.add(c.quantities[0]);
        units.add(crop.unit);
      }
    }
    await CartDatabase().updateCart(identifiers: identifiers, quantities: quantities, uid: DoorShop.sharedPreferences.getString(DoorShop.userID));
    notifyListeners();
  }

  void resetCart() async{
    cart.clear();
    total = 0;
    gtotal = 0;
    count = 0;

    crops.clear();
    prices.clear();
    discounts.clear();
    quantities.clear();
    units.clear();
    identifiers.clear();

    await CartDatabase().updateCart(identifiers: identifiers, quantities: quantities, uid: DoorShop.sharedPreferences.getString(DoorShop.userID));

    notifyListeners();
  }

  void buttonLoading(){
    loading = !loading;
    notifyListeners();
  }

  void processRunning(){
    running = !running;
    notifyListeners();
  }

  @override
  void dispose(){
    super.dispose();
  }
}