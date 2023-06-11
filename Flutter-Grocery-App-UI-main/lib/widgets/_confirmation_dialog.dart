import 'package:flutter/material.dart';

class ConfirmationDialog extends StatefulWidget {
  final String message;
  final String title;
  final VoidCallback? buttonAFunction;
  final VoidCallback? buttonBFunction;

  const ConfirmationDialog({
    Key? key,
    required this.message,
    required this.title,
    this.buttonAFunction,
    this.buttonBFunction,
  }) : super(key: key);

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.message),
      actions: [
        TextButton(
          onPressed: widget.buttonBFunction,
          style: TextButton.styleFrom(foregroundColor: Color(0xFF2A881E)),
          child: const Text('Batalkan'),
        ),
        ElevatedButton(
          onPressed: widget.buttonAFunction,
          style: ElevatedButton.styleFrom(
            foregroundColor: Color(0xFF2A881E),
            backgroundColor: Color(0xFFFEFFB5),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
