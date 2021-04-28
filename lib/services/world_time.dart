import 'dart:core';
import 'package:http/http.dart' ;
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime{
  String location; //loc name for ui
  String time;// time int e loc
  String flag;//url to asset flag icon
  String url;
  bool isDaytime;
  WorldTime({this.location,this.flag,this.url});
  Future<void> getTime() async {
    try{
      //make request
      Response response = await get(
          Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get prop from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDaytime= now.hour>6 && now.hour < 20 ? true :false;
      time= DateFormat.jm().format(now);//set time prop
    }
    catch(e){
      print('caught error $e');
      time='could not get time data';
    }
  }
}

