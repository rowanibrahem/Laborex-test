import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {super.key,required this.text, required this.confirmationFunction,this.content=const SizedBox()});

  final String text;
  final void Function() confirmationFunction;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text),
      content: content,
      actions: [
        ElevatedButton(
            onPressed:confirmationFunction, child: const Text("تأكيد")),
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: const Text("الغاء"))
      ],
    );
  }
}
