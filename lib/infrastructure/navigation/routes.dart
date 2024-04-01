// ignore_for_file: constant_identifier_names

class Routes {
  static Future<String> get initialRoute async {
    return DASHBOARD;
  }

  static const DETAIL_NEWS = '/detail-news';
  static const HOME = '/home';
  static const MAIN_PAGES = '/main-pages';
  static const DASHBOARD = '/admin/dashboard';
}
