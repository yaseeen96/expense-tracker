import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registeredExpenses = [
    Expense(
      title: "Saudi Arabia",
      amount: 23.34,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "Cinema",
      amount: 99.99,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void addExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = registeredExpenses.indexOf(expense);
    setState(() {
      registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text("${expense.title} deleted"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (ctx) {
          return NewExpense(
            onAddExpense: addExpense,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("You have no Expenses"),
          ElevatedButton(
              onPressed: _openAddExpenseOverlay,
              child: const Text("Add Expense")),
        ],
      ),
    );

    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Title(
            color: Colors.red,
            child: Text(
              "Expense Tracker",
            )),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: registeredExpenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
