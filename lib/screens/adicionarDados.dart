import 'package:esol/components/botoes.dart';
import 'package:esol/database/storage.dart';
import 'package:esol/screens/adicionarAquecedor.dart';
import 'package:esol/screens/adicionarNivelTanque.dart';
import 'package:esol/screens/adicionarStatusAquecedor.dart';
import 'package:esol/screens/adicionarStatusGerador.dart';
import 'package:esol/screens/adicionarTemperaturaTanque.dart';
import 'package:flutter/material.dart';

class AdicionarDados extends StatefulWidget {
  const AdicionarDados({super.key});

  @override
  State<AdicionarDados> createState() => _AdicionarDadosState();
}

class _AdicionarDadosState extends State<AdicionarDados> {
  DateTime now = DateTime.now();
  Storage storage = Storage();
  bool visible = false;
  Botoes botao = Botoes();
  bool isDataStorageInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Dados"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: isDataStorageInProgress
                        ? null
                        : () async {
                            setState(() {
                              isDataStorageInProgress = true;
                            });

                            showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    AdicionarStatusAquecedor()).then((value) {
                              setState(() {
                                print("Tela atualizada");
                              });
                            });
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
                              'Add status aquecedor',
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
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: isDataStorageInProgress
                        ? null
                        : () async {
                            setState(() {
                              isDataStorageInProgress = true;
                            });
                            showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    AdicionarStatusGerador()).then((value) {
                              setState(() {
                                print("Tela atualizada");
                              });
                            });
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
                              'Add status gerador',
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
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: isDataStorageInProgress
                        ? null
                        : () async {
                            setState(() {
                              isDataStorageInProgress = true;
                            });
                            showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    AdicionarTemperaturaTanque()).then((value) {
                              setState(() {
                                print("Tela atualizada");
                              });
                            });
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
                              'Add temperatura',
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
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: isDataStorageInProgress
                        ? null
                        : () async {
                            setState(() {
                              isDataStorageInProgress = true;
                            });
                            showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    AdicionarNivelTanque()).then((value) {
                              setState(() {
                                print("Tela atualizada");
                              });
                            });
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
                              'Add nivel tanque',
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
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: isDataStorageInProgress
                        ? null
                        : () async {
                            setState(() {
                              isDataStorageInProgress = true;
                            });
                            showModalBottomSheet(
                                    context: context,
                                    builder: (context) => AdicionarAquecedor())
                                .then((value) {
                              setState(() {
                                print("Tela atualizada");
                              });
                            });
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
                              'Adicionar Aquecedor',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
