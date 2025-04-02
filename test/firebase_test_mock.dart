import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';

// Créer une classe mock pour Firebase
class MockFirebaseApp extends Mock implements FirebaseApp {}

// Initialiser Firebase avec un mock
Future<void> setupFirebaseForTests() async {
  // On crée un mock FirebaseApp
  final mockFirebaseApp = MockFirebaseApp();

  // Simule l'initialisation de Firebase
  when(Firebase.initializeApp()).thenAnswer((_) async => mockFirebaseApp);
}
