import 'dart:convert';
import 'validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tuan1_bai2/screenhelper.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
//import 'dart:html';

//i changed login
FormData fromJson(Map<String, dynamic> json) {
  return FormData(
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

FormData _$FormDataFromJson(Map<String, dynamic> json) {
  return FormData(
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

@JsonSerializable()
class FormData {
  String username;
  String password;

  FormData({this.username, this.password});

  Map<String, dynamic> _$FormDataToJson(FormData instance) => <String, dynamic>{
        'username': instance.username,
        'password': instance.password,
      };

  factory FormData.fromJson(Map<String, dynamic> json) =>
      _$FormDataFromJson(json);

  Map<String, dynamic> toJson() => _$FormDataToJson(this);
}

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key, this.title, this.username}) : super(key: key);

  final httpclient = http.Client();
  String username;

  final String title;

  @override
  _SignInScreen createState() => _SignInScreen(username);
}

class _SignInScreen extends State<SignInScreen> {
  String username, password, usernameerror = '', passworderror = '';
  int usernamedata;
  List<String> listuser = ['duc@gmail.com', 'abc@gmail.com'];
  List<String> listpassword = ['123', 'abc'];
  FormData formdata = FormData();
  Color usernameborder = Colors.blue, passwordborder = Colors.blue;

  _SignInScreen(this.username){
    formdata.username = username;
  }

  final _formName = GlobalKey<FormState>();
  final _formPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int checkword(List<String> list, String word) {
      int i;
      for (i = 0; i < list.length; i++) if (word == list[i]) return i;
      return null;
    }

    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          backgroundColor: Colors.teal,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    child: Text('Sign in Form'),
                  )
                ],
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 16),),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formName,
                  child: TextFormField(
                    //controller: test,
                    initialValue: username,
                    onChanged: (text) {
                      formdata.username = text;
                    },
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: usernameborder,
                          )
                        ),
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Your Email Address'),
                  ),
                )
            ),
            Padding(padding: EdgeInsets.only(top: 8),),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 24),),
                SizedBox(
                  height: 16,
                  child: Text(
                    usernameerror,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top:8),),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formPassword,
                  child: TextFormField(
                    onChanged: (text) {
                      formdata.password = text;
                    },
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: passwordborder,
                          )
                        ),
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.grey[100]),
                  ),
                )
            ),
            Padding(padding: EdgeInsets.only(top: 8),),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 24),),
                SizedBox(
                  height: 16,
                  child: Text(
                    passworderror,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.only(top: 16),
                child: RaisedButton(
                    color: Colors.grey[100],
                    onPressed: () async {
                      var result = await widget.httpclient.post(
                          'http://10.238.239.151:3000/users/login',
                          body: json.encode(formdata.toJson()),
                          headers: {'content-type': 'application/json'});
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                child: Container(
                                  height: 100,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                      ),
                                      CircularProgressIndicator(),
                                      Padding(
                                        padding: EdgeInsets.only(left: 16),
                                      ),
                                      Text('Loading')
                                    ],
                                  ),
                                )
                            );
                          }
                      );
                      if (result.statusCode == 200) {
                        print(result.body);
                        if(result.body == 'success')
                          setState(() {
                            Navigator.of(context,rootNavigator: true).pop('dialog');
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                      child: Container(
                                        height: 150,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                'Login Success',
                                              style: TextStyle(
                                                fontSize: 20
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: (){
                                                setState(() {
                                                  ScreenHelper.gotoStoryGenerator(context, username: formdata.username);
                                                });
                                              },
                                              child: Text(
                                                  'ok',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                  );
                                }
                            );
                          }
                          );
                        else
                          setState(() {
                            Navigator.of(context,rootNavigator: true).pop('dialog');
                            if (result.body == 'fail user' || result.body == 'fail both'){
                              usernameborder = Colors.red;
                              usernameerror = Validator.Username(formdata.username);
                            }
                            else
                              {
                                usernameborder = Colors.blue;
                                usernameerror = '';
                              }
                            if(result.body == 'fail password' || result.body == 'fail both'){
                              passwordborder = Colors.red;
                              passworderror = Validator.Password(formdata.password);
                            }
                            else
                              {
                                passwordborder = Colors.blue;
                                passworderror = '';
                              }
                          }
                          );
                      }

                      //gotostorygenerator();
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                )
            )
          ],
        )
    );
  }
}