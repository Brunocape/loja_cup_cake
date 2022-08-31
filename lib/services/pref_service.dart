import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  final String Token = "Token";
  final String Logado = "Logado";
  final String User_id = "User_id";




  SetPreference(String token, bool logado, String user_id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Token, token);
    await prefs.setString(User_id, user_id);
    await prefs.setBool(Logado, logado);
  }

 Future<bool> isLogado() async {
    final prefs = await SharedPreferences.getInstance();
    bool? logado = false;
    logado = await prefs.getBool(Logado);
    return logado ?? false;
  }

  Future<String> GetToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = "";
    token = await prefs.getString(Token);
    return token ?? "";
  }
  Future<String> GetUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? user_id = "";
    user_id = await prefs.getString(User_id);
    return user_id ?? "";
  }

  Future<void> RemovePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Token);
    await prefs.remove(User_id);
    await prefs.remove(Logado);
  }
}
