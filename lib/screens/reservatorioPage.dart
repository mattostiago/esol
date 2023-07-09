import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:intl/intl.dart';

class ReservatorioPage extends StatefulWidget {
  final String reservatorio;

  ReservatorioPage({required this.reservatorio});

  @override
  _ReservatorioPageState createState() => _ReservatorioPageState();
}

class _ReservatorioPageState extends State<ReservatorioPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  double _nivel = 0.0;
  String _nome = '';
  String dataHora = '';
  DateTime _dataHora = DateTime.now();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    lerStatusAtualNivelTanque(widget.reservatorio).then((reservatorio) {
      setState(() {
        _nivel = double.parse(reservatorio['nivel']);
        _nome = reservatorio['nome'];
        dataHora = reservatorio['dataHora'];
        dataHora = DateFormat.MEd('pt_BR').add_Hm().format(
              DateTime.fromMillisecondsSinceEpoch(
                int.parse(reservatorio['dataHora']),
              ),
            );
        _dataHora = DateTime.fromMillisecondsSinceEpoch(
            int.parse(reservatorio['dataHora']));
        _animationController.forward();
      });
    });
  }

  Future<Map<String, dynamic>> lerStatusAtualNivelTanque(
      String reservatorio) async {
    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/lerStatusAtualNivelReservatorio.php',
    );

    var data = {'id': reservatorio};

    var response = await http.post(url, body: json.encode(data));

    var message = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print("Dado recebido");
      return message[0];
    } else {
      throw Exception('Falha ao obter o nível do reservatório.');
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
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*
                Text(
                  _nome,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: _nivel * 2,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                */
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 20,
                          //color: Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            //  width: 200,
                            // height: 150,
                            // color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: SfRadialGauge(
                                    title: GaugeTitle(
                                      text: _nome,
                                      textStyle: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    enableLoadingAnimation: true,
                                    animationDuration: 4500,
                                    axes: <RadialAxis>[
                                      RadialAxis(
                                        minimum: 0,
                                        maximum: 100,
                                        pointers: <GaugePointer>[
                                          NeedlePointer(
                                            value: double.parse(
                                              _nivel.toString(),
                                            ),
                                            enableAnimation: true,
                                          ),
                                        ],
                                        ranges: <GaugeRange>[
                                          GaugeRange(
                                            startValue: 100,
                                            endValue: 50,
                                            color: Colors.green,
                                          ),
                                          GaugeRange(
                                            startValue: 30,
                                            endValue: 60,
                                            color: Colors.orange,
                                          ),
                                          GaugeRange(
                                            startValue: 0,
                                            endValue: 30,
                                            color: Colors.red,
                                          ),
                                        ],
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                            widget: Text(
                                              "$_nivel %",
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            positionFactor: 0.5,
                                            angle: 90,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                DelayedDisplay(
                                  delay: const Duration(seconds: 4),
                                  child: Text(
                                    dataHora,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      //color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
