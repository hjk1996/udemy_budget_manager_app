import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function handlePress;

  NewTransaction(this.handlePress);

  // Controller는 입력 필드의 입력을 관리해주는 역할을 함.
  final titleController = TextEditingController();
  final amountController = TextEditingController();

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
              // field의 변화 event에 대응하는 함수는 onChange
              // onChanged: (value) {
              //   titleInput = value;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              // onChanged: (value) {
              //   amountInput = value;
              // },
            ),
            TextButton(
              child: Text('Add Transaction'),
              style: TextButton.styleFrom(primary: Colors.purple),
              onPressed: () {
                handlePress(titleController.text, double.parse(amountController.text));
              },
            ),
          ],
        ),
      ),
    );
  }
}
