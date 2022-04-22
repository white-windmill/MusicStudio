import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'model/Lyric.dart';


class GetMusic {
  static const URL_ROOT = 'http://music.turingmao.com';
  static const URL_TOP_SONGS = '$URL_ROOT/top/list?idx=';
  static const URL_SONG_DETAIL = '$URL_ROOT/song/detail?ids=';
  static const URL_GET_LYRIC = '$URL_ROOT/lyric?id=';

  static const URL_SEARCH = '$URL_ROOT/search?keywords=';

  static const URL_GET_TOPLIST =
      '$URL_ROOT/toplist/detail'; // 获取排行和摘要，或者/toplist

  static const URL_TOP_ARTISTS = '$URL_ROOT/toplist/artist';
  static const URL_ARTIST_DETAIL = '$URL_ROOT/artists?id=';

  
}