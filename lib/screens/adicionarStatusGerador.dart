import 'package:esol/database/storage.dart';
import 'package:flutter/material.dart';

class AdicionarStatusGerador extends StatefulWidget {
  const AdicionarStatusGerador({super.key});

  @override
  State<AdicionarStatusGerador> createState() => _AdicionarStatusGeradorState();
}

class _AdicionarStatusGeradorState extends State<AdicionarStatusGerador> {
  DateTime now = DateTime.now();
  Storage storage = Storage();
  bool visible = false;
  bool isDataStorageInProgress = false;
  final statusValueNotifier = ValueNotifier('');
  List<String> arrayStatus = ["Ativado", "Desativado"];
  String status = "";
  final nomeController = TextEditingController();
  final capacidadeController = TextEditingController();
  final tipoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar status gerador"),
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
                  controller: nomeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "ID",
                    hintText: "Informe o ID do gerador (1,2,3,4...)",
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
                        labelText: "Status",
                        hintText: "Selecione o status do gerador",
                      ),
                      isExpanded: true,
                      items: arrayStatus
                          .map(
                            (op) => DropdownMenuItem(
                              value: op,
                              child: Text(op),
                            ),
                          )
                          .toList(),
                      value: (value.isEmpty) ? null : value,
                      onChanged: (escolha) {
                        escolha;
                        status = escolha as String;
                      },
                    );
                  },
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
                          int sucesso = await storage.leituraDadosGerador(
                              int.parse(nomeController.text),
                              status,
                              now.millisecondsSinceEpoch.toString());
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
