import 'package:flutter/material.dart';

class UserTextValidators {
  final GlobalKey<FormState> nameValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> emailValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordValidator = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordConfirmationValidator =
      GlobalKey<FormState>();
}
