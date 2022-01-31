import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sye/Db/db.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'edit_group_page.dart';
import 'group.dart';
import 'package:number_display/number_display.dart';

class GroupStats extends StatefulWidget {
  final Group _group;
  const GroupStats({required Group g, Key? key}) : _group = g, super(key: key);

  @override
  _GroupStatsState createState() => _GroupStatsState();
}

class _GroupStatsState extends State<GroupStats> {

  @override
  Widget build(BuildContext context) {
    final display = createDisplay(
      length: 8,
      decimal: 2,
    );

    Group g = widget._group;
    List uList = getUsers(g.getUsers()!);
    log(uList.toString());
    return FutureBuilder(
      future: DB.getTotalGroupBalances(g.getId()),
      builder: (context, snap) {
        if (snap.hasData) {
          Map result = snap.data as Map;
          List<ChartData> data = [];
          result.forEach((key, value) {
            for (int i = 0; i < uList.length; i++) {
              if (key == 'u' + i.toString()) {
                data.add(ChartData(uList[i], value));
              }
            }
          });
          return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 20,
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          child: Text(widget._group.getName()),
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => EditGroupPage(group: widget._group))
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Wrap(
                            children: List.generate(uList.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: Text(
                                  uList[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                        child: const Icon(Icons.menu),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => EditGroupPage(group: widget._group)));
                        }
                    )
                  ],
                )
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: 500,
                      child: SfCircularChart(
                        legend: Legend(isVisible: true),
                        title: ChartTitle(
                            text: 'Total Group Balance',
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          )
                        ),
                        series: <CircularSeries>[
                          PieSeries<ChartData, String>(
                              enableTooltip: true,
                              dataSource: data,
                            xValueMapper: (ChartData data,_) => data.x,
                            yValueMapper: (ChartData data,_) => data.y,
                          name: 'Sales',
                              dataLabelSettings:const DataLabelSettings(
                                alignment: ChartAlignment.center,
                                  opacity: 0,
                                  overflowMode: OverflowMode.trim,
                                  labelPosition: ChartDataLabelPosition.outside,
                                  isVisible : true,
                                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 15,
                      shadowColor: Colors.teal,
                      child: Row(
                        children: [
                          const Flexible(
                            fit: FlexFit.tight,
                              flex: 3,
                              child: ListTile(
                                leading: Icon(Icons.attach_money_rounded, size: 40,
                                  color: Colors.green,
                                ),
                                title: Text('Total Expenses Amount',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                              flex: 1,
                              child: Text(display(getTotal(data)).toString() + ' ' + widget._group.getCurrency()))
                        ],
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        elevation: 15,
                        shadowColor: Colors.teal,
                        child: Row(
                          children: [
                            const Flexible(
                              fit: FlexFit.tight,
                              flex: 3,
                              child: ListTile(
                                leading: Icon(Icons.account_balance_rounded,
                                  size: 40,
                                  color: Colors.teal,
                                ),
                                title: Text('Best Payer',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Flexible(
                                child: Text(getBestPayer(data))
                                )
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 20,
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          child: Text(widget._group.getName()),
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => EditGroupPage(group: widget._group))
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Wrap(
                            children: List.generate(uList.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: Text(
                                  uList[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                        child: const Icon(Icons.menu),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => EditGroupPage(group: widget._group)));
                        }
                    )
                  ],
                )
            ),
            body: const Center(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Card(
                  shadowColor: Colors.teal,
                  elevation: 20,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Add new expenses to visualize Group Stats!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                ),
              ),
            ),
          );
        }
      },
    );
  }
  List getUsers(Map m) {
    List list = [];
    m.forEach((key, value) {
      list.add(value);
    });
    return list;
  }

  double getTotal(List<ChartData> l) {
    double tot = 0;
    for (var element in l) {tot += element.y;}
    return tot;
  }

  String getBestPayer(List<ChartData> l) {
    ChartData bestPayer = l[0];
    for (int i = 1; i < l.length; i++) {
      if (l[i].y > bestPayer.y) {
        bestPayer = l[i];
      }
    }
    return bestPayer.x;
  }
}

class ChartData {
  ChartData(this.x, this.y/*, this.color*/);
  final String x;
  final double y;//final Color color;
}
