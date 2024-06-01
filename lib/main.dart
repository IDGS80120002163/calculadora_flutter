import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  late String _texto;
  late double _num1;
  late double _num2;
  late String _operacion;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _texto = '';
    _num1 = 0;
    _num2 = 0;
    _operacion = '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateDisplay(String texto) {
    setState(() {
      _texto = texto;
    });
  }

  void _borrarPantalla() {
    setState(() {
      _texto = '';
    });
  }

  void _mandarNumero(String numero) {
    setState(() {
      _texto += numero;
    });
  }

  void _mandarOperacion(String operacion) {
    setState(() {
      _num1 = double.parse(_texto);
      _operacion = operacion;
      _texto = '';
    });
  }

  void _calcular() {
    setState(() {
      _num2 = double.parse(_texto);
      double resultado = 0;
      switch (_operacion) {
        case '+':
          resultado = _num1 + _num2;
          break;
        case '-':
          resultado = _num1 - _num2;
          break;
        case 'x':
          resultado = _num1 * _num2;
          break;
        case '/':
          resultado = _num1 / _num2;
          break;
      }
      _texto = resultado.toString();
    });
  }

  Widget _buildButton(String texto, {Color? color}) {
    return Container(
      width: 80,
      height: 80,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color ?? Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {
          if (texto == 'C') {
            _borrarPantalla();
          } else if (texto == '=') {
            _calcular();
          } else if (texto == '+' || texto == '-' || texto == 'x' || texto == '/') {
            _mandarOperacion(texto);
          } else {
            _mandarNumero(texto);
          }
        },
        child: Text(
          texto,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _texto,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('7'),
                      _buildButton('8'),
                      _buildButton('9'),
                      _buildButton('/', color: Colors.orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('4'),
                      _buildButton('5'),
                      _buildButton('6'),
                      _buildButton('x', color: Colors.orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('1'),
                      _buildButton('2'),
                      _buildButton('3'),
                      _buildButton('-', color: Colors.orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('C', color: Colors.red),
                      _buildButton('0'),
                      _buildButton('.', color: Colors.grey[400]),
                      _buildButton('+', color: Colors.orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton('='),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
