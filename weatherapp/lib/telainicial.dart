import 'package:flutter/material.dart';
import 'previsao.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Digite o Nome da Cidade',
            style: TextStyle(color: Colors.white)),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nome da Cidade',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navegar para a tela de previsão passando o nome da cidade
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrevisaoScreen(
                          latitude: 0.0,
                          longitude:
                              0.0), // Substitua as coordenadas conforme necessário
                    ),
                  );
                },
                child: Text('Ver Previsão do Tempo'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
