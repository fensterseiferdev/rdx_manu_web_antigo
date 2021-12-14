import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/models/list_item.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';

class ShowMechanicalsList extends StatefulWidget {
  final List<ListItem> mechanicals;
  final String serviceOrderUid;
  const ShowMechanicalsList(this.mechanicals, this.serviceOrderUid);

  @override
  _ShowMechanicalsListState createState() => _ShowMechanicalsListState();
}

class _ShowMechanicalsListState extends State<ShowMechanicalsList> {
  String currentUid = '';

  bool allocating = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 440,
        height: 560,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color.fromRGBO(250, 246, 255, 1),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: SizedBox()),
                  Center(
                    child: Text(
                      'Selecione um mecânico',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(89, 98, 115, 1),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap:
                              allocating ? null : () => Navigator.pop(context),
                          child: const Icon(
                            Icons.close,
                            size: 28,
                            color: Color.fromRGBO(89, 98, 115, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: SizedBox(
                width: 410,
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.mechanicals.map((mechanical) {
                      return SizedBox(
                        width: 410,
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: Material(
                            borderRadius: BorderRadius.circular(14),
                            color: currentUid == mechanical.uid
                                ? const Color.fromRGBO(170, 170, 232, 1)
                                : Colors.white,
                            elevation: 5,
                            shadowColor:
                                const Color.fromRGBO(73, 56, 120, 0.38),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: allocating
                                  ? null
                                  : () => setState(
                                      () => currentUid = mechanical.uid),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18),
                                    child: Text(
                                      mechanical.name,
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: currentUid == mechanical.uid
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                89, 98, 115, 1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  if (currentUid == mechanical.uid)
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 230,
              height: 35,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    currentUid.isNotEmpty
                        ? const Color.fromRGBO(170, 170, 232, 1)
                        : Colors.grey,
                  ),
                ),
                onPressed: allocating ? null : currentUid.isNotEmpty ? () async {
                    setState(() => allocating = true);
                    final response = await context.read<CloudFirestoreProvider>().allocatedMechanical(
                      currentUid,
                      widget.serviceOrderUid,
                    );
                    Navigator.of(context).pop(response);
                    setState(() => allocating = false);
                  }
                : null,
                child: allocating
                    ? const SizedBox(
                        width: 23,
                        height: 23,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        'Confirmar',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
