import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora de Imc",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();

  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String resultado = "Informe seus dados";

  void resetFields() {
    weightController.text = "";
    heightController.text = "";

    setState(() {
      resultado = "Informe seus dados";
      _formKey.currentState.reset();
    });
  }

  void calcular(double h, double w) {
    setState(() {
      double imc = (10000 * w) / (h * h);
      if (imc < 18.5) {
        resultado = "Abaixo do Peso (${imc.toStringAsFixed(1)})";
      } else if (imc < 25) {
        resultado = "Peso Normal (${imc.toStringAsFixed(1)})";
      } else if (imc < 30) {
        resultado = "Sobrepeso (${imc.toStringAsFixed(1)})";
      } else if (imc < 35) {
        resultado = "Obesidade Grau I (${imc.toStringAsFixed(1)})";
      } else if (imc < 40) {
        resultado = "Obesidade Grau II (${imc.toStringAsFixed(1)})";
      } else {
        resultado = "Obesidade Grau III ou Morbida (${imc.toStringAsFixed(1)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                resetFields();
              })
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.purple,
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      // ignore: missing_return
                      validator: (value) {
                        // ignore: unnecessary_statements
                        if(value.isEmpty){
                          return "Informe o Peso";
                        };
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso (kg)",
                          labelStyle: TextStyle(color: Colors.purple)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.purple),
                      controller: weightController,
                    )),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      // ignore: missing_return
                      validator: (value) {
                        // ignore: unnecessary_statements
                        if(value.isEmpty){
                          return "Informe a Altura";
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura (cm)",
                          labelStyle: TextStyle(color: Colors.purple)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.purple),
                      controller: heightController,
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
                    child: Container(
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              calcular(double.parse(heightController.text),
                                  double.parse(weightController.text));
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          color: Colors.purple,
                        ))),
                Text(
                  "$resultado",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.purple, fontSize: 25),
                )
              ],
            ),
          )
      ),
    );
  }
}
