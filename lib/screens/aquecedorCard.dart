import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AquecedorCard extends StatefulWidget {
  final String aquecedor;

  AquecedorCard({required this.aquecedor});

  @override
  _AquecedorCardState createState() => _AquecedorCardState();
}

class _AquecedorCardState extends State<AquecedorCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _animation;
  late Animation<Color?> _animationDisable;

  String _nome = '';
  String _capacidade = '';
  String _tipo = '';
  String _status = '';
  DateTime _dataHora = DateTime.now();
  String dataHora = "";

  @override
  void initState() {
    super.initState();

    lerStatusAtualAquecedor(widget.aquecedor).then((aquecedor) {
      setState(() {
        _nome = aquecedor['nome'];
        _capacidade = aquecedor['capacidade'];
        _tipo = aquecedor['tipo'];
        _status = aquecedor['status'];
        dataHora = DateFormat.MEd('pt_BR').add_Hm().format(
              DateTime.fromMillisecondsSinceEpoch(
                int.parse(aquecedor['dataHora']),
              ),
            );
        _dataHora = DateTime.fromMillisecondsSinceEpoch(
            int.parse(aquecedor['dataHora']));
        _animationController.forward();
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = _animationController.drive(ColorTween(
      begin: Colors.red,
      end: Colors.green,
    ));
    _animationDisable = _animationController.drive(ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ));
  }

  Future<Map<String, dynamic>> lerStatusAtualAquecedor(String aquecedor) async {
    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/lerStatusAquecedor.php',
    );

    var data = {'id': aquecedor};

    var response = await http.post(url, body: json.encode(data));

    var message = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("Dado recebido");
      return message[0];
    } else {
      throw Exception('Falha ao obter o status do aquecedor.');
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget? child) {
                    return Icon(
                      Icons.wb_incandescent,
                      size: 70,
                      color: _status == "Ativado"
                          ? _animation.value
                          : _animationDisable.value,
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
                    SizedBox(height: 8.0),
                    Text(
                      'Status: $_status',
                      style: TextStyle(fontSize: 16),
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
