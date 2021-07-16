import 'package:door_shop/services/utility.dart';
import 'package:door_shop/services/authentication_services/validate.dart';
import 'package:door_shop/widgets/background_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  static int phoneNumber;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: Stack(
        children: [
          BackgroundImage(image: 'assets/forgotpassword.jpg',),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              title: Text(
                'Forgot Password',
                style: Palette.inputTextStyle,
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.18,
                      ),
                      Container(
                        width: size.width * 0.8,
                        child: Text(
                          'Enter your phone number and we\'ll send otp to reset your password',
                          style: Palette.inputTextStyle,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: size.height * 0.08,
                            width: size.width * 0.8,
                            decoration: Palette.textBoxDeco,
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Icon(
                                      FontAwesomeIcons.phone,
                                      size: 28,
                                      color: Colors.white
                                    ),
                                  ),
                                  hintText: 'Phone Number',
                                  hintStyle: Palette.inputTextStyle
                                ),
                                onChanged: (value){
                                  phoneNumber = int.tryParse(value.trim());
                                },
                                style: Palette.inputTextStyle,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        decoration: Palette.buttonBoxDecoration,
                        child: TextButton(
                          onPressed: () async {
                            String showError = CredentialValidation().forgotPasswordValidation(phone: phoneNumber);
                            if(showError == null){
                              print(phoneNumber);
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
                            'Send',
                            style: Palette.buttonTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}