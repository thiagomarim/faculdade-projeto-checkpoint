import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

// A classe home vai gerenciar o estado da nossa aplicação:
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// Esta classe representa a nossa view e gerencia o estado da aplicação
class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _resultado = "Informe seus dados";

  void _reset() {
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _resultado = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularIMC() {
    setState(() {
      double peso = double.parse(pesoController.text.replaceAll(',', '.'));
      double altura =
          double.parse(alturaController.text.replaceAll(',', '.')) / 100;

      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _resultado = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _resultado = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _resultado = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _resultado = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _resultado = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else {
        _resultado = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                _reset();
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 150.0,
                color: Colors.lightBlue[900],
              ),
              TextFormField(
                controller: pesoController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe seu peso";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.lightBlue[900])),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
              ),
              TextFormField(
                controller: alturaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe sua altura";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.lightBlue[900])),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Container(
                      height: 50.0,
                      child: ElevatedButton(
                        child: Text("Calcular",
                            style:
                                TextStyle(color: Colors.white, fontSize: 26.0)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue[900]),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calcularIMC();
                          }
                        },
                      ))),
              Text(_resultado,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.lightBlue[900], fontSize: 26.0))
            ],
          ),
        ),
      ),
    );
  }
}
