import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final List<StepperStep> steps;

  const CustomStepper({Key key, this.steps}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: steps,
    );
  }
}

class StepperStep extends StatelessWidget {
  final String title;
  final bool selected;
  final int weight;
  final bool isStart;
  final bool isEnd;

  StepperStep(
      {Key key,
      this.title,
      this.selected = false,
      this.weight = 1,
      this.isStart = false,
      this.isEnd = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: weight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color: selected ? Colors.orange : Colors.grey,
              ),
            ),
          ),
          _buildStepperCircle(context),
        ],
      ),
    );
  }

  Widget _buildStepperCircle(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: isStart
                  ? Alignment.centerRight
                  : isEnd ? Alignment.centerLeft : Alignment.center,
              child: Container(
                height: 3.0,
                width: isStart || isEnd
                    ? constraint.maxWidth / 2
                    : constraint.maxWidth,
                color: Colors.grey.shade200,
              ),
            ),
            Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                color: selected ? Colors.orange : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              height: 14.0,
              width: 14.0,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ],
        );
      },
    );
  }
}
