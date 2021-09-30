import 'package:door_shop/services/config.dart';
import 'package:door_shop/services/provider_data/register_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../text_field.dart';

class RegisterForm extends StatelessWidget {
  String form = FormIdentifier.register;

  @override
  Widget build(BuildContext context) {
    final register = Provider.of<RegisterData>(context, listen: false);
    return Form(
      child: Column(
        children: [
          InputField(
            controller: register.nameController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.name,
            hintText: TextFieldHint.name,
            icon: FontAwesomeIcons.user,
            inputFormat: FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
            form: form,
          ),
          InputField(
            controller: register.phoneController,
            icon: FontAwesomeIcons.phone,
            hintText: TextFieldHint.phone,
            inputAction: TextInputAction.next,
            inputType: TextInputType.phone,
            inputFormat: FilteringTextInputFormatter.digitsOnly,
            form: form,
          ),
          InputField(
            controller: register.emailController,
            inputAction: TextInputAction.next,
            inputType: TextInputType.emailAddress,
            hintText: TextFieldHint.email,
            icon: FontAwesomeIcons.envelope,
            form: form,
          ),
          InputField(
            isObscure: true,
            icon: FontAwesomeIcons.lock,
            hintText: TextFieldHint.password,
            inputAction: TextInputAction.next,
            controller: register.passwordController,
            form: form,
          ),
          InputField(
            controller: register.confirmPasswordController,
            inputAction: TextInputAction.done,
            hintText: TextFieldHint.confirmPassword,
            icon: FontAwesomeIcons.lock,
            isObscure: true,
            form: form,
          ),
        ],
      ),
    );
  }
}
