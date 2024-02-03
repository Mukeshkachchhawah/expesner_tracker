class ExpenseModal {
  int id;
  double amount;
  String category;

  ExpenseModal({required this.id,  required this.amount, required this.category});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
    };
  }

  factory ExpenseModal.fromMap(Map<String, dynamic> map) {
    return ExpenseModal(
      id: map['id'],
      amount: map['amount'],
      category: map['category'],
    );
  }
}