import 'package:door_shop/services/utility.dart';
import 'package:door_shop/services/authentication_services/validate.dart';
import 'package:door_shop/widgets/background_image.dart';
import 'package:door_shop/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  static int phoneNumber;

  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
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
                        child: InputField(
                          isObscure: false,
                          icon: FontAwesomeIcons.phone,
                          hintText: 'Phone Number',
                          inputType: TextInputType.phone,
                          inputAction: TextInputAction.done,
                          inputFormat: FilteringTextInputFormatter.digitsOnly,
                          controller: _phoneController,
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
                            phoneNumber = int.tryParse(_phoneController.text.trim());
                            String showError = CredentialValidation().forgotPasswordValidation(phone: phoneNumber);
                            if(showError == null){
                              print(phoneNumber);
                            } else {
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