import 'package:door_shop/services/authentication_services/authorization.dart';
import 'package:door_shop/services/authentication_services/validate.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/loading.dart';
import 'package:flutter/material.dart';

// TODO: use provider package to pass loading state
class Button extends StatefulWidget {

  Button({
    @required this.email,
    @required this.password,
    @required this.flag,
    @required this.label
  });

  final String email;
  final String password;
  final String flag;
  final String label;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  final AuthorizationService _authorization = AuthorizationService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ? Loading() : Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: Palette.buttonBoxDecoration,
      child: TextButton(
        onPressed: () async {
          if(widget.flag == 'login') {
            String showError = CredentialValidation().loginValidation(email: widget.email, password: widget.password);
            if(showError == null) {
              setState(() {
                loading = true;
              });
              dynamic result = await _authorization.login(email: widget.email, password: widget.password);
              if(result == 505284406 || result == 185768934) {
                setState(() {
                  loading = false;
                  if(result == 505284406) {
                    showError = "Email not registered!";
                  } else {
                    showError = "Incorrect password!";
                  }
                });
              }
            }
            if(showError != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(showError),
                  backgroundColor: Palette.primaryColor.withOpacity(0.4),
                  duration: Duration(seconds: 5),
                )
              );
            }
          }
        },
        child: Text(
          widget.label,
          style: Palette.buttonTextStyle,
        ),
      ),
    );
  }
}
