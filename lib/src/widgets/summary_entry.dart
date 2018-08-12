import 'package:flutter/material.dart';

class SummaryEntry extends StatelessWidget {
  final String entryLabel;
  final String entryValue;
  final String entrySublabel;
  final TextStyle labelStyle;
  final TextStyle subLabelStyle;
  final TextStyle valueStyle;

  const SummaryEntry(
      {Key key,
      this.entryLabel,
      this.entryValue,
      this.entrySublabel,
      this.labelStyle,
      this.subLabelStyle,
      this.valueStyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var labels = [Text(entryLabel ?? '', style: labelStyle)];
    if (entrySublabel != null)
      labels.add(Text(entrySublabel, style: subLabelStyle));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: labels,
          ),
        ),
        Text(
          entryValue ?? '',
          style: valueStyle,
        ),
      ],
    );
  }
}
