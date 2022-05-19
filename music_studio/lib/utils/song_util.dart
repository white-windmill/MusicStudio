
import 'file_util.dart';

class SongUtil {
  static String getArtistNames(Map song) {
    if (song.containsKey('artistNames')) {
      return song['artistNames'];
    }

    String names = '';
    List arList;

    if (song.containsKey('ar')) {
      arList = song['ar'];
    } else if (song.containsKey('artists')) {
      arList = song['artists'];
    } else {
      arList = song['song']['artists'];
    }

    if (arList != null) {
      bool isFirst = true;
      arList.forEach((ar) {
        if (isFirst) {
          isFirst = false;
          names = ar['name'];
        } else {
          names += " " + ar['name'];
        }
      });
    }
    
    // 取了之后存下来，不用重复取了。
    song['artistNames'] = names;

    // 测试，不要在build里面调用相同的函数，会频繁执行。
    //print("getAritistNames: $names");
    return names;
  }

  static String getSongImage(Map song, {int size:100, int width:0, int height:0}) {
    String imgUrl;
    if (song.containsKey('imageUrl')) {
      imgUrl = song['imageUrl'];
    } else {
      try {
        if (song.containsKey('al')) {
          imgUrl = song['al']['picUrl'];
        } else if (song.containsKey('song')) {// URL_NEW_SONGS里面的数据结构
          imgUrl = song['song']['album']['picUrl'];
        }
        if (imgUrl != null) {
          song['imageUrl'] = imgUrl;  // 取一次之后存下来，不用后面计算。
        }
      } catch(e) {
        print(e);
        print(song['name']);
        return '';
      } 
    }

    if (imgUrl == null || imgUrl.length == 0) {
      return '';
    }
    if (width > 0 && height > 0) {
      imgUrl += '?param=${width}y$height';
    } else if (size > 0) {
      imgUrl += '?param=${size}y$size';
    }

    //print('imageUrl: $imgUrl');
    return imgUrl;
  }


  static String getSongUrl(Map song) {
    return "https://music.163.com/song/media/outer/url?id=${song['id']}.mp3";
  }


  static Future<String> getPlayPath(Map song) async{
    String localPath = await FileUtil.getSongLocalPath(song['id']);
    if (await FileUtil.isFileExists(localPath)) {
      return localPath;
    } else {
      return getSongUrl(song);
    }
  }

  
  // static Future<bool> isSongDownloaded(int id) async{
  //   String localPath = await FileUtil.getSongLocalPath(id);
  //   return FileUtil.isFileExists(localPath);
  // }


  static String getArtistImage(Map artist, {int size:100, int width:0, int height:0}) {
    String imgUrl = artist['picUrl'];
    if (width > 0 && height > 0) {
      imgUrl += '?param=${width}y$height';
    } else if (size > 0) {
      imgUrl += '?param=${size}y$size';
    }
    return imgUrl;
  }

}