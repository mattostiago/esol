import 'dart:convert';
import 'package:esol/database/storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class ReservoirLevelScreen extends StatefulWidget {
  @override
  _ReservoirLevelScreenState createState() => _ReservoirLevelScreenState();
}

class _ReservoirLevelScreenState extends State<ReservoirLevelScreen> {
  List<DataPoint> _dataPoints = [];

  Future<void> fetchData() async {
    const url = 'https://tinex.app/esol/apiEsol/nivelNoUltimoDia.php';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Cache-Control': 'no-cache'}, // Desabilitar o cache
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<DataPoint> newDataPoints = data
          .map((item) =>
              DataPoint(int.parse(item['nivel']), int.parse(item['dataHora'])))
          .toList();

      setState(() {
        _dataPoints =
            newDataPoints.reversed.toList(); // Inverter a ordem dos dados
      });
    } else {
      throw Exception('Falha ao carregar os dados');
    }
  }

  Future<void> refreshData() async {
    await fetchData();
    _showSnackBar();
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Dados mais recentes recebidos.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico do Nível do Reservatório'),
        actions: [
          IconButton(
            onPressed: refreshData,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: _dataPoints.isEmpty
                  ? const Center(
                      child: Text('Nenhum dado disponível'),
                    )
                  : Column(
                      children: [
                        Container(
                          height: 300,
                          padding: const EdgeInsets.all(20),
                          child: LineChart(
                            LineChartData(
                              minX: _dataPoints.first.x.toDouble(),
                              maxX: _dataPoints.last.x.toDouble(),
                              minY: 0,
                              maxY: 100,
                              titlesData: FlTitlesData(
                                leftTitles: SideTitles(showTitles: false),
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  getTitles: (value) {
                                    final date =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            value.toInt());
                                    final formattedTime =
                                        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
                                    return formattedTime;
                                  },
                                ),
                                topTitles: SideTitles(showTitles: false),
                              ),
                              borderData: FlBorderData(show: true),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: _dataPoints
                                      .map((dataPoint) => FlSpot(
                                          dataPoint.x.toDouble(),
                                          dataPoint.y.toDouble()))
                                      .toList(),
                                  isCurved: true,
                                  colors: [Colors.blue],
                                  dotData: FlDotData(show: false),
                                  belowBarData: BarAreaData(show: false),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            primary: true,
                            reverse: true, // Inverter a ordem do ListView
                            itemCount: _dataPoints.length,
                            itemBuilder: (context, index) {
                              final dataPoint = _dataPoints[index];
                              final date = DateTime.fromMillisecondsSinceEpoch(
                                  dataPoint.x);
                              final formattedDate =
                                  '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
                              return ListTile(
                                title: Text('Nível: ${dataPoint.y}%'),
                                subtitle: Text('Data e Hora: $formattedDate'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataPoint {
  final int x;
  final int y;

  DataPoint(this.y, this.x);
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Reservoir Level App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            runApp(MaterialApp(
              home: ReservoirLevelScreen(),
            ));
          },
          child: Text('Mostrar Gráfico'),
        ),
      ),
    ),
  ));
}
