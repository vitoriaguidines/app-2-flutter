import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QualidadeArScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  QualidadeArScreen({required this.latitude, required this.longitude});

  @override
  _QualidadeArScreenState createState() => _QualidadeArScreenState();
}

class _QualidadeArScreenState extends State<QualidadeArScreen> {
  Map<String, dynamic> airQualityData = {};

  @override
  void initState() {
    super.initState();
    _getAirQualityData();
  }

  Future<void> _getAirQualityData() async {
    final apiKey = 'bbb1f1998dfc0df81791112857812b99';

    final apiUrl =
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=${widget.latitude}&lon=${widget.longitude}&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        airQualityData = json.decode(response.body);
      });
    } else {
      throw Exception('Erro ao obter dados da qualidade do ar');
    }
  }

  String _getAirQualityCategory(int index) {
    switch (index) {
      case 1:
        return 'Good';
      case 2:
        return 'Fair';
      case 3:
        return 'Moderate';
      case 4:
        return 'Poor';
      case 5:
        return 'Very Poor';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Qualidade do Ar', style: TextStyle(color: Colors.white)),
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                'Informações da Qualidade do Ar:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              if (airQualityData.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Índice Geral: ${airQualityData['list'][0]['main']['aqi']}',
                        style: TextStyle(color: Colors.white)),
                    Text(
                        'Categoria: ${_getAirQualityCategory(airQualityData['list'][0]['main']['aqi'])}',
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 20),
                    Text('Concentração de Componentes:',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 10),
                    for (var component
                        in airQualityData['list'][0]['components'].keys)
                      Text(
                          '$component: ${airQualityData['list'][0]['components'][component]} µg/m³',
                          style: TextStyle(color: Colors.white)),
                  ],
                )
              else
                Text('Nenhuma informação de qualidade do ar encontrada.',
                    style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
