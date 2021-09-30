import 'dart:ui';
import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/provider_data/authenticate_data.dart';
import 'package:door_shop/services/provider_data/register_data.dart';
import 'package:door_shop/services/utility.dart';
import 'package:door_shop/widgets/background_image.dart';
import 'package:door_shop/widgets/loading.dart';
import 'package:door_shop/widgets/register_widgets/image_pick.dart';
import 'package:door_shop/widgets/register_widgets/register_button.dart';
import 'package:door_shop/widgets/register_widgets/register_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO: put up a screening if that contact-number/email already exists and if not then go forward with the registration

class RegisterPage extends StatelessWidget {
  final Function toggleView;
  RegisterPage({@required this.toggleView});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthenticatingData>(
      builder: (context, authenticate, child){
        return authenticate.pageloading ? Loading() : GestureDetector(
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
                      Consumer<RegisterData>(
                        builder: (context, image, child){
                          return ImagePick(
                            form: FormIdentifier.register,
                            imageFile: image.imageFile,
                          );
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      RegisterForm(),
                      SizedBox(
                        height: 25,
                      ),
                      RegisterButton(),
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
                              toggleView();
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
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
