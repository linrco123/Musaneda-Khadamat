import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

const appName = "musaneda";
const defaultLang = "ar";

const mapDefaultLatitude = 37.42796133580664;
const mapDefaultLongitude = (-122.085749655962);

const packageName = "com.fnrco.musaneda";
const merchantIDTestApplePay = "merchant.com.fnrco.musaneda.testApplePay";
const merchantIDLiveApplePay = "merchant.com.fnrco.musaneda.liveApplePay";

String _host = 'kdamat.fnrco.com.sa';

Uri _checkout = Uri(
  scheme: 'https',
  host: _host,
  path: '/api/v1/checkouts',
);

Uri _status = Uri(
  scheme: 'https',
  host: _host,
  path: '/api/v1/payments',
);

class Pretty {
  Pretty._();
  static final Pretty instance = Pretty._();
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );
}

class Constance {
  Constance._();
  static final Constance instance = Constance._();

  static GetStorage box = GetStorage();

  final int id = box.read('LOGIN_MODEL')['id'] ?? '';
  final String name = box.read('LOGIN_MODEL')['name'] ?? '';
  final String email = box.read('LOGIN_MODEL')['email'] ?? '';
  final String phone = box.read('LOGIN_MODEL')['phone'] ?? '';
  final String iqama = box.read('LOGIN_MODEL')['iqama'] ?? '';
  final String token = box.read('LOGIN_MODEL')['token'] ?? '';

  static String getName() {
    String name = '';
    if (box.hasData('LOGIN_MODEL')) {
      name = box.read('LOGIN_MODEL')['name'] ?? '';
    }

    return name;
  }

  static String getToken() {
    if (box.hasData('LOGIN_MODEL')) {
      return box.read('LOGIN_MODEL')['token'] ?? '';
    }
    return '';
  }

  static double checkDouble(dynamic value) {
    // check if value is null
    if (value == null) {
      return 0.0;
    }

    // check if value is empty string
    if (value is String && value.isEmpty) {
      return 0.0;
    }

    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return 0.0 + value;
    } else {
      return value;
    }
  }

  static const domain = "https://kdamat.com";
  //static const domain = "https://devlop.kdamat.com";
  static const apiEndpoint = "$domain/api/v1";
  static const mediaEndpoint = "$domain/storage/media/";
  static const String appName = "MUSANEDA";
  static const String appVersion = "1.0.0";
  static const String ALrajhi_BankAccount = '260608010001019';
  static const String ALrajhi_BankAccountIBAN = 'SA8180000260608010001019';
  static const String ALinma_BankAccount = '260000010006080001019';
  static const String ALinma_BankAccountIBAN = 'SA8180000260608010001019';
  // ignore: constant_identifier_names
  static const int technicalSupport_phone = 966920033335;
  // static const String phoneRegExp =
  //     r'(^(5|9665|\5|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$)';

  static const String phoneRegExp = r'(^5\d{8}$)';

  static String privacyLinkEn = 'https://musaneda.com/?page=terms';
  static String privacyLinkAr = 'https://musaneda.com/?page=terms-en';

////////////////////////amazon baseurl//////////////////////////////////////////

  static const sandenyAmazonPay = '/amazon-pay';
  static const sandenyBaseUrl = 'https://develop.sanedny.com/api';

  // ignore: constant_identifier_names
  static const String technicalSupport_Url =
      "https://kdamat.com/Alwatniaco_Webchat.html";
}

class Cards {
  String cardNumber;
  String expiryDate;
  int cvv;
  String type;
  String status;

  Cards({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.type,
    required this.status,
  });

  List<Cards> cards = [
    Cards(
      cardNumber: '4111 1111 1111 1111',
      expiryDate: '05/23',
      cvv: 123,
      type: 'mada',
      status: 'success',
    ),
    Cards(
      cardNumber: '5204 7300 0000 2514',
      expiryDate: '05/23',
      cvv: 251,
      status: 'fail',
      type: 'visa',
    ),
    Cards(
      cardNumber: '5297 4124 8444 2387',
      expiryDate: '10/22',
      cvv: 966,
      type: 'master',
      status: 'success',
    ),
  ];
}
