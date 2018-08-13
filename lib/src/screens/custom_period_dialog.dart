import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';
import 'package:lunch_subscription/src/widgets/edit_text.dart';
import 'package:lunch_subscription/src/widgets/value_changed_button.dart';

class CustomPeriodDialog extends StatelessWidget {
  final int currentLength;
  final _dayTextController = TextEditingController(text: '2');
  final _dayFocusNode = FocusNode();

  CustomPeriodDialog({Key key, this.currentLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
            ),
          )),
      contentPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text('Pilih Periode Langganan'),
          ),
          Row(
            children: <Widget>[
              NumberEditText(
                focusNode: _dayFocusNode,
                controller: _dayTextController..text = '$currentLength',
                suffixText: 'Hari',
                onChanged: (text) {
                  var val = int.parse(text);
                  val = val > 40 ? 100 : val <= 2 ? 2 : val;
                  _dayTextController.text = '$val';
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                  WhitelistingTextInputFormatter(RegExp(r'\d'))
                ],
              ),
              Padding(padding: EdgeInsets.all(4.0)),
              ValueChangedButton(
                buttonText: '-',
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                textScaleFactor: 3.0,
                radius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                ),
                valueChange: () {
                  if (_dayFocusNode.hasFocus) _dayFocusNode.unfocus();
                  var period = int.parse(_dayTextController.text);
                  --period < 2 ? period++ : period;
                  _dayTextController.text = '$period';
                },
              ),
              Padding(padding: EdgeInsets.all(1.0)),
              ValueChangedButton(
                buttonText: '+',
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                textScaleFactor: 2.0,
                radius: BorderRadius.only(
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                valueChange: () {
                  if (_dayFocusNode.hasFocus) _dayFocusNode.unfocus();
                  var period = int.parse(_dayTextController.text);
                  ++period > 40 ? period-- : period;
                  _dayTextController.text = '$period';
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: FlatButton(
              splashColor: AppColors.lightOrange,
              highlightColor: AppColors.orange,
              onPressed: () {
                Navigator.pop(context, int.parse(_dayTextController.text));
              },
              color: AppColors.darkOrange,
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
