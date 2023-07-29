import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeLine extends StatelessWidget {
  const TimeLine({
    Key? key,
    required this.itemCount,
    required this.separatorHeight,
    this.separatorColor,
    this.iconColor,
    required this.builder,
    required this.iconBuilder,
    this.separator,
  }) : super(key: key);
  final int itemCount;
  final double separatorHeight;
  final bool? separator;
  final Color? separatorColor;
  final Color? iconColor;
  final Widget Function(BuildContext context, int idx) builder;
  final Widget Function(BuildContext context, int idx) iconBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (idx) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  iconBuilder(context, idx),
                  if(separator != false)
                    Container(
                    width: 2,
                    height: separatorHeight,
                    color: separatorColor ?? Colors.black,
                  ),
                ],
              ),
              const SizedBox(width: 40),

              Expanded(child: builder(context, idx)),
            ],
          );
        },
      ),
    );
  }
}
