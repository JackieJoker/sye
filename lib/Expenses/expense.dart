class Expense {
  final String title;
  final String emoji;
  final String payer;
  final num amount;
  final String date;
  final String category;
  final String currency;
  final String type;
  final List<Object?> users;

  const Expense({
    required this.title,
    required this.emoji,
    required this.payer,
    required this.amount,
    required this.date,
    required this.category,
    required this.currency,
    required this.type,
    required this.users,
  });

  double amountPerUser(){
    return amount / users.length;
  }
}
