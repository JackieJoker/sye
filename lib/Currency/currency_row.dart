import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sye/Currency/real_time_currency.dart';
import 'package:intl/intl.dart';

class CurrencyRow extends StatefulWidget {
  final String _currency;
  final String _groupCurrency;
  final AbstractControl<String> _amount;
  final FormGroup _form;

  const CurrencyRow(
      {required String currency,
      required AbstractControl<String> amount,
        required FormGroup form,
        required String groupCurrency,
        Key? key})
      : _currency = currency,
        _groupCurrency = groupCurrency,
        _amount = amount,
        _form = form,
        super(key: key);

  @override
  _CurrencyRowState createState() => _CurrencyRowState();
}

class _CurrencyRowState extends State<CurrencyRow> {
  late Future<RealTimeCurrency> _currencies;

  @override
  void initState() {
    _currencies = RealTimeCurrency.fetchCurrency(widget._groupCurrency);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String currency = widget._currency;
    return currency == widget._groupCurrency || currency.isEmpty
        ? const SizedBox.shrink()
        : FutureBuilder(
            future: _currencies,
            builder: (BuildContext context,
                AsyncSnapshot<RealTimeCurrency> snapshot) {
              if (snapshot.hasData) {
                num realTimeCurrency = snapshot.data!.data[currency];
                num value = double.parse((1 / realTimeCurrency).toStringAsFixed(5));
                return Row(
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText:
                              'Exchange rate (1 ' + currency + ' in ' + widget._groupCurrency + ')',
                        ),
                        readOnly: true,
                        controller:
                            TextEditingController(text: value.toString()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget._amount.invalid
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Converted Value',
                                  style: TextStyle(
                                    color: Color(0xFF666666),
                                  ),
                                ),
                                Text(
                                  formatAndUpdateForm(value * double.parse(widget._amount.value!)),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const Text("Error");
              }
              return const CircularProgressIndicator();
            },
          );
  }

  String formatAndUpdateForm(double number) {
    number = double.parse(number.toStringAsFixed(2));
    widget._form.findControl('converted_amount')!.value = number;
    //TODO: add the € symbol
    NumberFormat formatter = NumberFormat();
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 2;
    formatter.turnOffGrouping();
    return formatter.format(number);
  }
}
