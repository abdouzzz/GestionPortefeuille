import 'dart:math';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_portefeuille/screens/Accueil/View/main_screen.dart';
import 'package:gestion_portefeuille/screens/Accueil/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:gestion_portefeuille/screens/add_expenses/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:gestion_portefeuille/screens/add_expenses/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:gestion_portefeuille/screens/add_expenses/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:gestion_portefeuille/screens/add_expenses/views/add_expenses.dart';
import '../../stats/stats.dart';

class PageAccueil extends StatefulWidget {
  const PageAccueil({super.key});

  @override
  State<PageAccueil> createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil> {
  int index = 0;
  late Color selectedItem = Colors.blue;
  Color unselectedItem = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        if (state is GetExpensesSuccess) {
          return Scaffold(
            appBar: AppBar(),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  index = value;
                });
              },
              fixedColor: Colors.red,
              backgroundColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.home,
                    color: index == 0 ? selectedItem : unselectedItem,
                  ),
                  label: "Accueil",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.graph_square_fill,
                    color: index == 1 ? selectedItem : unselectedItem,
                  ),
                  label: "Stats",
                ),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Expense? newExpense = await Navigator.push(
                  context,
                  MaterialPageRoute<Expense>(
                    builder: (BuildContext context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => CreateCategoryBloc(FirebaseExpenseRepo()),
                        ),
                        BlocProvider(
                          create: (context) => GetCategoriesBloc(FirebaseExpenseRepo())..add(GetCategories()),
                        ),
                        BlocProvider(
                          create: (context) => CreateExpenseBloc(FirebaseExpenseRepo()),
                        ),
                      ],
                      child: const AddExpenses(),
                    ),
                  ),
                );
                if(newExpense != null){
                  setState(() {
                    state.expenses.insert(0, newExpense);
                  });
                }
              },
              shape: CircleBorder(),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                    ],
                    transform: GradientRotation(pi / 4),
                  ),
                ),
                child: Icon(CupertinoIcons.add),
              ),
            ),
            body: index == 0
                ? MainScreen(state.expenses)
                : StatsScreen(),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
