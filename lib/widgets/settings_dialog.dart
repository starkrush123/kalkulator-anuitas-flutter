import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kalkulator_anuitas_flutter/models/settings.dart';

class SettingsDialogWidget extends StatefulWidget {
  const SettingsDialogWidget({super.key});

  @override
  State<SettingsDialogWidget> createState() => _SettingsDialogWidgetState();
}

class _SettingsDialogWidgetState extends State<SettingsDialogWidget> {
  late int _selectedFontSize;
  late ModeRumus _selectedModeRumus;
  late AppTheme _selectedTheme;

  @override
  void initState() {
    super.initState();
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    _selectedFontSize = settings.fontSize;
    _selectedModeRumus = settings.modeRumus;
    _selectedTheme = settings.theme;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pengaturan'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Mode Rumus'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ModeRumus.values.map((mode) {
                  return RadioListTile<ModeRumus>(
                    title: Text(mode == ModeRumus.biasa ? 'Anuitas Biasa' : 'Anuitas di Awal Periode'),
                    value: mode,
                    groupValue: _selectedModeRumus,
                    onChanged: (ModeRumus? value) {
                      setState(() {
                        _selectedModeRumus = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            ListTile(
              title: const Text('Ukuran Teks'),
              subtitle: DropdownButton<int>(
                value: _selectedFontSize,
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedFontSize = newValue!;
                  });
                },
                items: List.generate(9, (index) => 8 + index * 2)
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
            ListTile(
              title: const Text('Mode Tampilan'),
              subtitle: DropdownButton<AppTheme>(
                value: _selectedTheme,
                onChanged: (AppTheme? newValue) {
                  setState(() {
                    _selectedTheme = newValue!;
                  });
                },
                items: AppTheme.values.map<DropdownMenuItem<AppTheme>>((AppTheme value) {
                  String text;
                  switch (value) {
                    case AppTheme.terang:
                      text = 'Terang';
                      break;
                    case AppTheme.gelap:
                      text = 'Gelap';
                      break;
                    case AppTheme.ikutiSistem:
                      text = 'Ikuti Sistem';
                      break;
                  }
                  return DropdownMenuItem<AppTheme>(
                    value: value,
                    child: Text(text),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Batal'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Simpan'),
          onPressed: () {
            final settings = Provider.of<SettingsProvider>(context, listen: false);
            settings.setFontSize(_selectedFontSize);
            settings.setModeRumus(_selectedModeRumus);
            settings.setTheme(_selectedTheme);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}