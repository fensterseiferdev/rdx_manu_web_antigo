import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedSupportCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: SizedBox(
        width: 170,
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                child: CustomText(
                  text: 'PRECISA DE\n AJUDA?',
                  size: 18,
                  color:  mediumBlue,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  'assets/manu_home.png',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 170,
                    child: Material(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: const Color(0xFFDCFFD8),
                      child: InkWell(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        onTap: () async {
                          await launch('https://api.whatsapp.com/send?phone=5511989865532&text=Ol%C3%A1!%20Preciso%20de%20suporte%20com%20a%20RDX%20Manu.');
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 7),
                          child: Center(
                            child: CustomText(
                              text: 'Falar com a Manu',
                              size: 13,
                              color: Color(0xff5ac54e),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
