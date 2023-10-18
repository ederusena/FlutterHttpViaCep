import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:trilhapp/pages/login_page.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const LoginPage(),
      // home: const HomePage(),
    );
  }
}
