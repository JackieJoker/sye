import 'package:flutter/material.dart';
import 'package:sye/expense.dart';
import 'user.dart';

class Group extends StatelessWidget{
  final String _name;
  final String _description;
  final String _creator;
  final String _currency;
  final String _category;
  final List<Expense> _expenses;
  final List<User> _users;

  const Group(
      {
        required name,
         description,
         creator,
        required currency,
         category,
         expenses,
         users,
        Key? key})
      : _name = name,
        _description = description,
        _currency = currency,
        _creator = creator,
        _category = category,
        _expenses = expenses,
        _users = users,
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
                child: Text(_category),
              ),
              Column(
                children: [
                  Text(
                    _name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
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
                _currency,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.end,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }


}