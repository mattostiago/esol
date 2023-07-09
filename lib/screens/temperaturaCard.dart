import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class TemperaturaCard extends StatefulWidget {
  final String reservatorio;

  TemperaturaCard({required this.reservatorio});

  @override
  _TemperaturaCardState createState() => _TemperaturaCardState();
}

class _TemperaturaCardState extends State<TemperaturaCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _animation;
  late Animation<Color?> _animationHot;

  String _nome = '';
  String _capacidade = '';
  String _temperatura = '0';
  String dataHora = "";
  DateTime _dataHora = DateTime.now();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = _animationController.drive(ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ));
    _animationHot = _animationController.drive(ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ));

    lerStatusAtualTemperatura(widget.reservatorio).then((temperatura) {
      setState(() {
        _nome = temperatura['nome'];
        _capacidade = temperatura['capacidade'];
        _temperatura = temperatura['temperatura'];
        dataHora = DateFormat.MEd('pt_BR').add_Hm().format(
              DateTime.fromMillisecondsSinceEpoch(
                int.parse(temperatura['dataHora']),
              ),
            );
        _dataHora = DateTime.fromMillisecondsSinceEpoch(
            int.parse(temperatura['dataHora']));
        _animationController.forward();
      });
    });
  }

  Future<Map<String, dynamic>> lerStatusAtualTemperatura(
      String reservatorio) async {
    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/lerStatusAtualTemperatura.php',
    );

    var data = {'id': reservatorio};

    var response = await http.post(url, body: json.encode(data));

    var message = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("Dado recebido");
      return message[0];
    } else {
      throw Exception('Falha ao obter a temperatura.');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget? child) {
                    return Icon(
                      Icons.thermostat,
                      size: 70,
                      color: double.parse(_temperatura) > 25
                          ? _animationHot.value
                          : _animation.value,
                    );
                  },
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _nome,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    /*
                    SizedBox(height: 8.0),
                    Text(
                      'Capacidade: $_capacidade' + 'L.',
                      style: const TextStyle(fontSize: 16),
                    ),*/
                    SizedBox(height: 8.0),
                    Text(
                      'Temperatura: $_temperatura°C.',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Última verificação: $dataHora',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
