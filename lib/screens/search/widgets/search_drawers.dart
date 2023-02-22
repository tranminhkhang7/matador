import 'package:flutter/material.dart';

class FiltersDrawer extends StatefulWidget {
  final double maxPrice;

  const FiltersDrawer({Key? key, required this.maxPrice}) : super(key: key);

  @override
  _FiltersDrawerState createState() => _FiltersDrawerState();
}

class _FiltersDrawerState extends State<FiltersDrawer> {
  double _minPrice = 0.0;
  double _maxPrice = 0.0;
  String? _selectedCategory;
  bool _orderByDate = true;
  bool _orderByRating = false;

  @override
  void initState() {
    _maxPrice = widget.maxPrice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Text('Price Range'),
          ),
          RangeSlider(
            values: RangeValues(_minPrice, _maxPrice),
            min: 0,
            max: widget.maxPrice,
            onChanged: (RangeValues values) {
              setState(() {
                _minPrice = values.start;
                _maxPrice = values.end;
              });
            },
            labels: RangeLabels(
              _minPrice.toStringAsFixed(1),
              widget.maxPrice.toStringAsFixed(1),
            ),
          ),
          ListTile(
            title: Text('Category'),
          ),
          DropdownButton<String>(
            isExpanded: true,
            value: _selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
            items: <String>[
              'Category A',
              'Category B',
              'Category C',
              'Category D',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ListTile(
            title: Text('Order By'),
          ),
          RadioListTile(
            title: Text('Date'),
            value: true,
            groupValue: _orderByDate,
            onChanged: (bool? value) {
              setState(() {
                _orderByDate = true;
                _orderByRating = false;
              });
            },
          ),
          RadioListTile(
            title: Text('Rating'),
            value: true,
            groupValue: _orderByRating,
            onChanged: (bool? value) {
              setState(() {
                _orderByDate = false;
                _orderByRating = true;
              });
            },
          ),
          ListTile(
            title: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }
}
