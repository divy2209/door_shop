import 'package:door_shop/services/authentication_services/authorization.dart';
import 'package:door_shop/services/authentication_services/validate.dart';
import 'package:door_shop/widgets/background_image.dart';
import 'package:door_shop/widgets/loading.dart';
import 'package:flutter/animation.dart';

import '../screens.dart';
import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO: show textfield border while writing it in

// TODO: tailor the bottom alert dialog box with decoration
// TODO: convert this into phone login
// TODO: Add page opening animation, to make it look good or go aournd the toggleview somehow

class LoginPage extends StatefulWidget {
  //final Function toggleView;
  //LoginPage({this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthorizationService _authorization = AuthorizationService();
  bool loading = false;

  //static int phoneNumber;
  static String email;
  static String password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ? Loading() : GestureDetector(
      onTap: (){
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.focusedChild.unfocus();
        }
      },
      child: Stack(
        children: [
          BackgroundImage(image: 'assets/login.jpg'),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 175,
                  ),
                  Flexible(
                    flex: 0,
                    child: Center(
                      child: Text(
                        'Door Shop',
                        // TODO: In the door shop, make the d with the logo d or add the logo along with the name
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.textBoxDeco,
                            child: Center(
                              child: TextFormField(
                                decoration: TextFieldInputDecoration.emailField,
                                //decoration: TextFieldInputDecoration.phoneField,
                                onChanged: (value){
                                  // TODO: put this inside setState to make it work
                                  //phoneNumber = int.tryParse(value.trim());
                                  email = value.trim();
                                },
                                style: Palette.inputTextStyle,
                                keyboardType: TextInputType.emailAddress,
                                //keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          // TODO: add passowrd visible eye icon
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.textBoxDeco,
                            child: Center(
                              child: TextFormField(
                                decoration: TextFieldInputDecoration.passwordField,
                                onChanged: (value){
                                  password = value;
                                },
                                obscureText: true,
                                style: Palette.inputTextStyle,
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordPage())
                            );
                          },
                          child: Text(
                            'Forgot Password',
                            style: Palette.inputTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: Palette.buttonBoxDecoration,
                          child: TextButton(
                            onPressed: () async {
                              // TODO: Add incorrect password error
                              String showError = CredentialValidation().loginValidation(email: email, password: password);
                              if(showError == null) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authorization.login(email: email, password: password);
                                if (result == 505284406 || result == 185768934){
                                  setState(() {
                                    loading = false;
                                    if(result == 505284406){
                                      showError = "Email not registered!";
                                    } else {
                                      showError = "Incorrect password!";
                                    }
                                    //print(showError);
                                  });
                                }
                                //print(email/*phoneNumber*/);
                                //print(password);
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
                            child: Text(
                              'Login',
                              style: Palette.buttonTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: (){
                            //widget.toggleView();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterPage()),
                              ModalRoute.withName('/')
                            );
                          },
                          child: Container(
                            child: Text(
                              'Create New Account',
                              style: Palette.inputTextStyle,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.white
                                )
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}