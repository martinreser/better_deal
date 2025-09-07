import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/comparison_provider.dart';
import 'providers/localization_provider.dart';
import 'screens/comparison_screen.dart';

void main() {
  runApp(const BetterDealApp());
}

class BetterDealApp extends StatelessWidget {
  const BetterDealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ComparisonProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Better Deal - Commission Calculator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const ComparisonScreen(),
      ),
    );
  }
}
