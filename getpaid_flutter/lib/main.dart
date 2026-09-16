import 'package:flutter/material.dart';

import 'client.dart';
import 'screens/invoice_list_screen.dart';
import 'screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const GetPaidApp());
}

ThemeData _buildTheme(Brightness brightness) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1B7A4A),
      brightness: brightness,
    ),
    useMaterial3: true,
  );
}

class GetPaidApp extends StatelessWidget {
  const GetPaidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetPaid — invoices that chase themselves',
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      // Locked to light: the seeded dark scheme renders washed-out in some
      // browsers (observed: Edge). Consistent first impression beats theming.
      themeMode: ThemeMode.light,
      home: const SignInScreen(child: InvoiceListScreen()),
    );
  }
}
