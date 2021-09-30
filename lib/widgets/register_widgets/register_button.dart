import 'package:door_shop/services/authentication_services/authorization.dart';
import 'package:door_shop/services/authentication_services/validate.dart';
import 'package:door_shop/services/database/user_data.dart';
import 'package:door_shop/services/provider_data/register_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterButton extends StatelessWidget {
  final AuthorizationService _authorization = AuthorizationService();

  static String name;
  static int phoneNumber;
  static String email;
  static String password;
  static String confirmPassword;

  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterData>(context, listen: false);
    return Button(
      text: 'Register',
      click: () async {
        name = register.name!=null ? register.name.trim() : null;
        phoneNumber = register.phone!=null ? int.tryParse(register.phone.trim()) : null;
        email = register.email != null ? register.email.trim() : null;
        password = register.password;
        confirmPassword = register.confirmPassword;

        String showError = CredentialValidation().registerValidation(name: name, phone: phoneNumber, email: email, password: password, confirmPassword: confirmPassword);
        if(showError == null){
          if(register.imageFile!=null){
            //register.pageLoading();
            String url = await UserDatabase().upload(register.imageFile);
            if(url!=null){
              dynamic result = await _authorization.register(email: email, password: password, name: name, phone: phoneNumber, url: url);
              if (result == 34618382){
                //register.pageLoading();
                showError = 'Email already exists!';
              }
            } else showError = 'Image not uploaded';
          } else showError = 'Select an image';
        }
        if(showError != null){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(showError),
                backgroundColor: Palette.primaryColor.withOpacity(0.4),
                duration: Duration(seconds: 5),
              )
          );
        }
      },
    );
  }
}
