import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoControle = TextEditingController();
  TextEditingController alturaControle = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetarCampos() {
    pesoControle.text = "";
    alturaControle.text = "";
    setState(() {
      _infoText = "Informe seus dados";
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoControle.text);
      double altura = double.parse(alturaControle.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc > 18.5 && imc < 24.9) {
        _infoText = "Peso normal (${imc.toStringAsPrecision(3)})";
      } else if (imc > 25) {
        _infoText = "Sobre do peso (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetarCampos,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: pesoControle,
                validator: (valor) {
                  if(valor.isEmpty){
                    return "Insira sua altura";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: alturaControle,
                validator: (valor) {
                  if(valor.isEmpty){
                    return "Insira seu peso";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _calcular();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
