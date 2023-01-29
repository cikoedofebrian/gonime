import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  static const List<String> filters = [
    "Top",
    "Upcoming",
    "Series",
    "Romance",
    "Slice of Life"
  ];

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(
              horizontal: BorderSide(color: Colors.black, width: 0.5))),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        // padding: EdgeInsets.symmetric(vertical: 5),
        itemBuilder: ((context, index) => Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.black,
              ),
              child: Text(
                Filter.filters[index],
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )),
        itemCount: Filter.filters.length,
      ),
    );
  }
}
