import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        //accentColor: Colors.orangeAccent,
      //  brightness: Brightness.dark,
      ),
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _display = "";    // This holds the ongoing operation (e.g., "81 + 87")
  String _output = "0";    // This holds the result or the current input
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _display = "";
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "X") {
      if (operand.isEmpty) {
        num1 = double.parse(_output);
        operand = buttonText;
        _display = _output + " " + operand;
        _output = "0";
      }
    } else if (buttonText == "=") {
      if (operand.isNotEmpty) {
        num2 = double.parse(_output);

        if (operand == "+") {
          _output = (num1 + num2).toString();
        }
        if (operand == "-") {
          _output = (num1 - num2).toString();
        }
        if (operand == "X") {
          _output = (num1 * num2).toString();
        }
        if (operand == "/") {
          _output = (num1 / num2).toString();
        }

        _display = "";
        operand = "";
        num1 = 0;
        num2 = 0;
      }
    } else {
      _output = _output == "0" ? buttonText : _output + buttonText;
      _display = operand.isEmpty ? _output : _display + " " + buttonText;
    }

    setState(() {});
  }

  Widget buildButton(String buttonText, {Color color = Colors.grey}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(24.0),
            backgroundColor: color,
             foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.white, //color change black to white
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _display,  // Displays the ongoing operation
                 style: TextStyle(fontSize: 35, color: Colors.grey[700]),
                ),
                Text(
                  _output,  // Displays the result or current input
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: <Widget>[
                  buildButton("7", color: Colors.blue),
                  buildButton("8", color: Colors.blue),
                  buildButton("9", color: Colors.blue),
                  buildButton("/", color: Colors.deepOrangeAccent),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4", color: Colors.blue),
                  buildButton("5", color: Colors.blue),
                  buildButton("6", color: Colors.blue),
                  buildButton("X", color: Colors.deepOrangeAccent),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1", color: Colors.blue),
                  buildButton("2", color: Colors.blue),
                  buildButton("3", color: Colors.blue),
                  buildButton("-", color: Colors.deepOrangeAccent),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton(".", color: Colors.blue),
                  buildButton("0", color: Colors.blue),
                  buildButton("00", color: Colors.blue),
                  buildButton("+", color: Colors.deepOrangeAccent),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("CLEAR",  color: Colors.red),
                  buildButton("=", 
                  color: Colors.green),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
