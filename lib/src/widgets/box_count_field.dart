import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunch_subscription/src/styles/app_theme.dart';
import 'package:lunch_subscription/src/widgets/edit_text.dart';
import 'package:lunch_subscription/src/widgets/value_changed_button.dart';

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
  FocusNode _boxFieldFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _boxCount = widget.initialBoxCount;
    _boxFieldController = TextEditingController(text: '$_boxCount');
    _boxFieldFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Text('Jumlah box per hari', style: AppTextStyle.header),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            NumberEditText(
              focusNode: _boxFieldFocusNode,
              controller: _boxFieldController,
              suffixText: 'Box',
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
            Container(width: 8.0),
            ValueChangedButton(
              buttonText: '-',
              valueChange: () {
                if (_boxFieldFocusNode.hasFocus) _boxFieldFocusNode.unfocus();
                var prevBoxCount = _boxCount;
                --_boxCount == 0 ? _boxCount++ : _boxCount;
                _updateBoxCountText(prevBoxCount, _boxCount);
              },
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              textScaleFactor: 3.0,
              radius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
              ),
            ),
            Container(width: 3.0),
            ValueChangedButton(
              buttonText: '+',
              valueChange: () {
                if (_boxFieldFocusNode.hasFocus) _boxFieldFocusNode.unfocus();
                var prevBoxCount = _boxCount;
                ++_boxCount > 100 ? _boxCount-- : _boxCount;
                _updateBoxCountText(prevBoxCount, _boxCount);
              },
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              textScaleFactor: 2.0,
              radius: BorderRadius.only(
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _updateBoxCountText(int prevBoxCount, int boxCount) {
    _boxFieldController.text = '$_boxCount';
    if (prevBoxCount != _boxCount) widget.boxCountChanged(_boxCount);
  }
}
