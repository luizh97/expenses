import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'components/chart.dart';
import 'components/transaction_list.dart';
import 'components/transaction_form.dart';

import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta Antiga',
      value: 400,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: 't1',
      title: 'Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    //   Transaction(
    //     id: 't3',
    //     title: 'Conta #03',
    //     value: 310.76,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't4',
    //     title: 'Conta #04',
    //     value: 211.30,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't5',
    //     title: 'Conta #05',
    //     value: 310.76,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't6',
    //     title: 'Conta #06',
    //     value: 211.30,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't7',
    //     title: 'Conta #07',
    //     value: 310.76,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't8',
    //     title: 'Conta #08',
    //     value: 211.30,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't9',
    //     title: 'Conta #09',
    //     value: 310.76,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't10',
    //     title: 'Conta #10',
    //     value: 211.30,
    //     date: DateTime.now(),
    //   ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(
        days: 7,
      )));
    }).toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransationFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransationFormModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransationFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
