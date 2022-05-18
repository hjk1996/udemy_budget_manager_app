import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracking App',
      // theme arg를 통해서 app 전체의 테마를 정해줄 수 있음.
      // 색상, 폰트 등등..
      theme: ThemeData(
          // primarySwatch는 theme의 색상으로 사용할 색깔의 집합이라고 볼 수 있음.
          // theme 색상을 변경하면 맞물려서 설정한 색이 모두 변경됨.
          primarySwatch: Colors.blue,
          // colorScheme을 통해 예비색을 설정할 수 있음.
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
          errorColor: Colors.red,
          // pubspec.yaml 파일에서 설정해준 font를 사용할 수 있음.
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          // appBar에 대한 theme만 별도로 설정해줄 수도 있음.
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  // 최근 일주일에 추가된 Transaction들
  List<Transaction> get _recentTransactions {
    // True를 반환하는 tx로만 리스트를 필터링함.
    return _userTransactions.where((tx) {
      // 지난 일주일의 Transaction인지 확인함.
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);
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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracking App',
        ),
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
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
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
