import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/provider_data/login_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../text_field.dart';

class LoginForm extends StatelessWidget {
  final String form = FormIdentifier.login;

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginData>(context, listen: false);
    return Form(
      child: Column(
        children: [
          InputField(
            inputAction: TextInputAction.next,
            inputType: TextInputType.emailAddress,
            controller: login.emailController,
            icon: FontAwesomeIcons.envelope,
            hintText: TextFieldHint.email,
            form: form,
          ),
          InputField(
            hintText: TextFieldHint.password,
            icon: FontAwesomeIcons.lock,
            inputAction: TextInputAction.done,
            isObscure: true,
            controller: login.passwordController,
            form: form,
          ),
        ],
      ),
    );
  }
}
