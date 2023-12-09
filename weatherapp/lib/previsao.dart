import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'qualidade_ar.dart';

class PrevisaoScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  PrevisaoScreen({required this.latitude, required this.longitude});

  @override
  _PrevisaoScreenState createState() => _PrevisaoScreenState();
}

class _PrevisaoScreenState extends State<PrevisaoScreen> {
  List<dynamic> previsaoData = [];

  @override
  void initState() {
    super.initState();
    _getPrevisaoData();
  }

  Future<void> _getPrevisaoData() async {
    final apiKey = 'bbb1f1998dfc0df81791112857812b99';

    final apiUrl =
        'https://api.openweathermap.org/data/2.5/forecast?lat=${widget.latitude}&lon=${widget.longitude}&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        previsaoData = json.decode(response.body)['list'];
      });
    } else {
      throw Exception('Erro ao obter dados da previsão');
    }
  }

  void _verQualidadeAr() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QualidadeArScreen(
          latitude: widget.latitude,
          longitude: widget.longitude,
        ),
      ),
    );
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Previsão de 5 Dias', style: TextStyle(color: Colors.white)),
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [theme.primaryColor, Colors.white],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Previsão para 5 Dias:',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 10),
                if (previsaoData.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: previsaoData.map<Widget>((previsao) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Data e Hora: ${previsao['dt_txt']}',
                              style: TextStyle(color: Colors.black)),
                          Text(
                              'Temperatura: ${kelvinToCelsius(previsao['main']['temp']).toStringAsFixed(2)} °C',
                              style: TextStyle(color: Colors.black)),
                          Text(
                              'Situação: ${previsao['weather'][0]['description']}',
                              style: TextStyle(color: Colors.black)),
                          Text('Umidade: ${previsao['main']['humidity']}%',
                              style: TextStyle(color: Colors.black)),
                          SizedBox(height: 20),
                        ],
                      );
                    }).toList(),
                  )
                else
                  Text('Nenhuma informação de previsão encontrada.',
                      style: TextStyle(color: Colors.black)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _verQualidadeAr,
                  child: Text('Ver Qualidade do Ar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
