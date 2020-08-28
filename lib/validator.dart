import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Validator{
  static Username(String username)
  {
    if (username == null || username.isEmpty)
      return 'Please enter username';
    else if (!username.contains('@'))
      return 'This is not a email';
    else
      return 'Incorrect email';
  }
  static Password(String password)
  {
    if (password == null || password.isEmpty)
      return 'Please enter password';
    else
      return 'Incorrect password';
  }
}