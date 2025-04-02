import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_portefeuille/app_view.dart'; // On teste directement MyAppView

void main() {
  testWidgets('Counter increments test', (WidgetTester tester) async {
    // Assurer l'initialisation de Flutter
    WidgetsFlutterBinding.ensureInitialized();

    // Construire l'interface utilisateur
    await tester.pumpWidget(const MyAppView());
  });
}
