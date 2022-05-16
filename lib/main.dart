import 'package:flutter/material.dart';
import 'package:udemy_budget_tracking_app/widgets/new_transaction.dart';
import 'package:udemy_budget_tracking_app/widgets/transaction_list.dart';

import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracking App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 55.22,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Grocery',
      amount: 16.43,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    // 사용자가 버튼을 클릭하면 뒤에 있는 내용을 가리는 하단 시트를 표시함.
    // 시트에 표시되는 내용은 builder에서 무슨 widget을 반환하냐에 따라 달라짐.
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        // NewTransaction은 입력창으로 transaction에 대한 list를 담고 있는
        // _userTransaction을 변화시키는 함수를 전달받음.
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      // 키보드 팝업되어 나오는거 고려해주기 위해서 SingleChildScrollView 추가로 달아줌
      // 만약 화면크기가 엄청 작은 경우 키보드가 입력창을 가릴 수 있기 때문에
      // 전체 Column을 scroll 할 수 있도록 만들어주는 것임.
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              // Card의 크기는 parent의 크기가 명백하게 설정되어 있지 않으면,
              // child의 크기에 따라 결정된다.
              child: Card(
                color: Colors.blue,
                child: Container(
                  child: Text('Chart!'),
                ),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      // 화면에 떠있는 버튼
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
