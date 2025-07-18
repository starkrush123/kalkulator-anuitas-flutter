import 'package:flutter/material.dart';

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tentang Kalkulator Anuitas'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Kalkulator Anuitas', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            const Text('Dibuat oleh: Ridho'),
            const Text('Dibuat dengan Flutter.'),
            const SizedBox(height: 16.0),
            Text('Versi Flutter: ${Theme.of(context).platform}'), // Placeholder for Flutter version
          ],
        ),
      ),
      actions: <Widget>[
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