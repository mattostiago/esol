import 'package:esol/database/storage.dart';
import 'package:flutter/material.dart';

class AdicionarTemperaturaTanque extends StatefulWidget {
  const AdicionarTemperaturaTanque({super.key});

  @override
  State<AdicionarTemperaturaTanque> createState() =>
      _AdicionarTemperaturaTanqueState();
}

class _AdicionarTemperaturaTanqueState
    extends State<AdicionarTemperaturaTanque> {
  DateTime now = DateTime.now();
  Storage storage = Storage();
  bool visible = false;
  bool isDataStorageInProgress = false;
  final statusValueNotifier = ValueNotifier('');
  List<String> arrayLocalMedicao = ["Entrada", "Tanque", "Saída"];
  String localMedicao = "";
  final reservatorioController = TextEditingController();
  final temperaturaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar temperatura"),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Container(
          width: 400,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: reservatorioController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "ID",
                    hintText: "Informe o ID do reservatorio (1,2,3,4...)",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: ValueListenableBuilder(
                  valueListenable: statusValueNotifier,
                  builder: (BuildContext context, String value, _) {
                    return DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Local",
                        hintText:
                            "Informe o local onde é aferida a temperatura",
                      ),
                      isExpanded: true,
                      items: arrayLocalMedicao
                          .map(
                            (op) => DropdownMenuItem(
                              value: op,
                              child: Text(op),
                            ),
                          )
                          .toList(),
                      value: (value.isEmpty) ? null : value,
                      onChanged: (escolha) {
                        if (escolha == "Entrada") {
                          localMedicao = "1";
                        } else if (escolha == "Tanque") {
                          localMedicao = "2";
                        } else if (escolha == "Saída") {
                          localMedicao = "3";
                        } else {
                          localMedicao = "0";
                        }
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: temperaturaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Temperatura",
                    hintText: "Informe a temperatura (35,5; 20,0...)",
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: isDataStorageInProgress
                      ? null
                      : () async {
                          setState(() {
                            isDataStorageInProgress = true;
                          });
                          int sucesso = await storage.leituraTemperaturaTanque(
                              int.parse(reservatorioController.text),
                              int.parse(localMedicao),
                              now.millisecondsSinceEpoch.toString(),
                              temperaturaController.text);
                          sucesso == 1
                              ? Navigator.of(context).pop()
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Erro ao salvar"),
                                      content: const Text(
                                          'Houve um erro ao salvar.'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                          ;

                          setState(() {
                            isDataStorageInProgress = false;
                          });

                          isDataStorageInProgress = false;
                        },
                  //onPressed: webCall,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: isDataStorageInProgress
                        ? const SizedBox(
                            height: 28,
                            width: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Incluir',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                  ),
                ),
              ),
              Visibility(
                  visible: visible,
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: const CircularProgressIndicator())),
            ],
          ),
        ),
      )),
    );
  }
}
