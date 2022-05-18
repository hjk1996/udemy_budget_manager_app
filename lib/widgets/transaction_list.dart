import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      // ListView는 Column과 SingleChildScrollView가 합쳐진 위젯이라고 생각하면 편함.
      // ListView는 default size가 infinite이기 때문에
      // 상위 위젯에서 너비나 높이를 설정해줘야함.
      // ListView는 list 내에 있는 모든 아이템을 렌더하는 반면,
      // ListView.builder()는 visible한 item만 render 한다는 차이점이 있음.
      // 길이수가 확정되어 있지 않고 긴 리스트가 예상될 경우 ListView.builder를 사용하는 것이 좋고
      // 리스트가 길지 않고 리스트에 있는 아이템의 수가 몇개인지 사전에 파악가능한 경우 그냥 ListView를 사용하는 것이 좋음.
      child: userTransactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                // 스페이싱을 위한 빈상자.
                SizedBox(
                  height: 20,
                ),
                Container(
                    // fit을 BoxFit.cover로 설정해주면서 Image를 감싸고 있는 Container 크기로
                    // 이미지 사이즈를 변경할 수 있음.
                    child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                  height: 200,
                ))
              ],
            )
          : ListView.builder(
              // itemBuilder는 리스트 안의 각 item을 어떻게 각기 렌더링할까 정해주는 함수를 전달해줘야함.
              itemBuilder: (ctx, idx) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  elevation: 5,
                  child: ListTile(
                    // leading은 최자측 아이콘
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('\$${userTransactions[idx].amount}')),
                      ),
                    ),
                    // title은 중앙의 메인 텍스트
                    title: Text(userTransactions[idx].title,
                        style: Theme.of(context).textTheme.titleMedium),
                    // subtitle은 메인 텍스트 밑에 있는 서브텍스트
                    subtitle: Text(
                        DateFormat.yMMMd().format(userTransactions[idx].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        deleteTransaction(userTransactions[idx].id);
                      },
                    ),
                  ),
                );
              },
              // itemCount로 전체 list이 길이가 얼마나 되는지 명시해줘야함.
              itemCount: userTransactions.length,
            ),
    );
  }
}
