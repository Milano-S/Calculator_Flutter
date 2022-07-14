import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: "Calculator",

      //theme: ThemeData.dark().copyWith(
      //primaryColor: Colors.deepPurple
      //),
      theme: ThemeData.dark().copyWith(
primaryColor: Colors.deepPurple
      ),

      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "0";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;

      } else if (buttonText == "⇚") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      }

      else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('X', '*');
        expression = expression.replaceAll('%', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }
      }

      else {
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

  //Button
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
                color: Colors.yellowAccent, width: 0.3, style: BorderStyle.solid)),
        padding: EdgeInsets.all(8.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Calculator")),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.black87,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 50),
            child: Text(equation,
                style:
                    TextStyle(fontSize: equationFontSize, color: Colors.white)),
          ),
          Container(
            color: Colors.black87,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result,
                style:
                    TextStyle(fontSize: resultFontSize, color: Colors.white)),
          ),
          Expanded(
            child: Divider(),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton("AC", 1, Colors.black),
                          buildButton("⇚", 1, Colors.deepPurple),
                          buildButton("%", 1, Colors.deepPurple),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("7", 1, Colors.black87),
                          buildButton("8", 1, Colors.black87),
                          buildButton("9", 1, Colors.black87),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("4", 1, Colors.black87),
                          buildButton("5", 1, Colors.black87),
                          buildButton("6", 1, Colors.black87),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("1", 1, Colors.black87),
                          buildButton("2", 1, Colors.black87),
                          buildButton("3", 1, Colors.black87),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton(".", 1, Colors.black87),
                          buildButton("0", 1, Colors.black87),
                          buildButton("00", 1, Colors.black87),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(
                        children: [buildButton("X", 1, Colors.deepPurple)],
                      ),
                      TableRow(
                        children: [buildButton("-", 1, Colors.deepPurple)],
                      ),
                      TableRow(
                        children: [buildButton("+", 1, Colors.deepPurple)],
                      ),
                      TableRow(
                        children: [buildButton("=", 2, Colors.black)],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
