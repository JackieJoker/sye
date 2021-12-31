class Expense {
  final String expenseId;
  final String title;
  final String emoji;
  final String payer;
  final num amount;
  final num? convertedAmount;
  final String date;
  final String category;
  final String currency;
  final String type;
  final List<Object?> users;

  const Expense({
    required this.expenseId,
    required this.title,
    required this.emoji,
    required this.payer,
    required this.amount,
    this.convertedAmount,
    required this.date,
    required this.category,
    required this.currency,
    required this.type,
    required this.users,
  });

  double amountPerUser() {
    return convertedAmount == null
        ? amount / users.length
        : convertedAmount! / users.length;
  }
}
