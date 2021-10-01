import 'package:door_shop/services/config.dart';
import 'package:flutter/material.dart';

class AddressData extends ChangeNotifier{
  String address;
  String city;
  String state;
  int pin;

  bool loading = false;
  bool running = false;

  List<String> completeAddress = [];

  void input(String hint, String str){
    if(hint == AddressFieldHint.address){
      address = str;
    } else if(hint == AddressFieldHint.city){
      city = str;
    } else if(hint == AddressFieldHint.state){
      state = str;
    } else {
      pin = int.tryParse(str);
    }

    notifyListeners();
  }

  void store(){
    address = DoorShop.sharedPreferences.getString(DoorShop.address);
    city = DoorShop.sharedPreferences.getString(DoorShop.city);
    state = DoorShop.sharedPreferences.getString(DoorShop.state);
    pin = DoorShop.sharedPreferences.getInt(DoorShop.pin);

    notifyListeners();
  }

  void update(){
    completeAddress.clear();
    DoorShop.sharedPreferences.setString(DoorShop.address, address);
    DoorShop.sharedPreferences.setString(DoorShop.city, city);
    DoorShop.sharedPreferences.setString(DoorShop.state, state);
    DoorShop.sharedPreferences.setInt(DoorShop.pin, pin);

    completeAddress.add(address);
    completeAddress.add(city);
    completeAddress.add(state);
    completeAddress.add(pin.toString());

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
}