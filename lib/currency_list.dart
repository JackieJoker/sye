import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sye/real_time_currency.dart';

@Deprecated("TO DELETE")
class CurrencyList extends StatefulWidget {
  const CurrencyList({Key? key}) : super(key: key);

  @override
  _CurrencyListState createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  late Future<RealTimeCurrency> _currencies;

  @override
  void initState() {
    _currencies = RealTimeCurrency.fetchCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _currencies,
      builder:
          (BuildContext context, AsyncSnapshot<RealTimeCurrency> snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> currenciesList = snapshot.data!.data;
          return ReactiveDropdownField<String>(
            isExpanded: true,
            formControlName: 'currency',
            items: currenciesList.keys
                .map((e) => DropdownMenuItem(child: Text(e), value: e))
                .toList(),
          );
        } else if (snapshot.hasError) {
          return const Text("Error");
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
