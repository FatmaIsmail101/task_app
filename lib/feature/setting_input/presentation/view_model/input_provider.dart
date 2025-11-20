import 'package:flutter/cupertino.dart';
import 'package:task_essac/core/cashing/cashing_helper.dart';

class InputProvider extends ChangeNotifier{
  String _url="https://docs.flutter.dev/";
  String get url=>_url;
  void setUrl(String newUrl){
    _url=newUrl;
    notifyListeners();
    _save(newUrl);
  }
   Future<void>_save(String newUrl)async{
    await CacheHelper.setString("save_url", newUrl);
  }
   Future<void>load()async{
     _url=await CacheHelper.getString("save_url")??_url;

    notifyListeners();
  }
}