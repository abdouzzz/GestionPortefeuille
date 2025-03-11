import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> myData = [
  {
    'icon': FaIcon(FontAwesomeIcons.bowlFood, color: Colors.white),
    'color': Colors.orange,
    'name': 'Restauration',
    'cost': '-45 €',
    'date': "Aujourd'hui",
  },
  {
  'icon': FaIcon(FontAwesomeIcons.cartShopping, color: Colors.white),
  'color': Colors.red,
  'name': 'Courses' ,
  'cost': '-138 €' ,
  'date': "Aujourd'hui" ,
  },
  {
    'icon': FaIcon(FontAwesomeIcons.fileInvoiceDollar, color: Colors.white),
    'color': Colors.purple,
    'name': 'Factures' ,
    'cost': '-24 €' ,
    'date': "Hier" ,
  },
];