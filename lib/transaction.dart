import 'package:flutter/material.dart';

class transaction extends StatelessWidget {
  final String transactionName;
  final String amount;
  final String expenseorIncome;

  transaction({
    required this.transactionName,
    required this.amount,
    required this.expenseorIncome,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        
        padding: EdgeInsets.all(16),
        color: Colors.grey[200],
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(transactionName),
            Text((expenseorIncome == 'expense' ? '-' : '+' ) + "₹"+ amount, style: TextStyle(color: expenseorIncome == 'expense' ? Colors.red : Colors.green),),
          ],
        ),
        
      ),
    );
    
  }
}
