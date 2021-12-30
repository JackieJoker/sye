import 'package:flutter/material.dart';
import 'expense.dart';

class ExpenseDetail extends StatelessWidget {
  final Expense _expense;

  const ExpenseDetail({Key? key, required Expense expense})
      : _expense = expense,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            _expense.amount.toString(),
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payed by " + _expense.payer,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  _expense.date,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            "For:",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Column(
            children: _expense.users
                .map((e) => ListTile(title: Text(e.toString()), trailing: Text(_expense.amountPerUser().toStringAsFixed(2)),))
                .toList(),
          )
        ],
      ),
    );
  }
}
