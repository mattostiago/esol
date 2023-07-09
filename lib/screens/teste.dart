import 'package:esol/screens/aquecedorCard.dart';
import 'package:esol/screens/geradorCard.dart';
import 'package:esol/screens/nivelRecenteReservatorio.dart';
import 'package:esol/screens/reservatorioCard.dart';
import 'package:esol/screens/temperaturaCard.dart';
import 'package:flutter/material.dart';

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  NivelRecenteReservatorio nivel = NivelRecenteReservatorio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Teste")),
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
