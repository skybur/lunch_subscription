import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';

class BoxCountField extends StatefulWidget {
  final int initialBoxCount;
  final ValueChanged<int> boxCountChanged;

  const BoxCountField({Key key, this.initialBoxCount, this.boxCountChanged})
      : super(key: key);
  @override
  _BoxCountFieldState createState() => _BoxCountFieldState();
}

class _BoxCountFieldState extends State<BoxCountField> {
  int _boxCount;
  TextEditingController _boxFieldController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _boxCount = widget.initialBoxCount;
    _boxFieldController = TextEditingController(text: '$_boxCount');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            'Jumlah box per hari',
            style: AppTextStyle.header,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _boxFieldController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.lightOrange,
                    ),
                  ),
                  suffixText: 'Box',
                  contentPadding: const EdgeInsets.all(16.0),
                ),
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (text) {
                  var val = int.parse(text);
                  val = val > 100 ? 100 : val <= 0 ? 1 : val;
                  _boxFieldController.text = '$val';
                  _boxCount = val;
                  widget.boxCountChanged(val);
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  WhitelistingTextInputFormatter(RegExp(r'\d'))
                ],
              ),
            ),
            Container(
              width: 8.0,
              color: Colors.white,
            ),
            _buildValueChangeButton(
              buttonText: '-',
              valueChange: () {
                var prevBoxCount = _boxCount;
                --_boxCount == 0 ? _boxCount++ : _boxCount;
                _boxFieldController.text = '$_boxCount';
                if (prevBoxCount != _boxCount)
                  widget.boxCountChanged(_boxCount);
              },
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              textScaleFactor: 3.0,
              radius: BorderRadius.only(
                bottomLeft: Radius.circular(4.0),
                topLeft: Radius.circular(4.0),
              ),
            ),
            Container(
              width: 3.0,
              color: Colors.white,
            ),
            _buildValueChangeButton(
              buttonText: '+',
              valueChange: () {
                var prevBoxCount = _boxCount;
                ++_boxCount > 100 ? _boxCount-- : _boxCount;
                _boxFieldController.text = '$_boxCount';
                if (prevBoxCount != _boxCount)
                  widget.boxCountChanged(_boxCount);
              },
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              textScaleFactor: 2.0,
              radius: BorderRadius.only(
                bottomRight: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildValueChangeButton({
    String buttonText,
    VoidCallback valueChange,
    EdgeInsets padding,
    double textScaleFactor,
    BorderRadius radius,
  }) {
    return Material(
      borderRadius: radius,
      color: AppColors.lightOrange,
      child: InkWell(
        highlightColor: AppColors.darkOrange,
        splashColor: AppColors.darkOrange,
        onTap: valueChange,
        child: Padding(
          padding: padding,
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
            ),
            textScaleFactor: textScaleFactor,
          ),
        ),
      ),
    );
  }
}
