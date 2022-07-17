import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const Calculator());

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  static const String _title = 'Calculator';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  MyCalculator({Key? key}) : super(key: key);

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

String equation = "0";
String result = "0";
String expression = "";
double equationFontSize = 38.0;
double resultFontSize = 48.0;

class _MyCalculatorState extends State<MyCalculator> {
  @override
  //Przyciski
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonCollor) {
    return Container(
      margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        style: TextButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(1),
          primary: Color(0xffD9A9B2),
          backgroundColor: Color(0xff100E40),
        ),
      ),
    );
  }

  //Operacje
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation.isNotEmpty) {
          equation = equation.substring(0, equation.length - 1);
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "???";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff383B73),
      body: Column(
        children: <Widget>[
          //cyfry
          Container(
            constraints: BoxConstraints(maxHeight: 200),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 100, 20, 0),
            child: SingleChildScrollView(
              child: Text(
                equation,
                style: TextStyle(
                  fontSize: equationFontSize,
                  color: Color(0xffD9A9B2),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(50, 20, 20, 0),
            child: Text(
              result,
              style: TextStyle(
                fontSize: resultFontSize,
                color: Color(0xffD9A9B2),
              ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("⌫", 1, Colors.redAccent),
                        buildButton("÷", 1, Colors.redAccent),
                        const SizedBox(),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.redAccent),
                        buildButton("8", 1, Colors.redAccent),
                        buildButton("9", 1, Colors.redAccent),
                        buildButton("x", 1, Colors.redAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.redAccent),
                        buildButton("5", 1, Colors.redAccent),
                        buildButton("6", 1, Colors.redAccent),
                        buildButton("-", 1, Colors.redAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.redAccent),
                        buildButton("2", 1, Colors.redAccent),
                        buildButton("3", 1, Colors.redAccent),
                        buildButton("+", 1, Colors.redAccent),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("^", 1, Colors.redAccent),
                        buildButton("0", 1, Colors.redAccent),
                        buildButton(".", 1, Colors.redAccent),
                        buildButton("=", 1, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
