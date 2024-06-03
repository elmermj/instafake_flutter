import 'package:flutter/material.dart';

class ExpandableListView extends StatefulWidget {
  const ExpandableListView({super.key});

  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  int? _currentlyExpandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expandable ListView'),
      ),
      body: ListView.builder(
        itemCount: 10, // Number of items in your list
        itemBuilder: (context, index) {
          return ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: EdgeInsets.zero,
            animationDuration: Duration(milliseconds: 500),
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                if (_currentlyExpandedIndex == index) {
                  _currentlyExpandedIndex = null;
                } else {
                  _currentlyExpandedIndex = index;
                }
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
                body: ListTile(
                  title: Text('Details for item $index'),
                ),
                isExpanded: _currentlyExpandedIndex == index,
              ),
            ],
          );
        },
      ),
    );
  }
}
