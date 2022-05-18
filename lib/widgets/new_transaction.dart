import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function handlePress;

  NewTransaction(this.handlePress);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

//Controller의 state가 변하므로 StatefulWidget으로 만들어줘야함.
class _NewTransactionState extends State<NewTransaction> {
  // Controller는 입력 필드의 입력을 관리해주는 역할을 함.
  // input에 대한 state를 관리함.
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    // NewTransaction과 _NewTransactionState가 연결되어 있으므로
    // widget을 통해 NewTransaction의 method와 property에 접근할 수 있음.
    widget.handlePress(enteredTitle, enteredAmount, _selectedDate);

    // 가장 위의 스크린(widget)을 닫음.
    // context argumnet 역시 widget과 마찬가지로 StatefulWidget과 연결되어 있어서 사용할 수 있음.
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    // showDatePicker 함수는 future임.
    // 왜냐하면 창만 띄웠지 값을 반환하는 것은 유저가 submit해야 하기 떄문에.
    // 따라서 then을 사용해서 비동기 처리를 해줄 수 있음.
    showDatePicker(
      context: context,
      // DatePicker창 열었을 때 처음 선택되어 있는 date
      initialDate: DateTime.now(),
      // DatePicker 창에서 선택할 수 있는 가장 빠른 date
      firstDate: DateTime(2015),
      // DatePicker 창에서 선택할 수 있는 가장 느린 date
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selectedDate = value;
        });
      },
    );
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
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              // TextField의 keyboardType 인자를 통해 어떤 종류의 키보드가 팝업될 것인지 정할 수 있음.
              keyboardType: TextInputType.number,
              // onSubmitted는 String value를 받는 void callback을 기대하고 있음.
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  // null이 아닌지 조건문을 통해서 체크하므로 !을 붙여서 null이 아니란 것을 보증해줄 수 있음.
                  Text(_selectedDate == null
                      ? 'No Date Chosen'
                      : DateFormat.yMd().format(_selectedDate!)),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            ElevatedButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
