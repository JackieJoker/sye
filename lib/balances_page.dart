import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:sye/Db/db.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'Groups/group.dart';
import 'package:number_display/number_display.dart';


class BalancesPage extends StatefulWidget {
  final String _groupId;
  final String _groupCurrency;
  final Group _group;

  const BalancesPage(String id, String curr, Group g, {Key? key}) : _group = g, _groupId = id,_groupCurrency = curr, super(key: key);

  @override
  _BalancesPageState createState() => _BalancesPageState();
}

class _BalancesPageState extends State<BalancesPage> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(
      enable: true,
      elevation: 20,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = [];
    Map? userName = widget._group.getUsers();
    log(widget._group.getUsers().toString());

    final display = createDisplay(
      length: 8,
      decimal: 2,
    );
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: FirebaseDatabaseQueryBuilder(
              query: DB.getGroupBalances(widget._groupId),
              builder: (BuildContext context, FirebaseQueryBuilderSnapshot snapshot, Widget? child) {
                if (snapshot.isFetching) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                List<DataSnapshot> balances = snapshot.docs;
                Map<String, dynamic> result = {};
                for (int i = 0; i < balances.length; i++) {
                  result.addAll({userName![balances[i].key!]: balances[i].value});
                }
                //print(result.toString());
                int i = 0;
                result.forEach((key, value) {
                  data.add(_ChartData(key, value));
                  i++;
                });
                return Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  child: Center(
                    child: SfCartesianChart(
                        plotAreaBorderWidth: 4,
                        primaryXAxis: CategoryAxis(
                            axisLine: const AxisLine(
                                color: Colors.black,
                                width: 3
                            )
                        ),
                        primaryYAxis: NumericAxis(
                            minimum: -600,
                            maximum: 600,
                            interval: 300,
                            axisLine: const AxisLine(
                                color: Colors.black,
                                width: 3
                            )
                        ),
                        tooltipBehavior: _tooltip,
                        series: [
                          ColumnSeries(
                              selectionBehavior: SelectionBehavior(
                                  enable: true,
                                  selectedColor: Colors.teal
                              ),
                              //borderRadius: BorderRadius.circular(10),
                              dataSource: data,
                              yValueMapper: (_ChartData data, _) => data.y,
                              xValueMapper: (_ChartData data, _) => data.x,
                              //color: (true) ? Colors.green : Colors.red,
                              name: 'Balances',
                              color: Color.fromRGBO(8, 142, 255, 1),
                              pointColorMapper: (_ChartData data, _) => (data.y > 0) ? data.goodCol : data.badCol,
                          ),
                        ]
                    ),
                  ),
                );
              }
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: FirebaseDatabaseListView(
              query: DB.getGroupBalances(widget._groupId),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, snapshot) {
                return Card(
                  elevation: 5,
                  shadowColor: Colors.deepPurpleAccent,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 3,
                        child: ListTile(
                          leading: const Icon(
                            Icons.person,
                            size: 45,
                            color: Colors.deepPurpleAccent,
                          ),
                          title: Text(userName![snapshot.key],
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                          ),
                          ),
                        ),
                      ),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Text(
                              display(snapshot.value as num).toString() + ' ' + widget._groupCurrency,
                            overflow: TextOverflow.clip,
                          )
                      ),
                    ],
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final dynamic y;
  Color? goodCol = Colors.green;
  Color? badCol = Colors.red;

  String getX() => x;
  dynamic getY() => y;
}

