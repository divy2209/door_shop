import 'dart:ui';
import 'package:door_shop/screens/authentication_screens/login.dart';
import 'package:door_shop/services/authentication_services/authorization.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/services/authentication_services/validate.dart';
import 'package:door_shop/widgets/background_image.dart';
import 'package:door_shop/widgets/loading.dart';
import 'package:door_shop/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// TODO: put up a screening if that contact-number/email already exists and if not then go forward with the registration

class RegisterPage extends StatefulWidget {
  //final Function toggleView;
  //RegisterPage({@required this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthorizationService _authorization = AuthorizationService();
  bool loading = false;

  static String name;
  static int phoneNumber;
  static String email;
  static String password;
  static String confirmPassword;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cPasswordController = TextEditingController();

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
          BackgroundImage(image: 'assets/register.jpg'),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: CircleAvatar(
                              radius: size.width * 0.14,
                              backgroundColor: Colors.grey[400].withOpacity(0.4),
                              child: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.white,
                                size: size.width * 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.08,
                        left: size.width * 0.56,
                        child: Container(
                          height: size.width * 0.1,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: Palette.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2)
                          ),
                          child: Icon(
                            FontAwesomeIcons.arrowUp,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Form(
                    child: Column(
                      children: [
                        InputField(
                          controller: _nameController,
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.name,
                          hintText: 'Full Name',
                          icon: FontAwesomeIcons.user,
                          isObscure: false,
                          inputFormat: FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                        ),
                        InputField(
                          controller: _phoneController,
                          isObscure: false,
                          icon: FontAwesomeIcons.phone,
                          hintText: 'Phone Number',
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.phone,
                          inputFormat: FilteringTextInputFormatter.digitsOnly,
                        ),
                        InputField(
                          controller: _emailController,
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.emailAddress,
                          hintText: 'Email',
                          icon: FontAwesomeIcons.envelope,
                          isObscure: false,
                          //inputFormat: FilteringTextInputFormatter.singleLineFormatter,
                        ),
                        InputField(
                          isObscure: true,
                          icon: FontAwesomeIcons.lock,
                          hintText: 'Password',
                          inputAction: TextInputAction.next,
                          controller: _passwordController,
                        ),
                        InputField(
                          controller: _cPasswordController,
                          inputAction: TextInputAction.done,
                          hintText: 'Confirm Password',
                          icon: FontAwesomeIcons.lock,
                          isObscure: true,
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
                              // TODO: make a class to validate all of them in a single go and put the whole validation class in another file
                              name = _nameController.text.trim();
                              phoneNumber = int.tryParse(_phoneController.text.trim());
                              email = _emailController.text.trim();
                              password = _passwordController.text;
                              confirmPassword = _cPasswordController.text;
                              String showError = CredentialValidation().registerValidation(name: name, phone: phoneNumber, email: email, password: password, confirmPassword: confirmPassword);
                              if(showError == null){
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authorization.register(email: email, password: password, name: name, phone: phoneNumber);
                                if (result == 34618382){
                                  setState(() {
                                    loading = false;
                                    showError = 'Email already exists!';
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Email Registered, Please login!'),
                                      backgroundColor: Palette.primaryColor.withOpacity(0.4),
                                      duration: Duration(seconds: 5),
                                    )
                                  );
                                  // TODO: solve this issue regarding logging again
                                  await _authorization.signOutApp();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginPage()),
                                      ModalRoute.withName('/')
                                  );
                                }
                                /*print(name);
                                print(phoneNumber);
                                print(email);
                                print(password);
                                print(confirmPassword);*/
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
                              'Register',
                              style: Palette.buttonTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account ',
                              style: Palette.inputTextStyle,
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage()),
                                    ModalRoute.withName('/')
                                );
                              },
                              child: Text(
                                'Login',
                                style: Palette.inputTextStyle.copyWith(
                                  color: Palette.primaryColor,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}