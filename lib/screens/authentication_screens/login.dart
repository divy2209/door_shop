import 'package:door_shop/services/authentication_services/authorization.dart';
import 'package:door_shop/services/authentication_services/validate.dart';
import 'package:door_shop/widgets/background_image.dart';
import 'package:door_shop/widgets/loading.dart';
import 'package:door_shop/widgets/text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens.dart';
import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO: show textfield border while writing it in

// TODO: tailor the bottom alert dialog box with decoration
// TODO: convert this into phone login
// TODO: Add page opening animation, to make it look good or go aournd the toggleview somehow

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthorizationService _authorization = AuthorizationService();
  bool loading = false;

  //static int phoneNumber;
  static String email;
  static String password;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                        InputField(
                          isObscure: false,
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.emailAddress,
                          controller: _emailController,
                          icon: FontAwesomeIcons.envelope,
                          hintText: 'Email',
                        ),
                        InputField(
                          hintText: 'Password',
                          icon: FontAwesomeIcons.lock,
                          inputAction: TextInputAction.done,
                          isObscure: true,
                          controller: _passwordController,
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
                        /*Button(
                          email: email,
                          password: password,
                          flag: 'login',
                          label: 'Login',
                        ),*/
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          decoration: Palette.buttonBoxDecoration,
                          child: TextButton(
                            onPressed: () async {
                              email = _emailController.text.trim();
                              password = _passwordController.text;
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
                                  });
                                }
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
                            widget.toggleView();
                            /*Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterPage()),
                              ModalRoute.withName('/')
                            );*/
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