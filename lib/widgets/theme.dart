
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData tema1() {
  return ThemeData(
    // color de fondo
    scaffoldBackgroundColor: Colors.black,

    // barra de la App
    appBarTheme:  AppBarTheme(
      backgroundColor:  const Color.fromARGB(255, 79, 1, 112),
      titleTextStyle:  GoogleFonts.aBeeZee(
        color: Colors.white,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ),

    // estilos de Texto
    textTheme:  TextTheme(
      // Títulos
      headlineMedium: GoogleFonts.langar(
        color: const Color.fromARGB(255, 223, 183, 240),
        fontWeight: FontWeight.bold,
        fontSize: 25.0,
      ),
    ),
  );
}