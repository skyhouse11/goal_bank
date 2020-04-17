import 'dart:io';

class Message {
  String               _title;
  String               _body;
  Map<String, dynamic> _data;

  get title => _title;
  get body  => _body;
  get data  => _data;

  Message(Map<String, dynamic> message) {
    if (Platform.isAndroid) {
      _title = message['notification']['title'];
      _body =  message['notification']['body'];
      _data =  message['data'];
    } else if (Platform.isIOS) {
      _title = message['aps']['alert']['title'];
      _body =  message['aps']['alert']['body'];
      _data =  _parseDataFromIOSPush(message);
    }
  }

  Map<String, dynamic> _parseDataFromIOSPush(Map<String, dynamic> message) {
    Map<String, dynamic> _parsedMap = {};
    message.forEach((key, value) {
      _parsedMap.putIfAbsent(key, () => value);
    });
    _parsedMap.remove('aps');
    return _parsedMap;
  }
}
