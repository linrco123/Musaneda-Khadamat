// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:musaneda/app/modules/hourly_service/date_picker/bindings/date_picker_bindings.dart';
import 'package:musaneda/app/modules/hourly_service/date_picker/views/date_picker_view.dart';
import 'package:musaneda/app/modules/hourly_service/hour_payment/views/hour_payment_view.dart';
import 'package:musaneda/app/modules/hourly_service/mediation/bindings/mediation_bindings.dart';
import 'package:musaneda/app/modules/hourly_service/mediation/views/add_mediation_view.dart';
import 'package:musaneda/app/modules/hourly_service/mediation/views/mediation_view.dart';
import 'package:musaneda/app/modules/hourly_service/order_details/bindings/orderDetails_binding.dart';
import 'package:musaneda/app/modules/hourly_service/order_details/views/orderDetails_view.dart';
import 'package:musaneda/app/modules/hourly_service/packages/bindings/bindings.dart';
import 'package:musaneda/app/modules/hourly_service/packages/views/packages_view.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/bindings/servicetype_binding.dart';
import 'package:musaneda/app/modules/hourly_service/service_type/views/service_type_view.dart';
import 'package:musaneda/app/modules/hourly_service/show_addressess/views/show_addressess_view.dart';
import 'package:musaneda/app/modules/hourly_service/welcome/bindings/welcome_bindings.dart';
import 'package:musaneda/app/modules/hourly_service/welcome/views/welcome_view.dart';
import 'package:musaneda/app/modules/internet_conn_status/bindings/internet_conn_bindings.dart';
import 'package:musaneda/app/modules/internet_conn_status/views/internet_connection.dart';
import 'package:musaneda/app/modules/locations/views/create_location_view.dart';
import 'package:musaneda/app/modules/notification/bindings/notification_binding.dart';
import 'package:musaneda/app/modules/notification/views/notification_view.dart';

import '../modules/complaint/bindings/complaint_binding.dart';
import '../modules/complaint/views/complaint_view.dart';
import '../modules/contract/bindings/contract_binding.dart';
import '../modules/contract/views/contract_view.dart';
import '../modules/delegation/bindings/delegation_binding.dart';
import '../modules/delegation/views/delegation_view.dart';
import '../modules/forget/bindings/forget_binding.dart';
import '../modules/forget/views/forget_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/filter_view.dart';
import '../modules/home/views/home_view.dart';
 import '../modules/locations/bindings/locations_binding.dart';
import '../modules/locations/views/locations_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_home_page/bindings/main_home_page_binding.dart';
import '../modules/main_home_page/views/main_home_page_view.dart';
 import '../modules/musaneda/bindings/musaneda_binding.dart';
import '../modules/musaneda/views/musaneda_view.dart';
import '../modules/musaneda/views/resume_view.dart';
 import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
 

part 'app_routes.dart';

class AppPages {
  AppPages._();
  
  static const WELCOME = Routes.WELCOME;
  static const INITIAL = Routes.LOGIN;
  static const MAIN = Routes.HOME;
   static const INTERNETCONNECTION = Routes.INTERNETCONNECTION;
  static const MAIN_HOME_PAGE = Routes.MAIN_HOME_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBindings(),
    ),
     GetPage(
      name: _Paths.SERVICETYPE,
      page: () => const ServiceTypeView(),
      binding: ServiceTypeBindings(),
    ),
    GetPage(
      name: _Paths.DATEPICKER,
      page: () => const DatePickerView(),
      binding: DatePickerBindings(),
    ),
    GetPage(
      name: _Paths.SHOWADDRESS,
      page: () => const ShowAddressessView(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGET,
      page: () => const ForgetView(),
      binding: ForgetBinding(),
    ),
    GetPage(
      name: _Paths.MUSANEDA,
      page: () => const MusanedaView(),
      binding: MusanedaBinding(),
    ),
    GetPage(
      name: _Paths.CONTRACT,
      page: () => const ContractView(),
      binding: ContractBinding(),
    ),
    GetPage(
      name: _Paths.FILTER,
      page: () => const FilterView(),
    ),
    
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(isReal: false),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DELEGATION,
      page: () => const DelegationView(),
      binding: DelegationBinding(),
    ),
    GetPage(
      name: _Paths.LOCATIONS,
      page: () => const LocationsView(),
      binding: LocationsBinding(),
    ),
     GetPage(
      name: _Paths.CREATELOCATIONS,
      page: () => const CreateLocationView(action: 'create', page: 'hour',),
    ),
    GetPage(
      name: _Paths.COMPLAINT,
      page: () => const ComplaintView(),
      binding: ComplaintBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => const OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDERDETAILS,
      page: () => const OrderDetailsView(),
      binding: OrderdetailsBinding(),
    ),
    GetPage(
      name: _Paths.INTERNETCONNECTION,
      page: () => const InternetConnectionView(),
      binding: InternetConnBindings(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_HOME_PAGE,
      page: () => const MainHomePageView(),
      binding: MainHomePageBinding(),
    ),

    GetPage(
      name: _Paths.RESUME,
      page: () => const ResumeView(),
      binding: MusanedaBinding(),
    ),
     GetPage(
      name: _Paths.PACKAGES,
      page: () => const PackagesView(),
      binding: PackagesBindings(),
    ),
      GetPage(
      name: _Paths.HOURPAYMENT,
      page: () => const HourPaymentView(),
     ),
      GetPage(
      name: _Paths.MEDIATION,
      page: () => const MediationView(),
      binding: MediationBindings()
     ),
     GetPage(
      name: _Paths.ADDMEDIATION,
      page: () => const AddMediationView(),
      binding: MediationBindings()
     ),




    
  ];
}
