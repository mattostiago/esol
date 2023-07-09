import 'package:esol/database/storage.dart';
import 'package:flutter/material.dart';

class AdicionarAquecedor extends StatefulWidget {
  const AdicionarAquecedor({super.key});

  @override
  State<AdicionarAquecedor> createState() => _AdicionarAquecedorState();
}

class _AdicionarAquecedorState extends State<AdicionarAquecedor> {
  DateTime now = DateTime.now();
  Storage storage = Storage();
  bool visible = false;
  bool isDataStorageInProgress = false;

  final nomeController = TextEditingController();
  final capacidadeController = TextEditingController();
  final tipoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Aquecedor"),
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
                    labelText: "Nome",
                    hintText: "Informe o nome do aquecedor",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: capacidadeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Capacidade",
                    hintText: "Capacidade do aquecedor",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: tipoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Tipo",
                    hintText: "Tipo do aquecedor",
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
                          int sucesso = await storage.adicionarAquecedor(
                              now.microsecondsSinceEpoch,
                              nomeController.text,
                              capacidadeController.text,
                              tipoController.text);
                          sucesso == 1
                              ? Navigator.of(context).pop()
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Erro ao salvar"),
                                      content: const Text(
                                          'Houve um erro ao salvar o aquecedor.'),
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
