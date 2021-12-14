import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rdx_manu_web/constants/style.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/pages/service_orders_cards_resume/widgets/search_service_order.dart';
import 'package:rdx_manu_web/pages/service_orders_cards_resume/widgets/service_order_resume_card.dart';
import 'package:rdx_manu_web/provider/cloud_firestore_provider.dart';
import 'package:provider/provider.dart';
import 'package:rdx_manu_web/provider/filter_provider.dart';
import 'package:rdx_manu_web/widgets/custom_text.dart';

class ServiceOrdersCardsLarge extends StatefulWidget {

  @override
  _ServiceOrdersCardsLargeState createState() => _ServiceOrdersCardsLargeState();
}

class _ServiceOrdersCardsLargeState extends State<ServiceOrdersCardsLarge> {
  String  paginationState = '';
  QuerySnapshot? currentSnapshot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SearchServiceOrderField(),
            if(context.watch<FilterProvider>().isFiltering)
              FutureBuilder<List<ServiceOrder>>(
                future: context.read<CloudFirestoreProvider>().loadFilteredServiceOrders(
                  context.read<FilterProvider>().filterStage,
                ),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.data!.isNotEmpty) {
                      return Wrap(
                        children: snapshot.data!.map((serviceOrder) {
                          return ServiceOrderResumeCard(serviceOrder);
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              CustomText(
                                text: 'Ainda não existem O.S. neste filtro',
                                size: 16,
                                maxLines: 2,
                                color: lightPurple,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    lightPurple,
                                  ),
                                ),
                                onPressed: () {
                                  context.read<FilterProvider>().filterStage = -1;
                                  context.read<FilterProvider>().selectedFilter = '';
                                }, 
                                child: const CustomText(
                                  text: 'OK',
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          lightPurple,
                        ),
                      ),
                    );
                  }
                }
              ),
            if(context.watch<FilterProvider>().isSearching)
              FutureBuilder<dynamic>(
                future: context.read<CloudFirestoreProvider>().loadSearchedOS(
                  context.read<FilterProvider>().search,
                ),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.data is ServiceOrder && snapshot.data != null) {
                      return Wrap(
                        children: [
                          ServiceOrderResumeCard(snapshot.data as ServiceOrder),
                        ],
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              CustomText(
                                text: 'Não foi encontrado nenhuma O.S. com esse número',
                                size: 16,
                                maxLines: 2,
                                color: lightPurple,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    lightPurple,
                                  ),
                                ),
                                onPressed: () {
                                  context.read<FilterProvider>().searchController.clear();
                                  context.read<FilterProvider>().search = '';
                                }, 
                                child: const CustomText(
                                  text: 'OK',
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          lightPurple,
                        ),
                      ),
                    );
                  }
                }
              ),
            if(!context.watch<FilterProvider>().isFiltering && !context.watch<FilterProvider>().isSearching)
              FutureBuilder<List<ServiceOrder>>(
                future: context.read<CloudFirestoreProvider>().loadOS(paginationState, currentSnapshot),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        Wrap(
                          children: snapshot.data!.map((serviceOrder) {
                            return ServiceOrderResumeCard(serviceOrder);
                          }).toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if(context.watch<CloudFirestoreProvider>().hasPreviousPage)
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    paginationState = 'previousPage';
                                    currentSnapshot = context.read<CloudFirestoreProvider>().currSnap;
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: lightPurple,
                                  size: 35,
                                ),
                              )
                            else
                              const SizedBox(),  
                            if(context.watch<CloudFirestoreProvider>().hasNextPage)  
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    paginationState = 'nextPage';
                                    currentSnapshot = context.read<CloudFirestoreProvider>().currSnap;
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: lightPurple,
                                  size: 35,
                                ),
                              )
                            else
                              const SizedBox(),  
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          lightPurple,
                        ),
                      ),
                    );
                  }
                }
              ),
          ],
        ),
      ),
    );
  }
}
