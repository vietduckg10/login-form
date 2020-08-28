import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'form_widgets.dart';
import 'sign_in.dart';
import 'story_generator.dart';

class ScreenHelper{
  static gotoSignIn(BuildContext context, {String username}){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(username: username)));
  }
  static gotoFormWidgets(BuildContext context, {String username, String Adj, String Noun}){
    Navigator.push(context, MaterialPageRoute(builder: (context) => FormWidgetsScreen(username: username, Adj: Adj, Noun: Noun,)));
  }
  static gotoStoryGenerator(BuildContext context, {String username, String Adj, String Noun}){
    Navigator.push(context, MaterialPageRoute(builder: (context) => StoryGeneratorScreen(username: username, Adj: Adj, Noun: Noun)));
  }
}