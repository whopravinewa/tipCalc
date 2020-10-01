import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;
  var _controller = TextEditingController();
  Color _color = Color(0xfff9f9f9);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: _color, statusBarIconBrightness: Brightness.dark));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Bill Splitter"),
        ),
        child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            alignment: Alignment.center,
            child: ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(20.5),
                children: <Widget>[
                  //top containter
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Total per Person",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Rs. ${calculateTotalPerPerson(_tipPercentage, _billAmount, _personCounter)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32.0,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                        )
                      ],
                    ),
                  ),
                  //second container--------------------------------------------------
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color: Colors.blueGrey.shade100.withOpacity(0.4),
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Column(children: <Widget>[
                      //first column--------------------------------------------------------
                      CupertinoTextField(
                        controller: _controller,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        textInputAction: TextInputAction.done,
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                        maxLength: 8,
                        // decoration: InputDecoration(
                        //   hintText: "Enter your Bill Amount",
                        //   labelText: "Bill Amount",
                        //   labelStyle: new TextStyle(color: Colors.grey.shade700),
                        //   enabledBorder: new UnderlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.grey)),
                        //   focusedBorder: new UnderlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.black)),
                        // ),
                        placeholder: "Bill Amount",
                        padding: EdgeInsets.all(18.0),
                        clearButtonMode: OverlayVisibilityMode.editing,
                        prefix: Text(
                          "Bill Amount",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        onChanged: (String value) {
                          try {
                            if (double.parse(value) == 0) {
                              _controller.clear();
                            }
                            setState(() {
                              _billAmount = double.parse(value);
                            });
                          } catch (e) {
                            setState(() {
                              _billAmount = 0.0;
                            });
                          }
                        },
                      ),
                      //second column--------------------------------------------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Split",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                decoration: TextDecoration.none),
                          ),
                          Row(children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_personCounter > 1) {
                                    _personCounter--;
                                  }
                                });
                              },
                              child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.0),
                                      color: Colors.black.withOpacity(0.1)),
                                  child: Center(
                                      child: Text(
                                    "-",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        decoration: TextDecoration.none),
                                  ))),
                            ),
                            Text("$_personCounter",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    decoration: TextDecoration.none)),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _personCounter++;
                                });
                              },
                              child: Container(
                                  width: 40.0,
                                  height: 40.0,
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.0),
                                      color: Colors.black.withOpacity(0.1)),
                                  child: Center(
                                      child: Text(
                                    "+",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        decoration: TextDecoration.none),
                                  ))),
                            )
                          ])
                        ],
                      ),
                      //third column--------------------------------------------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Tip",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none)),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                                "Rs. ${calculateTotalTip(_billAmount, _personCounter, _tipPercentage).toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    decoration: TextDecoration.none)),
                          )
                        ],
                      ),
                      //last column slider
                      Column(
                        children: <Widget>[
                          Text(
                            "$_tipPercentage%",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: CupertinoSlider(
                                min: 0,
                                max: 100,
                                activeColor: Colors.black,
                                value: _tipPercentage.toDouble(),
                                onChanged: (double value) {
                                  setState(() {
                                    _tipPercentage = value.round();
                                  });
                                }),
                          )
                        ],
                      )
                    ]),
                  )
                ])),
      ),
    );
  }

  calculateTotalPerPerson(double tipPercentage, double billAmount, int splitBy) {
    return ((calculateTotalTip(billAmount, splitBy, tipPercentage) +
                billAmount) /
            splitBy)
        .toStringAsFixed(2);
  }

  //percentage should double rather than integer
  calculateTotalTip(double billAmount, int splitBy, double tipPercentage) {
    double totalTip = 0.0;

    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    
    //only use 2 decimal for better readable
    return totalTip.toStringAsFixed(2);
  }
}
