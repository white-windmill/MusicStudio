import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'model/Lyric.dart';
import 'utils/file_util.dart';
import 'utils/http_util.dart';


class GetMusic {
  static const URL_ROOT = 'http://music.turingmao.com';
  static const URL_TOP_SONGS = '$URL_ROOT/top/list?idx=';
  static const URL_SONG_DETAIL = '$URL_ROOT/song/detail?ids=';
  static const URL_GET_LYRIC = '$URL_ROOT/lyric?id=';

  static const URL_GET_TOPLIST =
      '$URL_ROOT/toplist/detail'; // 获取排行和摘要，或者/toplist

  static const URL_TOP_ARTISTS = '$URL_ROOT/toplist/artist';
  static const URL_ARTIST_DETAIL = '$URL_ROOT/artists?id=';

    static Future<List> search(String keywords) async {
    var data =
        await HttpUtil.getJsonData('https://pd.musicapp.migu.cn/MIGUM3.0/v1.0/content/search_all.do?&ua=Android_migu&version=5.0.1&text=$keywords&pageNo=1&pageSize=10&searchSwitch={"song":1,"album":0,"singer":0,"tagSong":0,"mvSong":0,"songlist":0,"bestShow":1}', useCache: false);
    List songList = data['songResultData']['result'];
    print(songList);
    return songList;
  }
    // 获取歌词
  static Future<Lyric> getLyric(int songId) async {
    File cache = File(await FileUtil.getLyricLocalPath(songId));
    Map data;
    try {
      bool isCached = cache.existsSync();
      if (isCached) {
        // 歌词缓存过
        String strCached = await cache.readAsString();
        //print('get lyric from cache: $strCached');
        if (strCached.isNotEmpty) {
          data = jsonDecode(strCached);
        } else {
          cache.delete();
        }
      } 
      
      if(data == null) {
        String url = '$URL_GET_LYRIC$songId';
        data = await HttpUtil.getJsonData(url, checkCacheTimeout: false);
      } 
      
      if (data.containsKey('nolyric')) {
        // 无歌词
        return Lyric.empty();
      }
      String str = data['lrc']['lyric'];
      return Lyric(str);
    } catch (e) {
      print('$e');
      return null;
    }
  }
}