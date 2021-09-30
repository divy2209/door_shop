import 'package:door_shop/services/database/crop_data.dart';
import 'package:door_shop/services/database/crop_model.dart';
import 'package:flutter/material.dart';

class CartData extends ChangeNotifier{
  int count = 0;
  List<CartCrop> cart = [];
  int total = 0;
  int gtotal = 0;

  int addToCart(Crop crop){
    int flag = 0;
    int index;
    int n = cart.length;
    for(int i = 0; i<n; i++){
      if(cart[i].identifier==crop.identifier){
        if(crop.quantity>cart[i].count){
          index = i;
          cart[i].count += 1;
          gtotal+=cart[i].dPrice;
          total+=cart[i].price;
        } else {
          index = -1;
          if(crop.quantity<cart[i].count){
            flag = 2;
            gtotal-=(cart[i].count-crop.quantity)*cart[i].dPrice;
            total-=(cart[i].count-crop.quantity)*cart[i].price;
            cart[i].count = crop.quantity;
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
    }
    notifyListeners();
    return flag;
  }

  Future<int> addCart(int index) async {
    int flag = 0;
    int quantity = await CropDatabase().getQuantity(cart[index].identifier);
    if(quantity>cart[index].count){
      cart[index].count += 1;
      gtotal+=cart[index].dPrice;
      total+=cart[index].price;
    } else if(quantity==cart[index].count){
      flag = 1;
    } else {
      total-=(cart[index].count-quantity)*cart[index].price;
      cart[index].count = quantity;
    }

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
      } else {
        cart.removeAt(index);
        count--;
      }
    } else {
      gtotal-=(cart[index].count-quantity)*cart[index].dPrice;
      total-=(cart[index].count-quantity)*cart[index].price;
      cart[index].count = quantity;
      flag = 1;
    }

    notifyListeners();
    return flag;
  }

  // todo:function to check availability for a previously added vegetables

  Future<bool> checkOrder() async {
    // todo: place this check in initstate of home
    // todo: consider price and discount change
    bool flag = false;
    for(int i = 0; i<count; i++){
      print(cart[i].identifier);
      int quantity = await CropDatabase().getQuantity(cart[i].identifier);
      if(quantity==0){
        count--;
        gtotal-=cart[i].dPrice*cart[i].count;
        total-=cart[i].price*cart[i].count;
        flag=true;
        cart.removeAt(i);
        i--;
      } else if(quantity<cart[i].count){
        gtotal-=(cart[i].count-quantity)*cart[i].dPrice;
        total-=(cart[i].count-quantity)*cart[i].price;
        cart[i].count = quantity;
        flag=true;
      }
    }

    notifyListeners();
    return flag;
  }

  Future<void> placeOrder() async {
    for(int i = 0; i<count; i++){
      await CropDatabase().updateQuantity(uid: cart[i].identifier, count: cart[i].count);
    }
    cart.clear();
    total = 0;
    gtotal = 0;
    count = 0;

    notifyListeners();
  }

  @override
  void dispose(){
    super.dispose();
  }
}