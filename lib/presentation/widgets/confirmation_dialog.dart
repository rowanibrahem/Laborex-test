import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {super.key, required this.text, required this.confirmationFunction});

  final String text;
  final void Function() confirmationFunction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text),
      actions: [
        ElevatedButton(
            onPressed:confirmationFunction, child: const Text("تأكيد")),
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: const Text("الغاء"))
      ],
    );
  }
}
