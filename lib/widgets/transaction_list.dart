import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;

  TransactionList(this.userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      // ListView는 Column과 SingleChildScrollView가 합쳐진 위젯이라고 생각하면 편함.
      // ListView는 default size가 infinite이기 때문에
      // 상위 위젯에서 너비나 높이를 설정해줘야함.
      // ListView는 list 내에 있는 모든 아이템을 렌더하는 반면,
      // ListView.builder()는 visible한 item만 render 한다는 차이점이 있음.
      // 길이수가 확정되어 있지 않고 긴 리스트가 예상될 경우 ListView.builder를 사용하는 것이 좋고
      // 리스트가 길지 않고 리스트에 있는 아이템의 수가 몇개인지 사전에 파악가능한 경우 그냥 ListView를 사용하는 것이 좋음.
      child: ListView.builder(
        // itemBuilder는 리스트 안의 각 item을 어떻게 각기 렌더링할까 정해주는 함수를 전달해줘야함.
        itemBuilder: (ctx, idx) {
          return Card(
            child: Row(children: <Widget>[
              // Container는 content의 크기에 따라 크기가 변함.
              Container(
                // EdgeInsets는 padding이나 margin을 설정하기 위해 사용함.
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.purple,
                  width: 2,
                )),
                padding: EdgeInsets.all(10),
                child: Text(
                  // toStringAsFixed는 소수점 둘째 자리까지 반올림한 숫자를 String을 반환함.
                  '\$${userTransactions[idx].amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    userTransactions[idx].title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    //intl의 DateFormat package
                    // 자세한 포맷은 아래 링크에서 확인
                    // https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
                    DateFormat.yMMMMd().format(userTransactions[idx].date),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              )
            ]),
          );
        },
        // itemCount로 전체 list이 길이가 얼마나 되는지 명시해줘야함.
        itemCount: userTransactions.length,
      ),
    );
  }
}
