import 'dart:ffi';

class Balance {
  final String _userId;
  final Float _balance;

  const Balance({required id, required bal}) :
      _userId = id,
      _balance = bal;

  String getId() => _userId;
  Float getBalance() => _balance;
}