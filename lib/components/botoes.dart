import 'package:flutter/material.dart';

class Botoes {
  chamaModal(BuildContext context, var widget) {
    showModalBottomSheet(
      //enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.maximize,
              size: 40,
              color: Colors.black54,
            ),
            widget,
          ],
        ),
      ),
    );
  }
}
