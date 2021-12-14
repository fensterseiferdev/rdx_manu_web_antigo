import 'package:flutter/material.dart';
import 'package:rdx_manu_web/pages/lists/widgets/lists_items_cards.dart';

import 'lists_top_bar.dart';

class ListsLarge extends StatefulWidget {

  final List<String> listTypes;
  const ListsLarge(this.listTypes);

  @override
  _ListsLargeState createState() => _ListsLargeState();
}

class _ListsLargeState extends State<ListsLarge> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          ListsTopBar(widget.listTypes, () {
            setState(() {});
          }),
          const SizedBox(height: 30),
          ListsItemsCards(),
        ],
      ),
    );
  }
}