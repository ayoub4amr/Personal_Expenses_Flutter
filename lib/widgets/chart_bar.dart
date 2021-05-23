import 'dart:ui';

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double amountPercentage;

  ChartBar(this.day, this.amount, this.amountPercentage);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          padding: EdgeInsets.all(3),
          child: FittedBox(
              child: Text(
            '\$$amount',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          )),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 100,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 220, 220, 1),
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: amountPercentage,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '$day',
          style: TextStyle(color: Theme.of(context).primaryColor),
        )
      ],
    );
  }
}
