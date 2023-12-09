import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'previsao.dart';
import 'qualidade_ar.dart';

class TempoScreen extends StatefulWidget {
  final String city;

  TempoScreen({required this.city});

  @override
  _TempoScreenState createState() => _TempoScreenState();
}

class _TempoScreenState extends State<TempoScreen> {
  Map<String, dynamic> weatherData = {};

  @override
  void initState() {
    super.initState();
    _getWeatherData();
  }

  Future<void> _getWeatherData() async {
    final cityName = widget.city;
    final apiKey = 'bbb1f1998dfc0df81791112857812b99';

    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      throw Exception('Erro ao obter dados do tempo');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Informações do Tempo', style: TextStyle(color: Colors.white)),
        backgroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [theme.primaryColor, Colors.white],
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resultado:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              if (weatherData.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cidade: ${weatherData['name']}',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    Text('Temperatura: ${weatherData['main']['temp']} °C',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrevisaoScreen(
                              latitude: weatherData['coord']['lat'],
                              longitude: weatherData['coord']['lon'],
                            ),
                          ),
                        );
                      },
                      child: Text('Ver Previsão de 5 Dias'),
                      style: ElevatedButton.styleFrom(
                        primary: theme.accentColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QualidadeArScreen(
                              latitude: weatherData['coord']['lat'],
                              longitude: weatherData['coord']['lon'],
                            ),
                          ),
                        );
                      },
                      child: Text('Ver Qualidade do Ar'),
                      style: ElevatedButton.styleFrom(
                        primary: theme.accentColor,
                      ),
                    ),
                  ],
                )
              else
                Text('Nenhuma informação encontrada.',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
