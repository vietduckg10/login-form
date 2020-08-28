import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tuan1_bai2/screenhelper.dart';
import 'package:english_words/english_words.dart';

class StoryGeneratorScreen extends StatefulWidget {
  StoryGeneratorScreen({Key key, this.title, this.username, this.Adj, this.Noun}) : super(key: key);

  String username, Adj, Noun;
  final String title;

  @override
  _StoryGeneratorScreen createState() => _StoryGeneratorScreen(username,Adj,Noun);
}

class _StoryGeneratorScreen extends State<StoryGeneratorScreen> {
  String username, Adj, Noun;
  _StoryGeneratorScreen(this.username,this.Adj,this.Noun);

  final _formAdj = GlobalKey<FormState>();
  final _formNoun = GlobalKey<FormState>();
  bool checkboxvalue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            setState(() {
              ScreenHelper.gotoSignIn(context, username: username);
            });
          },
        ),
          backgroundColor: Colors.teal,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    child: Text('📖 Story Generator'),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(left: 60)),
              Column(
                children: [
                  Container(
                    child: RaisedButton(
                      color: Colors.teal,
                     child: Text(
                       'Submit',
                       style: TextStyle(fontSize: 14),
                     ),
                      onPressed: (){
                        if(_formAdj.currentState.validate()){
                          if(_formNoun.currentState.validate()){
                            if(checkboxvalue == false)
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Please check the box'),
                                    actions: [
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: (){
                                          Navigator.of(context,rootNavigator: true).pop('dialog');
                                        },
                                      )
                                    ],
                                  );
                                }
                              );
                            else
                              setState(() {
                                ScreenHelper.gotoFormWidgets(context, username: username,Adj: Adj,Noun: Noun);
                              });
                          }
                        }
                      },
                    )
                  )
                ],
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formAdj,
                child: TextFormField(
                  initialValue: Adj,
                  onChanged: (text){
                    Adj = text;
                  },
                  validator: (adj){
                   if (adj.isEmpty)
                      return 'Please enter an adjective';
                    else
                        if(adjectives.contains(adj))
                          return null;
                        return 'This is not an adjective';
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter an adjective',
                      hintText: 'e.g. quick, beautiful, interesting',
                      filled: true,
                      fillColor: Colors.grey[100]
                  ),
                ),
              )
            ),
            Padding(padding: EdgeInsets.only(top: 8)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formNoun,
                child: TextFormField(
                  initialValue: Noun,
                  onChanged: (text){
                    Noun = text;
                  },
                  validator: (noun){
                    if (noun.isEmpty)
                      return 'Please enter a noun';
                    else
                        if(nouns.contains(noun))
                          return null;
                        return 'This is not a noun';
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter an noun',
                      hintText: 'i.e. a person, place or thing',
                      filled: true,
                      fillColor: Colors.grey[100]),
                ),
              )
            ),
            Padding(padding: EdgeInsets.only(top:16)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Checkbox(
                    value: checkboxvalue,
                    activeColor: Colors.teal,
                    onChanged: (newvalue) {
                      setState(() {
                        checkboxvalue = newvalue;
                      });
                    },
                  ),
                  Text('I agree to the terms of service')
                ],
              ),
            )
          ],
        ));
  }
}