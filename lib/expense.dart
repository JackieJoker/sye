import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Expense extends StatelessWidget {
  final String _title;
  final String _emoji;
  final String _payer;
  final num _amount;
  final String _date;
  //TODO: final ExpenseDetail _expenseDetail;

  const Expense(
      {emoji = "❤️",
        required title,
        required payer,
        required amount,
        required date,
        Key? key})
      : _emoji = emoji,
        _title = title,
        _payer = payer,
        _amount = amount,
        _date = date,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(_emoji),
              ),
              Column(
                children: [
                  Text(
                    _title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    _payer,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                _amount.toString() + " €",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  _date,
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
    );
  }
}