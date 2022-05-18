import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  // getter
  List<Map> get groupedTransactionValues {
    return List.generate(7, (index) {
      // subtract는 빼기임.
      // 현재 시점에서부터 index 일만큼 빼줌
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      // DateFormat.E는 DateTime 객체를 축약된 요일 문자열로 바꿔줌.
      // 예를 들면. 목요일 -> Thu.
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    // List에서 fold는 누적합을 구하기 위해서 사용함.
    // 첫번째 arg는 시작값이고, 두번째 arg는
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            ...groupedTransactionValues.map(
              // Flexible widget을 통해 Row의 각 아이템이 같은 공간을 가지게 한다.
              // Flexible widget은 Row나 Column과 같이 여러 아이템을 받는 widget에서 사용할 수 있다.
              (d) => Flexible(
                // Flexible의 fit을 tight로 설정해주면 Row의 아이템들이 남은 공간을 차지하도록 강제로 늘리고
                // fit을 loose로 설정하면 Row의 아이템들이 필요한 공간만 차지하게 된다.
                fit: FlexFit.tight,
                child: ChartBar(
                  label: d['day'],
                  spendingAmount: d['amount'],
                  spendingPctOfTotal:
                      totalSpending == 0.0 ? 0.0 : d['amount'] / totalSpending,
                ),
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
