import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/company.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class CompanyPickerDropdownButton extends StatefulWidget {
  final List<Company> companies;
  final Company? selectedCompany;
  final Function onSaved;
  const CompanyPickerDropdownButton(
      this.companies, this.selectedCompany, this.onSaved);

  @override
  _CompanyPickerDropdownButtonState createState() =>
      _CompanyPickerDropdownButtonState();
}

class _CompanyPickerDropdownButtonState
    extends State<CompanyPickerDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return FormField<Company>(
      initialValue: widget.selectedCompany,
      validator: (company) {
        if (company == null) {
          return 'Você deve selecionar um cliente';
        } else {
          return null;
        }
      },
      onSaved: (selectedCompany) => widget.onSaved(selectedCompany),
      builder: (state) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(246, 245, 247, 1),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: const Color.fromRGBO(237, 234, 242, 1),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              height: 55,
              child: DropdownButton(
                hint: Text(
                  state.value == null
                      ? 'Selecione um cliente para registar a unidade'
                      : state.value!.name,
                ),
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
                    onTap: () => state.didChange(company),
                    value: company.name,
                    child: Text(company.name),
                  );
                }).toList(),
              ),
            ),
            if(state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 5),
                child: CustomText(
                  text: state.errorText!,
                  color: Colors.red,
                  weight: FontWeight.normal,
                  size: 13,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
