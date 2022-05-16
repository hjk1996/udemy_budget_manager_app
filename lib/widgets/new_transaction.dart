import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function handlePress;

  NewTransaction(this.handlePress);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // Controller는 입력 필드의 입력을 관리해주는 역할을 함.
  // input에 대한 state를 관리함.
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    // NewTransaction과 _NewTransactionState가 연결되어 있으므로
    // widget을 통해 NewTransaction의 method와 property에 접근할 수 있음.
    widget.handlePress(enteredTitle, enteredAmount);

    // 가장 위의 스크린(widget)을 닫음.
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            //  TextField Widget은 Text widget과 달리 사용자 입력을 받음.
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              // controller를 전달해주면 해당 컨트롤러가 입력을 관리해줌.
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              // TextField의 keyboardType 인자를 통해 어떤 종류의 키보드가 팝업될 것인지 정할 수 있음.
              keyboardType: TextInputType.number,
              // onSubmitted는 String value를 받는 void callback을 기대하고 있음.
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              child: Text('Add Transaction'),
              style: TextButton.styleFrom(primary: Colors.purple),
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
