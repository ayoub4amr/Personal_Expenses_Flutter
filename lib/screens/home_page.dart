import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String amount;
  TextEditingController amountController = TextEditingController();
  int id = 1;
  DateTime selectedDate;
  String title;
  TextEditingController titleController = TextEditingController();
  final List<Transaction> transactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   dateTime: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New Shirt',
    //   amount: 49.99,
    //   dateTime: DateTime.now(),
    // ),
  ];

  List<Transaction> get recentTransaction {
    return transactions.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addTransaction() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        selectedDate == null) {
      return;
    }
    setState(() {
      transactions.add(Transaction(
          // id: DateTime.now().toString(),
          id: id.toString(),
          title: title,
          amount: double.parse(amount),
          dateTime: selectedDate));
    });
    titleController.clear();
    amountController.clear();
    id++;
    Navigator.pop(context);
  }

  void transactionDel(id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Personal Expenses'),
      ),
      body: transactions.isEmpty
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/bg.jpg',
                fit: BoxFit.cover,
              ),
              // decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/bg.jpg'),fit: BoxFit.cover)),
            )
          : Column(
              children: [
                Chart(transactions),
                TransactionsList(
                  transactions: transactions,
                  transactionDel: transactionDel,
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                      color: Colors.white),
                  child: ListView(
                    padding: EdgeInsets.all(24),
                    children: [
                      TextField(
                        controller: titleController,
                        onChanged: (value) {
                          title = value;
                        },
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          amount = value;
                        },
                        onSubmitted: (_) => addTransaction(),
                        decoration: InputDecoration(labelText: 'Amount'),
                      ),
                      Container(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedDate == null
                                ? 'No Date Chosen'
                                : DateFormat.yMMMMd().format(selectedDate)),
                            IconButton(
                                icon: Icon(Icons.date_range_outlined),
                                color: Theme.of(context).primaryColor,
                                onPressed: pickDate)
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      TextButton(
                          onPressed: addTransaction,
                          child: Text(
                            'Add Transaction',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w900),
                          ))
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
