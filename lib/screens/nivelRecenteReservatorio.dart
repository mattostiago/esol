import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:esol/database/storage.dart';
import 'package:esol/models/nivel.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class NivelRecenteReservatorio {
  Storage storage = Storage();
  List<Nivel> arrayNivel = [];

  Center retornaCardNivel() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
            future: storage.lerStatusAtualNivelTanque("2"),
            builder: (context, snapshot) {
              print("entrei 1");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData && snapshot.data != null) {
                try {
                  arrayNivel = NivelFromJson(snapshot.data.toString());
                  print("entrei 3");
                  var dataHora = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(arrayNivel[0].dataHora),
                  ).toString();
                  return Padding(
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
                                      title: const GaugeTitle(
                                        text: 'Nível do Tanque 1',
                                        textStyle: TextStyle(
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
                                                arrayNivel[0].nivel,
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
                                                "${arrayNivel[0].nivel} %",
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
                                      DateFormat.MEd('pt_BR')
                                          .add_Hm()
                                          .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(
                                                arrayNivel[0].dataHora,
                                              ),
                                            ),
                                          )
                                          .toString(),
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
                  );
                } catch (error) {
                  return Text('Error: $error');
                }
              } else {
                return const Text('No data available');
              }
            },
          ),
        ],
      ),
    );
  }
}
