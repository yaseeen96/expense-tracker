import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widget/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: ((context, index) {
          return Dismissible(
              background: Container(
                decoration: const BoxDecoration(color: Colors.red),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                onRemoveExpense(expenses[index]);
              },
              key: ValueKey(
                expenses[index],
              ),
              child: ExpenseItem(expense: expenses[index]));
        }));
  }
}
