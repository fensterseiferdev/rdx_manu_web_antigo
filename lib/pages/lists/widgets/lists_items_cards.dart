import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/list_item.dart';
import 'package:rdx_manu_web/pages/lists/widgets/list_card_large.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:provider/provider.dart';

class ListsItemsCards extends StatefulWidget {

  @override
  _ListsItemsCardsState createState() => _ListsItemsCardsState();
}

class _ListsItemsCardsState extends State<ListsItemsCards> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListItem>>(
      future: context.read<CloudFirestoreProvider>().loadListFor(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              ListCardLarge(snapshot.data!),
              if(context.watch<CloudFirestoreProvider>().hasNextListPage)
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 50),
                  child: Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        context.read<CloudFirestoreProvider>().limitFor += 10;
                        setState(() {});
                      },
                      child: Material(
                        color: Colors.white,
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.add,
                            color: lightPurple,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  lightPurple,
                ),
              ),
            ),
          );
        }
      }
    );
  }
}