import 'package:flutter/material.dart';
import 'package:rdx_manu_web/layout.dart';
import 'package:rdx_manu_web/main.dart';
import 'package:rdx_manu_web/models/service_order.dart';
import 'package:rdx_manu_web/pages/add_options/add_options.dart';
import 'package:rdx_manu_web/pages/authentication/authentication.dart';
import 'package:rdx_manu_web/pages/lists/lists.dart';
import 'package:rdx_manu_web/pages/my_account/my_account.dart';
import 'package:rdx_manu_web/pages/register_approver/register_approver.dart';
import 'package:rdx_manu_web/pages/register_business/register_business.dart';
import 'package:rdx_manu_web/pages/register_equipments/register_equipments.dart';
import 'package:rdx_manu_web/pages/register_mechanical/register_mechanical.dart';
import 'package:rdx_manu_web/pages/register_parts/register_parts.dart';
import 'package:rdx_manu_web/pages/register_requester/register_requester.dart';
import 'package:rdx_manu_web/pages/register_unity/register_unity.dart';
import 'package:rdx_manu_web/pages/register_user/register_user.dart';
import 'package:rdx_manu_web/pages/service_order_view/service_order_view.dart';
import 'package:rdx_manu_web/pages/service_orders_cards_resume/service_orders_cards_resume.dart';
import 'package:rdx_manu_web/pages/unity_view/unity_view.dart';
import 'package:rdx_manu_web/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case layoutRoute:
      return _getPageRoute(SiteLayout());
    case homePageRoute:
      return _getPageRoute(ServiceOrdersCardsResumePage());
    case addPageRoute:
      return _getPageRoute(AddOptionsPage());
    case listsPageRoute:
      return _getPageRoute(ListsPage());  
    case myAccountPageRoute:
      return _getPageRoute(MyAccountPage());
    case serviceOrderPageRoute:
      return _getPageRoute(ServiceOrderViewPage(settings.arguments! as ServiceOrder));   
    case registerBusinessPageRoute:
      return _getPageRoute(RegisterBusinessPage());
    case registerUnityPageRoute:
      return _getPageRoute(RegisterUnityPage());   
    case registerMechanicalPageRoute:
      return _getPageRoute(RegisterMechanicalPage());
    case registerRequesterPageRoute:
      return _getPageRoute(RegisterRequesterPage());
    case registerApproverPageRoute:
      return _getPageRoute(RegisterApproverPage());
    case registerEquipmentsPageRoute:
      return _getPageRoute(RegisterEquipmentsPage()); 
    case registerPartsPageRoute:
      return _getPageRoute(RegisterPartsPage());    
    case registerUserPageRoute:
      return _getPageRoute(RegisterUserPage());
    case unityViewPageRoute:
      return _getPageRoute(UnityViewPage());  
    case pageControllerRoute:
      return _getPageRoute(AppPagesController());      
    default:
      return _getPageRoute(AuthenticationPage());

  }
}

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}