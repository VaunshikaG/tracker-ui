class URL {
  const URL();

  static const String app_url = 'http://10.0.0.10:8070/expense';

  // static const String app_url = "http://127.0.0.1:8070/tracker";
  // static const String app_url = 'http://192.168.43.56:8070/api/';

  static const String register_url = app_url + '/user/register';
  static const String login_url = app_url + '/user/login';
  static const String category_url = app_url + "/category";
  static const String search_url = app_url + "/category/search";

  static const String user_url = app_url + "/user";
}

class CONST {
  const CONST();

  static const String LoggedIn = "False";
  static const String email = "email";
  static const String pswd = "password";
  static const String token = "token";
  static const String userId = "userId";
  static const String categoryId = "categoryId";
  static const String title = "title";
  static const String desc = "desc";
  static const String amount = "amount";
}
