import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class SheetPart {
  String code;
  String description;
  String fl;
  String group;
  double ipi;
  double ipiValue;
  String ncm;
  double salesPriceWithAllTaxes;
  double salesPriceWithoutIpi;
  String tp;
  String um;

  SheetPart({
    required this.code,
    required this.description,
    this.fl = '',
    this.group = '',
    this.ipi = 0,
    this.ipiValue = 0,
    this.ncm = '',
    required this.salesPriceWithAllTaxes,
    this.salesPriceWithoutIpi = 0,
    this.tp = '',
    this.um = '',
  });

  factory SheetPart.fromSheet(Map<String, dynamic> partMap) {
    double dolarFormat(String value) {
      final MoneyMaskedTextController priceController = MoneyMaskedTextController();
      priceController.text = value;
      return priceController.numberValue;
    }
    
    return SheetPart(
      code: partMap['CODIGO'].toString(),
      tp: partMap['TP'].toString(),
      group: partMap['GRUPO'].toString(),
      description: partMap['DESCRICAO'].toString(),
      um: partMap['U.M.'].toString(),
      fl: partMap['FL'].toString(),
      ncm: partMap['NCM'].toString(),
      ipi: dolarFormat(partMap['IPI'].toString().replaceAll('%', '')),
      salesPriceWithoutIpi: dolarFormat(partMap['Sales Price without IPI'].toString()),
      ipiValue: dolarFormat(partMap['Valor IPI'].toString()),
      salesPriceWithAllTaxes: dolarFormat(partMap['Sales Price with all taxes'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'description': description,
      'fl': fl,
      'group': group,
      'ipi': ipi,
      'ipi_value': ipiValue,
      'ncm': ncm,
      'sales_price_with_all_taxes': salesPriceWithAllTaxes,
      'sales_price_without_ipi': salesPriceWithoutIpi,
      'tp': tp,
      'um': um,
    };
  }
}
