import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_portefeuille/screens/Accueil/View/PageAccueil.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:gestion_portefeuille/screens/Accueil/blocs/get_expenses_bloc/get_expenses_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gestion de portefeuille",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Color(0xFFF3FFFF),
          onSurface: Colors.black,
          primary: Color(0xFF00B2E7),
          secondary: Color(0xFFE064F7),
          tertiary: Color(0xFFFF8D6C),
        )
      ),
      home: BlocProvider(
        create: (context) => GetExpensesBloc(FirebaseExpenseRepo())..add(GetExpenses()),
          child: const PageAccueil(),
      ),
    );


  }
}
