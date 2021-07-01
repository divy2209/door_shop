import 'dart:ui';
import 'package:door_shop/services/authentication_services/authorization.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/services/authentication_services/validate.dart';
import 'package:door_shop/widgets/loading.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ? Loading() : Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Stack(
        children: [
          //BackgroundImage(image: ''),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
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
                    height: size.height * 0.1,
                  ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.textBoxDeco,
                            child: Center(
                              child: TextFormField(
                                decoration: TextFieldInputDecoration.nameField,
                                onChanged: (value){
                                  name = value.trim();
                                },
                                style: Palette.inputTextStyle,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.textBoxDeco,
                            child: Center(
                              child: TextFormField(
                                decoration: TextFieldInputDecoration.phoneField,
                                onChanged: (value){
                                  phoneNumber = int.tryParse(value.trim());
                                },
                                style: Palette.inputTextStyle,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          // TODO: after the email goes out the textfield, the text get's small
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.textBoxDeco,
                            child: Center(
                              child: TextFormField(
                                decoration: TextFieldInputDecoration.emailField,
                                onChanged: (value){
                                  email = value.trim();
                                },
                                style: Palette.inputTextStyle,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ),
                        Padding(
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
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.textBoxDeco,
                            child: Center(
                              child: TextFormField(
                                decoration: TextFieldInputDecoration.confirmPasswordField,
                                onChanged: (value){
                                  confirmPassword = value;
                                },
                                obscureText: true,
                                style: Palette.inputTextStyle,
                                textInputAction: TextInputAction.done,
                              ),
                            ),
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
                              // TODO: make a class to validate all of them in a single go and put the whole validation class in another file
                              String showError = CredentialValidation().registerValidation(name: name, phone: phoneNumber, email: email, password: password, confirmPassword: confirmPassword);
                              if(showError == null){
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authorization.register(email: email, password: password, name: name, phone: phoneNumber);
                                if (result == null){
                                  setState(() {
                                    loading = false;
                                    print('Error');
                                  });
                                }
                                Navigator.pop(context);
                                print(name);
                                print(phoneNumber);
                                print(email);
                                print(password);
                                print(confirmPassword);
                              } else {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context){
                                    return Container(
                                      height: size.height * 0.3,
                                      width: size.width,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(showError)
                                          ],
                                        ),
                                      ),
                                    );
                                  }
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
                                //widget.toggleView();
                                Navigator.pop(context);
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