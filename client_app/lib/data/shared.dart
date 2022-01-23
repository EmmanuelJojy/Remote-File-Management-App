import 'package:client_app/logic/socket_client.dart';

class SharedData {
  static SocketClient? soc;
  static String pool = '';
  static int timeDelay = 500;
  static Map<String, String> file = {
    'name': 'A',
    'attr': '0 Char, 0 Line, 0 B'
  };

  /*static String getFileType() {
    var ext = fileName.split('.').last;
    switch (ext) {
      case 'txt': return 'TEXT';
      
      case 'c': return 'C';
      case 'dart': return 'DART';
      case 'py': return 'PYTHON';
    }
    return '';
  }*/

  static void updateFileAttributes() {
    var index = pool.lastIndexOf('<<\n');
    // hot reload error!
    if (index != -1) {
      file['attr'] = pool.substring(index + 3).toString() + ' B.';
      pool = pool.substring(2, index);
      file['attr'] = (pool.length).toString() +
          ' Char, ' +
          ('\n'.allMatches(pool).length + 1).toString() +
          ' Line, ' +
          file['attr']!;
    }
  }

  static void reUpdateFileAtrributes() {
    file['attr'] = (pool.length).toString() +
        ' Char, ' +
        ('\n'.allMatches(pool).length + 1).toString() +
        ' Line, ';
  }
}
