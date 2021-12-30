import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'expense.dart';
import 'expense_detail_page.dart';

class ExpenseElement extends StatelessWidget {
  final Expense _expense;

  const ExpenseElement({required Expense expense, Key? key})
      : _expense = expense,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ExpenseDetailPage(
                    expense: _expense,
                  ))),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(_expense.emoji),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          _expense.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          _expense.payer,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  _expense.amount.toString() + " €",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    _expense.date,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.end,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
