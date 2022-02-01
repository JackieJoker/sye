import 'package:flutter/material.dart';
import 'package:sye/Currency/currency_formatter.dart';
import 'package:sye/Groups/group.dart';
import 'expense.dart';

class ExpenseDetail extends StatelessWidget {
  final Expense _expense;
  final Group _group;

  const ExpenseDetail(
      {Key? key, required Expense expense, required Group group})
      : _expense = expense,
        _group = group,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(
                _expense.currency == _group.getCurrency()
                    ? CurrencyFormatter.format(
                        _expense.amount.toDouble(), _group.getCurrency())
                    : CurrencyFormatter.format(
                        _expense.convertedAmount!.toDouble(), _group.getCurrency()),
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            _expense.currency == _group.getCurrency()
                ? const SizedBox.shrink()
                : Text(
                    CurrencyFormatter.format(
                        _expense.amount.toDouble(), _expense.currency),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const Text(
                      "Payed by ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      _expense.payer,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ]),
                  Text(
                    _expense.date,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 8.0, left: 10.0),
              child: Row(children: const [
                Text(
                  "For:",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ]),
            ),
            Column(
              children: _expense.users
                  .map((e) => Card(
                elevation: 5,
                shadowColor: Colors.deepPurpleAccent,
                        child: ListTile(
                          title: Text(
                            e.toString(),
                            style: const TextStyle(color: Colors.blue),
                          ),
                          trailing: Text(CurrencyFormatter.format(
                              _expense.amountPerUser().toDouble(),
                              _group.getCurrency())),
                          //Text(_expense.amountPerUser().toStringAsFixed(2)),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
