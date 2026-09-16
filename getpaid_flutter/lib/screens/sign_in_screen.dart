import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';

/// Auth gate with a FORCED high-contrast light theme.
///
/// Rationale: the Serverpod auth forms render with plain theme defaults, and
/// `ThemeMode.system` lets some browsers (observed: Edge) resolve the seeded
/// scheme into washed-out, near-unreadable pastels. The gate is the judges'
/// first screen, so it never follows the OS scheme — always light, always
/// near-black text, always a solid button.
ThemeData _gateTheme() {
  const primary = Color(0xFF14532D); // deep green: 8.9:1 on white
  const ink = Color(0xFF101410);
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1B7A4A),
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.white,
    ),
    useMaterial3: true,
  );
  return base.copyWith(
    scaffoldBackgroundColor: Colors.white,
    textTheme: base.textTheme.apply(
      bodyColor: ink,
      displayColor: ink,
    ),
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      labelStyle: const TextStyle(color: Color(0xFF2F3A32)),
      hintStyle: const TextStyle(color: Color(0xFF5A645C)),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF6B7670), width: 1.5),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primary, width: 2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: const Color(0xFFDDE3DE),
        disabledForegroundColor: const Color(0xFF5A645C),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  );
}

class SignInScreen extends StatefulWidget {
  final Widget child;
  const SignInScreen({super.key, required this.child});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_updateSignedInState);
    _isSignedIn = client.auth.isAuthenticated;
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_updateSignedInState);
    super.dispose();
  }

  void _updateSignedInState() {
    setState(() {
      _isSignedIn = client.auth.isAuthenticated;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isSignedIn) return widget.child;

    // Brand header above the stock auth form: always readable, and it makes
    // the product recognizable before the user even signs in.
    return Theme(
      data: _gateTheme(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'GetPaid',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF101410),
                    ),
                  ),
                  const Text(
                    'Invoices that chase themselves.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF2F3A32),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SignInWidget(
                    client: client,
                    onAuthenticated: () {
                      context.showSnackBar(
                        message: 'User authenticated.',
                        backgroundColor: const Color(0xFFDFF2E3),
                        foregroundColor: const Color(0xFF101410),
                      );
                    },
                    onError: (error) {
                      context.showSnackBar(
                        message: 'Authentication failed: $error',
                        backgroundColor: const Color(0xFFF6D9D7),
                        foregroundColor: const Color(0xFF101410),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension on BuildContext {
  void showSnackBar({
    required String message,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: foregroundColor)),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
