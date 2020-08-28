import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tuan1_bai2/screenhelper.dart';
import 'package:intl/intl.dart';

class FormWidgetsScreen extends StatefulWidget {
  FormWidgetsScreen({Key key, this.title, this.Adj, this.Noun, this.username})
      : super(key: key);

  String Adj, Noun, username;
  final String title;

  @override
  _FormWidgetsScreen createState() => _FormWidgetsScreen(Adj, Noun, username);
}

class _FormWidgetsScreen extends State<FormWidgetsScreen> {
  String Adj, Noun, username;
  double rating = 50;
  int money = 257;
  DateTime date = DateTime.now();
  bool checkboxvalue = true;
  bool switchvalue = true;

  _FormWidgetsScreen(this.Adj, this.Noun, this.username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                ScreenHelper.gotoStoryGenerator(context,
                    username: username, Adj: Adj, Noun: Noun);
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
                    child: Text('Form widgets'),
                  )
                ],
              )
            ],
          ),
        ),
        body: Container(
            height: 540,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Title',
                        hintText: 'Enter title',
                        filled: true,
                        fillColor: Colors.grey[100]),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 130,
                    child: TextFormField(
                      initialValue: Adj + ' ' + Noun,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          labelText: 'Description',
                          hintText: 'Enter description',
                          filled: true,
                          fillColor: Colors.grey[100]),
                      maxLines: 10,
                    )),
                Padding(padding: EdgeInsets.only(top: 24)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Text(
                              'Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Text(
                              date.day.toString() +
                                  '/' +
                                  date.month.toString() +
                                  '/' +
                                  date.year.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Container(
                              child: FlatButton(
                            color: Colors.transparent,
                            onPressed: () async {
                              var newDate = await showDatePicker(
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));
                              if (newDate == null)
                                return;
                              else
                                setState(() {
                                  date = newDate;
                                });
                            },
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ))
                        ],
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 12)),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Text(
                                'Estimated value',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Text(
                              "\$" + money.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Slider(
                      value: rating,
                      onChanged: (newRating) {
                        setState(() {
                          rating = newRating;
                          money = (514 * rating / 100).toInt();
                        });
                        //setState(() => rating = newRating);
                      },
                      min: 0,
                      max: 100,
                      activeColor: Colors.teal,
                    )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Checkbox(
                            value: checkboxvalue,
                            activeColor: Colors.teal,
                            onChanged: (newvalue) {
                              setState(() {
                                checkboxvalue = newvalue;
                              });
                            },
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            child: Text(
                              'Brushed Teeth',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 12)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Enable feature',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Container(
                            child: Switch(
                              value: switchvalue,
                              onChanged: (newSwitchvalue) {
                                setState(() {
                                  switchvalue = newSwitchvalue;
                                });
                              },
                              activeColor: Colors.teal,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
