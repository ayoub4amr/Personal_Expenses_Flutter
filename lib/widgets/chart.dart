import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get transactionValue {
    return List.generate(7, (index) {
      var day = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;
      for (var i = 0; i < transactions.length; i++) {
        if (day.day == transactions[i].dateTime.day &&
            day.month == transactions[i].dateTime.month &&
            day.year == transactions[i].dateTime.year) {
          totalAmount += transactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(day), 'amount': totalAmount};
    });
  }

  double get totalAmount {
    return transactionValue.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    // print(transactionValue);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: transactionValue
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        e['day'],
                        e['amount'],
                        totalAmount == 0
                            ? 0
                            : (e['amount'] as double) / totalAmount),
                  ))
              .toList()
              .reversed
              .toList(),
        ),
      ),
    );
  }
}
