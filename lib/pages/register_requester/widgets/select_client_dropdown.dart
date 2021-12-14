import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/company.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class SelectClientDropdown extends StatefulWidget {
  final Company? initialCompany;
  final List<Company> companies;
  final Function onTap;
  const SelectClientDropdown(this.initialCompany, this.companies, this.onTap);

  @override
  _SelectClientDropdownState createState() => _SelectClientDropdownState();
}

class _SelectClientDropdownState extends State<SelectClientDropdown> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: widget.initialCompany == null ? const Text('Selecionar cliente') : Text(widget.initialCompany!.name),
      style: TextStyle(
        color: mediumBlue,
        fontWeight: FontWeight.bold,
      ),
      isExpanded: true,
      isDense: true,
      underline: const SizedBox(),
      onChanged: (value) {},
      items: widget.companies.map((company) {
        return DropdownMenuItem(
          onTap: () {
            widget.onTap(company);
          },
          value: company.name,
          child: CustomText(
            text: company.name,
          ),
        );
      }).toList(),
    );
  }
}
