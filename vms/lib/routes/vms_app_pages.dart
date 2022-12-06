import 'package:get/get.dart';
import 'package:vms/screens/client/dashboard/client_dashboard_screen.dart';
import 'package:vms/screens/client/visitor_insert/client_visitor_entry.dart';
import 'package:vms/screens/client/visitor_view/client_visitor_view.dart';
import 'package:vms/screens/company/company.dart';
import 'package:vms/screens/confirmation/confirm.dart';
import 'package:vms/screens/dashboard/dashboard_screen.dart';
import 'package:vms/screens/home/home.dart';
import 'package:vms/screens/login/login.dart';
import 'package:vms/screens/personal/personal.dart';
import 'package:vms/screens/ticket/ticket.dart';
import 'package:vms/screens/visitor_view/visitor_view_screen.dart';

import 'vms_app_routes.dart';

class VMSAppPages {

  static final routes = [

    GetPage(
      name: VMSRoutes.LOGIN,
      page: () => Login(),
    ),
    GetPage(
      name: VMSRoutes.HOME,
      page: () => Home(),
    ),
    // GetPage(
    //   name: VMSRoutes.QRSCAN,
    //   page: () => QRScanScreen(),
    // ),
    GetPage(
      name: VMSRoutes.PERSONAL,
      page: () => Personal(),
    ),
    GetPage(
      name: VMSRoutes.COMPANY,
      page: () => Company(),
    ),
    GetPage(
      name: VMSRoutes.CONFIRM,
      page: () => ConfirmScreen(),
    ),
    GetPage(
      name: VMSRoutes.TICKET,
      page: () => TicketScreen(),
    ),
    GetPage(
      name: VMSRoutes.VISITOR_VIEW,
      page: () => VisitorViewScreen(),
    ),
    GetPage(
      name: VMSRoutes.DASHBOARD_DETAILS,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: VMSRoutes.CLIENT_VISITOR_DASHBOARD,
      page: () => ClientDashboardScreen(),
    ),
    GetPage(
      name: VMSRoutes.CLIENT_VISITOR_VIEW,
      page: () => ClientVisitorView(),
    ),
    GetPage(
      name: VMSRoutes.CLIENT_INSERT_VISITOR,
      page: () => ClientVisitorEntryScreen(),
    ),
  ];
}
