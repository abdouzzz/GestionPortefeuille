import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_repository/expense_repository.dart';

import 'package:gestion_portefeuille/data/data.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatelessWidget {
  final List<Expense> expenses;
  const MainScreen(this.expenses, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                      Stack(
                        alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow[700],
                          ),
                        ),
                        Icon(CupertinoIcons.person_fill,
                        )
                      ],
                    ),
                  SizedBox(width: 8,),
                  Column(
                    children: [
                      Text("Bienvenu",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey.shade400
                        ),
                      ),
                      Text("Valentin",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  ],
                ),
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.settings))
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.tertiary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                  ],
                  transform: GradientRotation(-pi/4),
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Colors.grey,
                    offset: Offset(5, 5)
                  )
                ]
              ),

              // LE SOLDE ET L'ARGENT TOTAL
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Votre solde',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '10 000 €',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // LIGNE POUR RENTREE D'ARGENT
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle
                              ),
                              child: Center(
                                child: Icon(
                                  CupertinoIcons.arrow_down,
                                  size: 15,
                                  color: Colors.greenAccent,
                                )
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rentrées',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300
                                  ),
                                ),
                                Text('500 €',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400
                                  ),),
                              ]
                            )
                          ],
                        ),
                        // LIGNE POUR SORTIE D'ARGENT
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white30,
                                  shape: BoxShape.circle
                              ),
                              child: Center(
                                  child: Icon(
                                    CupertinoIcons.arrow_up,
                                    size: 15,
                                    color: Colors.redAccent,
                                  )
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dépenses',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),
                                  Text('500 €',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400
                                    ),),
                                ]
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transactions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'Voir tout',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                  itemBuilder: (context, int i){
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child:
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Color(expenses[i].category.color),
                                          shape: BoxShape.circle
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30, // Ajuste cette valeur selon la taille de ton image
                                        height: 30, // Ajuste cette valeur selon la taille de ton image
                                        child: Image.asset(
                                          'assets/${expenses[i].category.icon}',
                                          color: Colors.white,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    expenses[i].category.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    ' - ${expenses[i].amount.toString()} €',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(expenses[i].date),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }
}
