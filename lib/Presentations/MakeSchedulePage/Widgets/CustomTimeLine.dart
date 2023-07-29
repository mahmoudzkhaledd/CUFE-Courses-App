import 'package:coursesapp/Models/CourseSchedule.dart';
import 'package:flutter/material.dart';

class CustomTimeLine extends StatelessWidget {
  const CustomTimeLine({
    Key? key,
    required this.items,
  }) : super(key: key);
  final List<TimeLineItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        items.length,
        (index) {
          int h = index + 7;
          String period = "AM";
          if (h >= 12) period = "PM";
          if (h > 12) h -= 12;
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TimeLineItemWidget(item: items[index],),
          );
        },
      ),
    );
  }
}

class TimeLineItemWidget extends StatelessWidget {
  const TimeLineItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);
  final TimeLineItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${item.from.text} To ${item.to.text}".padRight(20,'  '),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              const Positioned(
                child: Divider(),
              ),
              Positioned(
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      Text(item.text),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TimeLineItem {
  final CourseTime from;
  final CourseTime to;
  final String text;

  const TimeLineItem({
    required this.from,
    required this.to,
    required this.text,
  });
}
