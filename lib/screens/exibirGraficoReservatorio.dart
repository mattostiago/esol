import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class DataPoint {
  final DateTime dataHora;
  final double nivel;

  DataPoint(this.dataHora, this.nivel);
}

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<DataPoint> data = [];
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchChartData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchChartData() async {
    final url =
        Uri.parse('https://tinex.app/esol/apiEsol/nivelNoUltimoDia.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        data = jsonData.map<DataPoint>((item) {
          DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(int.parse(item['dataHora']));
          return DataPoint(dateTime, double.parse(item['nivel']));
        }).toList();
        dataList = List<Map<String, dynamic>>.from(jsonData);
        //  dataList.sort((a, b) => int.parse(b['dataHora']).compareTo(int.parse(a['dataHora'])));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gráfico de Evolução do Nível'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: _buildChart(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Nível: ${dataList[index]['nivel']}'),
                    subtitle: Text(
                        'Data/Hora: ${DateFormat.MEd('pt_BR').add_Hm().format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataList[index]['dataHora'])))}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    if (data.isEmpty) {
      return CircularProgressIndicator();
    } else {
      return SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        series: <ChartSeries>[
          LineSeries<DataPoint, DateTime>(
            dataSource: data,
            xValueMapper: (DataPoint data, _) => data.dataHora,
            yValueMapper: (DataPoint data, _) => data.nivel,
          ),
        ],
      );
    }
  }
}
