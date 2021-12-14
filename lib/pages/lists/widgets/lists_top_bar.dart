
import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class ListsTopBar extends StatefulWidget {
  final List<String> listTypes;
  final Function onChanged;
  const ListsTopBar(this.listTypes, this.onChanged);

  @override
  _ListsTopBarState createState() => _ListsTopBarState();
}

class _ListsTopBarState extends State<ListsTopBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: 'LISTAGEM DE ${widget.listTypes.first.toUpperCase()}',
            size: 50,
            color: lightPurple,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: 240,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: lightPurple,
              ),
              child: DropdownButton(
                underline: const SizedBox(),
                value: widget.listTypes.first,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                dropdownColor: lightPurple,
                iconSize: 25,
                iconEnabledColor: Colors.white,
                isExpanded: true,
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    widget.listTypes.remove(value.toString());
                    widget.listTypes.insert(0, value.toString());
                  });
                  context.read<CloudFirestoreProvider>().listFor = value.toString();
                  context.read<CloudFirestoreProvider>().limitFor = 10;
                  widget.onChanged();
                },
                items: widget.listTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
