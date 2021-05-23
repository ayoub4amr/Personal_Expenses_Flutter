import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    Key key,
    @required this.transactions,
    @required this.transactionDel,
  }) : super(key: key);

  final Function transactionDel;
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(children: [
        ...transactions
            .map((e) => Card(
                  child: ListTile(
                    title: Text(
                      e.title,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900),
                    ),
                    subtitle: Text(DateFormat.yMMMd().format(e.dateTime)),
                    leading: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Text(
                          '${e.amount.toStringAsFixed(2)} \$',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => transactionDel(e.id),
                    ),
                  ),
                ))
            .toList(),
        SizedBox(
          height: 80,
        )
      ]),
    );
  }
}
