import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_portefeuille/screens/add_expenses/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:gestion_portefeuille/screens/add_expenses/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:gestion_portefeuille/screens/add_expenses/views/category_creation.dart';
import 'package:intl/intl.dart';
import 'package:gestion_portefeuille/bouton.dart';
import 'package:uuid/uuid.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categorieController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();
  late Expense expense;
  bool isLoading = false;

  List<String> myIcons = [
    'cadis.png',
    'facture.png',
    'nourriture.png',
    'voiture.png',
  ];

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is CreateExpenseSuccess){
          Navigator.pop(context, expense);
        } else if (state is CreateExpenseLoading){
          setState(() {
            isLoading = true;
          });
        }
      },
  child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
          builder: (context, state) {
            if (state is GetCategoriesSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ajouter une dépense',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        controller: expenseController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            FontAwesomeIcons.euroSign,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      readOnly: true,
                      controller: categorieController,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),

                      onTap: () {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: expense.category == Category.empty
                        ? Colors.white
                        : Color(expense.category.color),
                        prefixIcon: expense.category == Category.empty
                            ? Icon(
                          FontAwesomeIcons.list,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        )
                            : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0), // Padding à gauche/droite
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset(
                              'assets/${expense.category.icon}',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        suffixIcon: IconButton(
                          onPressed: () async {
                            var newCategory = await getCategoryCreation(context);
                            setState(() {
                              state.categories.insert(0, newCategory);
                            });
                          },
                          icon: Icon(FontAwesomeIcons.plus),
                          color: Colors.grey,
                        ),
                        hintText: " Catégorie",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                            bottom: Radius.circular(12)
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: state.categories.length,
                          itemBuilder: (context, int i) {
                            return Card(
                              child: ListTile(
                                onTap: (){
                                  setState(() {
                                    expense.category = state.categories[i];
                                    categorieController.text = expense.category.name;
                                  });
                                },
                                leading: Image.asset(
                                  'assets/${state.categories[i].icon}',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                                title: Text(state.categories[i].name),
                                tileColor: Color(state.categories[i].color),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: expense.date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if (newDate != null) {
                          dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
                          expense.date = newDate;
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          FontAwesomeIcons.clock,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: Text("Date"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    isLoading
                    ? Center(child: CircularProgressIndicator())
                    : CustomGradientButton(
                      text: 'Ajouter',
                      onPressed: () {
                        setState(() {
                          expense.amount = int.parse(expenseController.text);
                        });
                        context.read<CreateExpenseBloc>().add(CreateExpense(expense));
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    ),
);
  }
}
