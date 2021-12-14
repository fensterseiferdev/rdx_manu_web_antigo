import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/provider/filter_provider.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class SearchServiceOrderField extends StatefulWidget {

  @override
  _SearchServiceOrderFieldState createState() => _SearchServiceOrderFieldState();
}

class _SearchServiceOrderFieldState extends State<SearchServiceOrderField> {
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 5),
      child: context.watch<FilterProvider>().isFiltering ?
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                lightPurple,
              ),
            ),
            onPressed: () {
              context.read<FilterProvider>().selectedFilter = '';
              context.read<FilterProvider>().filterStage = -1;
            }, 
            child: const CustomText(
              text: 'Remover filtro',
              color: Colors.white,
              size: 15,
            ),
          ),
        ) :
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
            SizedBox(
              width: 250,
              height: 40,
              child: TextFormField(
                controller: context.read<FilterProvider>().searchController,
                onChanged: (value) {
                  setState(() {});
                },
                onFieldSubmitted: (index) {
                  context.read<FilterProvider>().search = index;
                  context.read<FilterProvider>().selectedFilter = '';
                  context.read<FilterProvider>().filterStage = -1;
                },
                textAlign: TextAlign.center,
                cursorColor: lightPurple,
                decoration: InputDecoration(
                  hintText: 'Pesquisar pelo número da O.S.',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: lightPurple,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: lightPurple,
                    ),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: lightPurple,
                    ),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
          InkWell(
            onTap: context.read<FilterProvider>().searchController.text.isEmpty ? null : () {
              if(context.read<FilterProvider>().isSearching) {
                context.read<FilterProvider>().search = '';
                context.read<FilterProvider>().searchController.clear();
              } else {
                context.read<FilterProvider>().selectedFilter = '';
                context.read<FilterProvider>().filterStage = -1;
                context.read<FilterProvider>().search = context.read<FilterProvider>().searchController.text;
              }
            },
            child: Icon(
              context.watch<FilterProvider>().isSearching ? Icons.close : Icons.search,
              size: 25,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}