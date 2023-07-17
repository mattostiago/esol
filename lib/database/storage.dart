import 'dart:convert';
import 'package:esol/screens/reservoirLevelScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:esol/utils/propriedades.dart';
import 'package:dio/dio.dart';

class Storage {
  DateTime now = DateTime.now();

  Future<int> adicionarAquecedor(
      int id, String nome, String capacidade, String tipo) async {
    int sucesso = 0;

    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/adicionarAquecedor.php',
    );
    // Store all data with Param Name.
    var data = {
      'id': id,
      'nome': nome,
      'capacidade': capacidade,
      'tipo': tipo,
    };

    print(data);

    try {
      // Starting Web Call with data.
      var response = await http.post(
        url,
        body: json.encode(data),
        headers: {'Cache-Control': 'no-cache'},
      );
      print(response.request);

      // Getting Server response into variable.
      var message = jsonDecode(response.body);

      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        print(response.body);
        print(response.request);
        sucesso = 1;
        print("Aquecedor adicionado com sucesso");
      }
    } catch (e) {
      print(e.toString());
    }

    return sucesso;
  }

  Future<int> leituraAquecedor(
      int aquecedor, String status, String dataHora) async {
    int sucesso = 0;

    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/leituraAquecedor.php',
    );

    // Store all data with Param Name.
    var data = {"aquecedor": aquecedor, "status": status, "dataHora": dataHora};
    print(data);

    try {
      // Starting Web Call with data.
      var response = await http.post(
        url,
        body: json.encode(data),
        headers: {'Cache-Control': 'no-cache'},
      );
      print(response.request);

      // Getting Server response into variable.
      var message = jsonDecode(response.body);

      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        sucesso = 1;
        print("Leitura aquecedor adicionada com sucesso");
      }
    } catch (e) {
      print(e.toString());
    }

    return sucesso;
  }

  Future<int> leituraDadosGerador(
      int gerador, String geracao, String dataHora) async {
    int sucesso = 0;

    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/leituraGerador.php',
    );

    // Store all data with Param Name.
    var data = {"gerador": gerador, "geracao": geracao, "dataHora": dataHora};
    print(data);

    try {
      // Starting Web Call with data.
      var response = await http.post(
        url,
        body: json.encode(data),
        headers: {'Cache-Control': 'no-cache'},
      );
      print(response.request);

      // Getting Server response into variable.
      var message = jsonDecode(response.body);

      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        print(response.body);
        sucesso = 1;
        print("Leitura dados gerador adicionada com sucesso");
      }
    } catch (e) {
      print(e.toString());
    }

    return sucesso;
  }

  Future<int> leituraTemperaturaTanque(int reservatorio, int localMedicao,
      String dataHora, String temperatura) async {
    int sucesso = 0;

    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/leituraTemperaturaTanque.php',
    );

    // Store all data with Param Name.
    var data = {
      "reservatorio": reservatorio,
      "local_medicao": localMedicao,
      "dataHora": dataHora,
      "temperatura": temperatura
    };
    print(data);

    try {
      // Starting Web Call with data.
      var response = await http.post(
        url,
        body: json.encode(data),
        headers: {'Cache-Control': 'no-cache'},
      );

      // Getting Server response into variable.
      var message = jsonDecode(response.body);
      print(message);
      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        print(response.body);
        print(data);
        sucesso = 1;
        print("Leitura dados temperatura adicionada com sucesso");
      }
    } catch (e) {
      print(e.toString());
    }

    return sucesso;
  }

  Future<int> leituraNivelTanque(
      int reservatorio, String nivel, String dataHora) async {
    int sucesso = 0;

    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/leituraNivelReservatorio.php',
    );

    // Store all data with Param Name.
    var data = {
      "reservatorio": reservatorio,
      "nivel": nivel,
      "dataHora": dataHora
    };
    print(data);

    try {
      // Starting Web Call with data.
      var response = await http.post(
        url,
        body: json.encode(data),
        headers: {'Cache-Control': 'no-cache'},
      );

      // Getting Server response into variable.
      var message = jsonDecode(response.body);
      print(message);
      // If Web call Success than Hide the CircularProgressIndicator.
      if (response.statusCode == 200) {
        print(response.body);
        print(data);
        sucesso = 1;
        print("Leitura dados nivel adicionada com sucesso");
      }
    } catch (e) {
      print(e.toString());
    }

    return sucesso;
  }

  Future<String> lerStatusAtualAquecedor(String aquecedor) async {
    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/lerStatusAquecedor.php',
      // fragment: 'numbers');
    );

    // Store all data with Param Name.
    var data = {'id': aquecedor};
    print(data);

    // Starting Web Call with data.
    var response = await http.post(
      url,
      body: json.encode(data),
      headers: {'Cache-Control': 'no-cache'},
    );
    print(response.request);
    print(response.body);
    print(response.headers);

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      print("Dado recebido");
    }

    return response.body;
  }

  lerStatusAtualGerador(String gerador) async {
    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/lerStatusGerador.php',
      // fragment: 'numbers');
    );

    // Store all data with Param Name.
    var data = {'id': gerador};
    print(data);

    // Starting Web Call with data.
    var response = await http.post(
      url,
      body: json.encode(data),
      headers: {'Cache-Control': 'no-cache'},
    );
    print(response.request);
    print(response.body);
    print(response.headers);

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      print("Dado recebido");
    }

    return response.body;
  }

  Future<String> pegarNivelRecenteReservatorio() async {
    //teste a ser alterado
    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/pegarNivelRecenteReservatorio.php',
      // fragment: 'numbers');
    );
    final response = await http.get(
      url,
      headers: {'Cache-Control': 'no-cache'},
    );
    return response.body;
  }

  Future<List<DataPoint>> pegarListaNivelRecente() async {
    List<DataPoint> dataPoints = [];
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

      dataPoints =
          newDataPoints.reversed.toList(); // Inverter a ordem dos dados
    } else {
      throw Exception('Falha ao carregar os dados');
    }
    return dataPoints;
  }

  Future lerStatusAtualNivelTanque(String reservatorio) async {
    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/lerStatusAtualNivelReservatorio.php',
      // fragment: 'numbers');
    );

    // Store all data with Param Name.
    var data = {'id': reservatorio};
    print(data);

    // Starting Web Call with data.
    var response = await http.post(
      url,
      body: json.encode(data),
      headers: {'Cache-Control': 'no-cache'},
    );
    print(response.request);
    print(response.body);
    print(response.headers);

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      print("Dado recebido");
    }

    return response.body;
  }

  Future lerStatusAtualTemperatura(String reservatorio) async {
    Uri url = Uri(
      scheme: 'https',
      host: 'esol.tinex.app',
      path: '/apiEsol/lerStatusAtualTemperatura.php',
      // fragment: 'numbers');
    );

    // Store all data with Param Name.
    var data = {'id': reservatorio};
    print(data);

    // Starting Web Call with data.
    var response = await http.post(
      url,
      body: json.encode(data),
      headers: {'Cache-Control': 'no-cache'},
    );
    print(response.request);
    print(response.body);
    print(response.headers);

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      print("Dado recebido");
    }

    return response.body;
  }
}
