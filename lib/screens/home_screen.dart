import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:kalkulator_anuitas_flutter/logic/hitung.dart';
import 'package:kalkulator_anuitas_flutter/models/settings.dart';
import 'package:kalkulator_anuitas_flutter/widgets/about_dialog.dart';
import 'package:kalkulator_anuitas_flutter/widgets/error_dialog.dart';
import 'package:kalkulator_anuitas_flutter/widgets/settings_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _pinjamanController = TextEditingController();
  final TextEditingController _bungaController = TextEditingController();
  final TextEditingController _periodeController = TextEditingController();
  final TextEditingController _angsuranKeController = TextEditingController();
  String _hasilPerhitungan = '';

  @override
  void dispose() {
    _pinjamanController.dispose();
    _bungaController.dispose();
    _periodeController.dispose();
    _angsuranKeController.dispose();
    super.dispose();
  }

  void _hitungAnuitas() {
    try {
      final settings = Provider.of<SettingsProvider>(context, listen: false);

      final double M = double.parse(_pinjamanController.text);
      final double i = double.parse(_bungaController.text) / 100.0;
      final int N = int.parse(_periodeController.text);
      final int? k = _angsuranKeController.text.isEmpty
          ? null
          : int.parse(_angsuranKeController.text);

      double A;
      if (settings.modeRumus == ModeRumus.biasa) {
        A = hitungAnuitasBiasa(M, i, N);
      } else {
        A = hitungAnuitasAwalPeriode(M, i, N);
      }

      final NumberFormat currencyFormatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 2,
      );

      String hasilText = 'Anuitas: ${currencyFormatter.format(A)}\n';

      if (k != null) {
        double sisaSebelum;
        if (k == 1) {
          sisaSebelum = M;
        } else {
          sisaSebelum = hitungSisaPinjamanSetelahAngsuranKeK(
              M, i, N, k - 1, settings.modeRumus == ModeRumus.biasa ? "biasa" : "awal_periode");
        }

        final double bungaK = hitungBungaAngsuran(sisaSebelum, i);
        final double pokokK = hitungAngsuranPokok(A, bungaK, sisaSebelum);
        final double sisaSetelah = sisaSebelum - pokokK;

        hasilText += 'Angsuran ke-$k: Pokok ${currencyFormatter.format(pokokK)}, Bunga ${currencyFormatter.format(bungaK)}, Sisa ${currencyFormatter.format(sisaSetelah)}';
      }

      setState(() {
        _hasilPerhitungan = hasilText;
        SemanticsService.announce(hasilText, Directionality.of(context));
      });
    } catch (e, stacktrace) {
      showDialog(
        context: context,
        builder: (context) => ErrorDialogWidget(
          errorMessage: e.toString(),
          tracebackText: stacktrace.toString(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Anuitas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Pengaturan',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const SettingsDialogWidget(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Tentang',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AboutDialogWidget(),
              );
            },
          ),
        ],
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Semantics(
                  label: 'Input total pinjaman dalam Rupiah',
                  child: TextField(
                    controller: _pinjamanController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Total Pinjaman (Rp)',
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: settings.fontSize.toDouble()),
                  ),
                ),
                const SizedBox(height: 16.0),
                Semantics(
                  label: 'Input bunga per periode dalam persen',
                  child: TextField(
                    controller: _bungaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Bunga per Periode (%)',
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: settings.fontSize.toDouble()),
                  ),
                ),
                const SizedBox(height: 16.0),
                Semantics(
                  label: 'Input jumlah periode angsuran',
                  child: TextField(
                    controller: _periodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Jumlah Periode',
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: settings.fontSize.toDouble()),
                  ),
                ),
                const SizedBox(height: 16.0),
                Semantics(
                  label: 'Input nomor angsuran untuk melihat detail, opsional',
                  child: TextField(
                    controller: _angsuranKeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Detail Angsuran ke- (opsional)',
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: settings.fontSize.toDouble()),
                  ),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _hitungAnuitas,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Text(
                    'Hitung Anuitas',
                    style: TextStyle(fontSize: settings.fontSize.toDouble()),
                  ),
                ),
                const SizedBox(height: 24.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Semantics(
                      label: 'Hasil perhitungan anuitas',
                      child: Text(
                        _hasilPerhitungan,
                        style: TextStyle(fontSize: settings.fontSize.toDouble()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}