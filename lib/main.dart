import 'package:flutter/material.dart';

import './widgets/user_transactions.dart';

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

class MyHomePage extends StatelessWidget {
  // String titleInput;
  // String amountInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
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
            UserTransactions(),
          ],
        ),
      ),
    );
  }
}
