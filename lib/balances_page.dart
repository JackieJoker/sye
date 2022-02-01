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

    final display = createDisplay(
      length: 8,
      decimal: 2,
    );
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: FutureBuilder(
            future: DB.getBalances(widget._groupId),
            builder: (BuildContext context, snap) {
              if (snap.hasData) {
                Map balances = snap.data as Map;
                Map<String, dynamic> result = {};
                userName?.forEach((key, value) {
                  result.addAll({value : balances[key]});
                });
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
              } else {
                return const Center(
                  child: AlertDialog(
                    title: Text('Attention!'),
                    content: Text('Insert a new expense to visualize balances of the group'),
                  ),
                );
              }
            },
          )
        ),
        Flexible(
          fit: FlexFit.tight,
          child: FutureBuilder(
            future: DB.getBalances(widget._groupId),
            builder: (BuildContext ctxt, snap) {
              if (snap.hasData) {
                Map balances = snap.data as Map;
                List balList = [];
                balances.forEach((key, value) {
                  balList.add(value);
                });
                return ListView.builder(
                  itemCount: balList.length,
                    itemBuilder: (BuildContext context, int i) {
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
                                title: Text(userName!['u' + i.toString()],
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
                                  display(balList[i] as num).toString() + ' ' + widget._groupCurrency,
                                  overflow: TextOverflow.clip,
                                )
                            ),
                          ],
                        ),
                      );
                    },
                );
              } else {
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          )
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

