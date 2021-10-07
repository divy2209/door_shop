import 'package:door_shop/services/provider_data/login_data.dart';
import 'package:door_shop/widgets/background_image.dart';
import 'package:door_shop/widgets/login_widgets/login_animation.dart';
import 'package:door_shop/widgets/login_widgets/login_button.dart';
import 'package:door_shop/widgets/login_widgets/login_form.dart';
import 'package:provider/provider.dart';

import '../screens.dart';
import 'package:door_shop/services/utility.dart';
import 'package:flutter/material.dart';

// TODO: show textfield border while writing it in

// TODO: tailor the bottom alert dialog box with decoration
// TODO: convert this into phone login
// TODO: Add page opening animation, to make it look good or go aournd the toggleview somehow

class LoginPage extends StatelessWidget {
  final Function toggleView;
  LoginPage({this.toggleView});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            //key: scaffoldKey,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  LoginAnimatedText(),
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        LoginForm(),
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
                        Consumer<LoginData>(
                          builder: (_,login,__){
                            return LoginButton(loading: login.loading,);
                          },
                        ),
                        //LoginButton(),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: (){
                            toggleView();
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
