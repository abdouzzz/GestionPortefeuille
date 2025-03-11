import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_portefeuille/screens/add_expenses/blocs/create_categorybloc/create_category_bloc.dart';
import 'package:intl/intl.dart';
import 'package:gestion_portefeuille/bouton.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:uuid/uuid.dart';

Future getCategoryCreation(BuildContext context){

  List<String> myIcons = [
    'cadis.png',
    'facture.png',
    'nourriture.png',
    'voiture.png',
  ];

  return showDialog(
      context: context,
      builder: (ctx){
        String iconSelected = '';
        bool isExpended = false;
        Color categoryColor = Colors.white;
        TextEditingController categoryNameController = TextEditingController();
        TextEditingController categoryIconController = TextEditingController();
        TextEditingController categoryColorController = TextEditingController();
        bool isLoading = false;
        Category category = Category.empty;

        return BlocProvider.value(
          value: context.read<CreateCategoryBloc>() ,
          child: StatefulBuilder(
            builder: (ctx, setState){
            return BlocListener<CreateCategoryBloc, CreateCategoryState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is CreateCategorySuccess) {
                  Navigator.pop(ctx, category);
                } else if (state is CreateCategoryLoading){
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: AlertDialog(
                  title: Text(
                    'Créer une catégorie',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: categoryNameController,
                        textAlignVertical: TextAlignVertical.center,
                        //readOnly: true,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Nom catégorie',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none
                            )
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: categoryIconController,
                        onTap: (){
                          setState(() {
                            isExpended = !isExpended;
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            suffixIcon: Icon(CupertinoIcons.chevron_down),
                            fillColor: Colors.white,
                            hintText: 'Icône',
                            border: OutlineInputBorder(
                                borderRadius: isExpended
                                    ? BorderRadius.vertical(
                                    top: Radius.circular(12)
                                )
                                    : BorderRadius.circular(12),
                                borderSide: BorderSide.none
                            )
                        ),
                      ),
                      isExpended
                          ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12)
                            )
                        ),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3
                          ),
                          itemCount: myIcons.length,
                          itemBuilder: (context, int i){
                            return Center(
                              child: GestureDetector(
                                onTap: (){
                                  setState((){
                                    iconSelected = myIcons[i];
                                  });
                                },
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: iconSelected == myIcons[i]
                                              ? Colors.green
                                              : Colors.grey,
                                          width: 3
                                      ),
                                      borderRadius: BorderRadius.circular(12)
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/${myIcons[i]}',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                          : Container(),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: categoryColorController,
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (ctx2){
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ColorPicker(
                                        pickerColor: categoryColor,
                                        onColorChanged: (value){
                                          setState((){
                                            categoryColor = value;
                                          });
                                        }
                                    ),
                                    SizedBox(
                                        width: double.infinity,
                                        height: 80,
                                        child: isLoading == true
                                            ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                            :
                                        CustomGradientButton(
                                            text: 'Couleur',
                                            onPressed: (){
                                              Navigator.pop(ctx2);
                                            }
                                        )
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: categoryColor,
                            hintText: 'Couleur',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none
                            )
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomGradientButton(
                          text: 'Créer',
                          onPressed: (){
                            setState((){
                              category.categoryId = const Uuid().v1();
                              category.name = categoryNameController.text;
                              category.icon = iconSelected;
                              category.color = categoryColor.value;
                            });
                            context.read<CreateCategoryBloc>().add(CreateCategory(category));

                            //Navigator.pop(ctx);
                          }
                      )
                    ],
                  )
              ),
            );
            },
          ),
        );
      }
  );
}