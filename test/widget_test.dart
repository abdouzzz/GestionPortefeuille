import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_portefeuille/app_view.dart'; // On teste directement MyAppView

void main() {
  testWidgets('Counter increments test', (WidgetTester tester) async {
    // Assurer l'initialisation de Flutter
    WidgetsFlutterBinding.ensureInitialized();

    // Construire l'interface utilisateur
    await tester.pumpWidget(const MyAppView());

    // Vérifier que le compteur commence à 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Vérifier que le bouton d'incrémentation existe
    final Finder incrementButton = find.byIcon(Icons.add);
    expect(incrementButton, findsOneWidget);

    // Simuler un tap sur le bouton "+"
    await tester.tap(incrementButton);
    await tester.pumpAndSettle();

    // Vérifier que le compteur est passé à 1
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
