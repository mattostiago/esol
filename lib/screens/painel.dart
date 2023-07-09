import 'package:esol/database/storage.dart';
import 'package:esol/screens/aquecedorCard.dart';
import 'package:esol/screens/geradorCard.dart';
import 'package:esol/screens/menuDrawer.dart';
import 'package:esol/screens/nivelRecenteReservatorio.dart';
import 'package:esol/screens/reservatorioCard.dart';
import 'package:esol/screens/temperaturaCard.dart';
import 'package:esol/screens/teste.dart';
import 'package:flutter/material.dart';

class Painel extends StatefulWidget {
  const Painel({super.key});

  @override
  State<Painel> createState() => _PainelState();
}

class _PainelState extends State<Painel> {
  Storage storage = Storage();
  NivelRecenteReservatorio nivel = NivelRecenteReservatorio();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(title: const Text("Painel de monitoramento")),
      body: Column(
        children: [
          ReservatorioCard(reservatorio: "1"),
          GeradorCard(gerador: '1'),
          AquecedorCard(aquecedor: "1"),
          TemperaturaCard(reservatorio: '1'),
        ],
      ),
    );
  }
}
