import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String errorMessage;
  final String tracebackText;

  const ErrorDialogWidget({
    super.key,
    required this.errorMessage,
    required this.tracebackText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Terjadi Kesalahan'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Mohon maaf, terjadi kesalahan pada aplikasi.\n$errorMessage'),
            const SizedBox(height: 16.0),
            ExpansionTile(
              title: const Text('Detail Kesalahan'),
              children: <Widget>[
                SelectableText(tracebackText),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Salin Debug'),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: tracebackText));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Informasi debug telah disalin ke clipboard.')),
            );
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}