import 'package:esol/screens/exibirGraficoReservatorio.dart';
import 'package:esol/screens/reservoirLevelScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:intl/intl.dart';

class ReservatorioCard extends StatefulWidget {
  final String reservatorio;

  ReservatorioCard({required this.reservatorio});

  @override
  _ReservatorioCardState createState() => _ReservatorioCardState();
}

class _ReservatorioCardState extends State<ReservatorioCard>
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
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ReservoirLevelScreen(),
          ),
        );
      },
      child: Card(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: Center(
                          child: SizedBox(
                            width: 90,
                            height: 90,
                            child: SfRadialGauge(
                              enableLoadingAnimation: true,
                              axes: <RadialAxis>[
                                RadialAxis(
                                    showLabels: false,
                                    showTicks: false,
                                    radiusFactor: 0.8,
                                    maximum: 100,
                                    axisLineStyle: const AxisLineStyle(
                                        cornerStyle: CornerStyle.startCurve,
                                        thickness: 1),
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                          angle: 90,
                                          widget: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [],
                                              ),
                                            ],
                                          )),
                                      const GaugeAnnotation(
                                        angle: 124,
                                        positionFactor: 1.1,
                                        widget: Text('0',
                                            style: TextStyle(fontSize: 8)),
                                      ),
                                      const GaugeAnnotation(
                                        angle: 60,
                                        positionFactor: 1.1,
                                        widget: Text("100",
                                            style: TextStyle(fontSize: 8)),
                                      ),
                                    ],
                                    pointers: <GaugePointer>[
                                      NeedlePointer(
                                        enableAnimation: true,
                                        gradient: const LinearGradient(
                                            colors: <Color>[
                                              Color.fromARGB(0, 231, 170, 0),
                                              Color.fromARGB(255, 16, 9, 17)
                                            ],
                                            stops: <double>[
                                              0.25,
                                              0.75
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter),
                                        animationType:
                                            AnimationType.easeOutBack,
                                        value: _nivel,
                                        animationDuration: 1300,
                                        needleStartWidth: 1,
                                        needleEndWidth: 8,
                                        needleLength: 0.9,
                                        knobStyle: const KnobStyle(
                                          knobRadius: 0,
                                        ),
                                      ),
                                      RangePointer(
                                        value: _nivel,
                                        width: 5,
                                        pointerOffset: -1,
                                        cornerStyle: CornerStyle.bothCurve,
                                        color: Color.fromARGB(255, 160, 4, 19),
                                        gradient: const SweepGradient(
                                            colors: <Color>[
                                              Color.fromARGB(255, 219, 147, 38),
                                              Color.fromARGB(255, 15, 170, 67)
                                            ],
                                            stops: <double>[
                                              0.25,
                                              0.75
                                            ]),
                                      ),
                                      MarkerPointer(
                                        value: _nivel,
                                        color: Colors.white,
                                        markerType: MarkerType.circle,
                                      ),
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _nome,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Nível: $_nivel%',
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
            );
          },
        ),
      ),
    );
  }
}
