import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sye/Currency/currency_formatter.dart';
import 'package:sye/Groups/group.dart';
import 'expense.dart';
import 'expense_detail_page.dart';

class ExpenseElement extends StatelessWidget {
  final Expense _expense;
  final String _groupId;
  final Group _group;

  const ExpenseElement(
      {required String groupId, required Expense expense, required Group group, Key? key})
      : _expense = expense,
        _groupId = groupId,
        _group = group,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ExpenseDetailPage(
                    expenseId: _expense.expenseId,
                    group: _group,
                    groupId: _groupId,
                  ))),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
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
                  _expense.currency == _group.getCurrency()
                      ? CurrencyFormatter.format(
                          _expense.amount.toDouble(), _group.getCurrency())
                      : CurrencyFormatter.format(
                          _expense.convertedAmount!.toDouble(),
                          _group.getCurrency()),
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
