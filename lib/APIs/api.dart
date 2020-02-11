import 'package:http/http.dart' as http;
import 'dart:convert';

class CallAPi{
  final String _url = 'https://sessions-timetable.herokuapp.com/api/';


  /////Posting data to db//////
  postData(data, apiUrl) async{
    var fullUrl = _url + apiUrl;
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

  /////Fetching data from db/////
  getData(apiUrl) async{
    var fullUrl = _url + apiUrl;
    return await http.get(
      fullUrl,
      headers: _setHeaders()
    );
  }



  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
}