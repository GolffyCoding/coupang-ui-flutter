import 'package:flutter/material.dart';
import '../core/theme/cp_theme.dart';
import 'root_shell.dart';

class CoupangApp extends StatelessWidget {
  const CoupangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coupang UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: CpText.font,
        scaffoldBackgroundColor: CpColors.bg,
        primaryColor: CpColors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: CpColors.blue,
          primary: CpColors.blue,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: CpColors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: CpColors.textMain),
        ),
      ),
      home: const CpRootShell(),
    );
  }
}
