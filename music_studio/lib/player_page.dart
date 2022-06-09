import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:music_studio/GetMusic.dart';
import 'package:provider/provider.dart';
import 'assets/myIcons.dart';
import 'common/api.dart';
import 'loginPage/login.dart';
import 'mainPages/homePage/editorialSelectionDetail.dart';
import 'model/music_controller.dart';
import 'model/play_list.dart';
import 'utils/screen_size.dart';
import 'utils/song_util.dart';
import 'widgets/RenameDialogContent.dart';
import 'widgets/current_playlist.dart';
import 'widgets/lyric_widget.dart';
import 'widgets/my_icon_button.dart';
import 'widgets/myprogressbar.dart';

class PlayerPage extends StatefulWidget {
  //PlayerPage({Key key}) : super(key: key);
  // 将默认构造函数私有化
  PlayerPage._();

  // 外部跳转统一经过这儿
  static void gotoPlayer(BuildContext context, {List list, int index}) {
    if (list != null) {
      Provider.of<MusicController>(context, listen: false)
          .setPlayList(list, index);
    }
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PlayerPage._();
    }));
  }

  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animController;
  PlayerState playerState = PlayerState.loading;
  TextEditingController _mood = TextEditingController();
  DateTime datetime = DateTime.now();
  Map song;
  String url;
  int duration = 0;
  int position = 0; // 单位：毫秒

  bool isTaping = false; // 是否在手动拖动进度条（拖动的时候播放进度条不要自己动）
  int imageSize;
  String songImage;
  String artistNames;
  LyricPage _lyricPage;
  MusicController musicController;
  MusicListener musicListener;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _animController = AnimationController(
          duration: const Duration(seconds: 24), vsync: this);
      _animController.addStatusListener((status) {
        print("RotationTransition: $status");
      });
      ScreenSize.getScreenSize(context);
      print(ScreenSize.height);
      imageSize = ScreenSize.height ~/ 3;

      print(imageSize);
      if (imageSize == 0) {
        imageSize = 250;
      }

      _lyricPage = LyricPage();

      musicController = Provider.of<MusicController>(context, listen: false);
      initMusicListener();

      musicController.startSong();
      //执行代码写在这里
    });
  }

  _onStartLoading() {
    song = musicController.getCurrentSong();
    // 不要把函数调用放在build之中，不然每次刷新都会调用！！
    songImage = SongUtil.getSongImage(song, size: imageSize);
    artistNames = SongUtil.getArtistNames(song);

    print("StartSong: ${song['name']}, imageSize: $imageSize");

    if (songImage == null || songImage.isEmpty) {
      GetMusic.getSongDetail(song['id'].toString()).then((songDetail) {
        // 异步任务要判断mouted，可能结果返回时界面关闭了。
        if (mounted && songDetail != null) {
          setState(() {
            songImage = SongUtil.getSongImage(songDetail, size: imageSize);
          });
          song['imageUrl'] = SongUtil.getSongImage(songDetail, size: 0);
          print('getSongDetail: $songImage');
        }
      });
    }

    setState(() {
      position = 0;
    });

    _lyricPage.updateSong(song);
  }

  void initMusicListener() {
    musicListener = MusicListener(
        getName: () => "PlayerPage",
        onLoading: () => _onStartLoading(),
        onStart: (duration) {
          setState(() => this.duration = duration);
        },
        onPosition: (position) {
          //print('MusicListener in PlayerPager, position: $position, duration: $duration');
          if (!isTaping) {
            // 如果手指拖动，就不通过播放器更新状态，以免抖动。
            _lyricPage.updatePosition(position);
            setState(() => this.position = position);
          }
        },
        onStateChanged: (state) {
          print('MusicListener onStateChanged: $state ');
          setState(() => this.playerState = state);
        },
        onError: (msg) => _onError(msg));

    musicController.addMusicListener(musicListener);
  }

  void _onError(msg) {
    /* try {
      Map json = jsonDecode(msg);
      if (json['what'] == 1) {
      }
    } catch (e) {
      print('onError: $msg ');
    } */

    setState(() {
      playerState = PlayerState.stopped;
      duration = 0;
      position = 0;
    });
    print("AudioPlayer onError: $msg");

    Fluttertoast.showToast(msg: "歌曲播放失败");
  }

  @override
  void dispose() {
    _animController.dispose();
    musicController.removeMusicListener(musicListener);
    super.dispose();
  }

  // 将要播放和正在播放，用于播放按钮的状态控制。
  // 中途切歌会调用一下stoppted
  bool isGoingPlaying() {
    return playerState != PlayerState.paused;
  }

  Widget _buildTitle() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        song['name'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
      subtitle: Text(
        artistNames,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14.0, color: Colors.white60),
      ),
      trailing: GestureDetector(
          onTap: () => showMySimpleDialog(context),
          onDoubleTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return RenameDialog(
                    contentWidget: RenameDialogContent(
                      title: "请输入心情",
                      okBtnTap: () {
                        print(myid);
                        createFootstep(
                            myid,
                            datetime.toString(),
                            song['id'].toString(),
                            _mood.text,
                            song['name'],
                            artistNames);
                      },
                      vc: _mood,
                      cancelBtnTap: () {},
                    ),
                  );
                });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
      // trailing: Row(children: <Widget>[
      //   IconButton(
      //     icon: Icon(Icons.add, color: Colors.white),
      //     onPressed: () {
      //       showDialog(
      //           barrierDismissible: false,
      //           context: context,
      //           builder: (context) {
      //             return RenameDialog(
      //               contentWidget: RenameDialogContent(
      //                 title: "请输入心情",
      //                 okBtnTap: () {
      //                   print(myid);
      //                   createFootstep(
      //                       myid,
      //                       datetime.toString(),
      //                       song['id'].toString(),
      //                       _mood.text,
      //                       song['name'],
      //                       artistNames);
      //                 },
      //                 vc: _mood,
      //                 cancelBtnTap: () {},
      //               ),
      //             );
      //           });
      //     }),
      //     IconButton(
      //     icon: Icon(Icons.add, color: Colors.white),
      //     onPressed: () {

      //     }),
      // ],
      // ),
      // trailing: IconButton(
      //     icon: Icon(Icons.add, color: Colors.white),
      //     onPressed: () {
      //       showDialog(
      //           barrierDismissible: false,
      //           context: context,
      //           builder: (context) {
      //             return RenameDialog(
      //               contentWidget: RenameDialogContent(
      //                 title: "请输入心情",
      //                 okBtnTap: () {
      //                   print(myid);
      //                   createFootstep(
      //                       myid,
      //                       datetime.toString(),
      //                       song['id'].toString(),
      //                       _mood.text,
      //                       song['name'],
      //                       artistNames);
      //                   // print(datetime);
      //                 },
      //                 vc: _mood,
      //                 cancelBtnTap: () {},
      //               ),
      //             );
      //           });
      //     }),
    );
  }

  Widget _getSongImage(BoxFit fit) {
    return songImage == null || songImage.isEmpty
        ? _getPlaceHolder(fit)
        : CachedNetworkImage(
            width: imageSize.toDouble(),
            height: imageSize.toDouble(),
            imageUrl: songImage,
            fit: fit,
            placeholder: (context, url) => _getPlaceHolder(fit),
          );
  }

  Widget _getPlaceHolder(BoxFit fit) {
    return Image.asset(
      'assets/loginPage/login.jpg',
      width: imageSize.toDouble(),
      height: imageSize.toDouble(),
      fit: fit,
    );
  }

  Widget _buildCDCover() {
    return IgnorePointer(
        child: Container(
            width: imageSize.toDouble() + 24,
            height: imageSize.toDouble() + 24,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 8,
                  color: Colors.black.withOpacity(0.4),
                ),
                shape: BoxShape.circle)));
  }

  Widget _buildProgressIndicator() {
    return playerState == PlayerState.loading
        ? SizedBox(
            width: imageSize.toDouble() + 10.0,
            height: imageSize.toDouble() + 10.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
              strokeWidth: 2.0,
            ))
        : SizedBox(width: 0.0);
  }

  Widget _buildMusicCover() {
    return Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            RotationTransition(
              //设置动画的旋转中心
              alignment: Alignment.center,
              //动画控制器
              turns: _animController,
              //将要执行动画的子view
              child: InkWell(
                  onTap: () => {
                        isGoingPlaying()
                            ? musicController.pause()
                            : musicController.play()
                      },
                  child: Hero(
                    tag: 'FloatingPlayer',
                    //child: ClipOval(child: _getSongImage(BoxFit.cover))
                    // 加边框的效果
                    child: ClipOval(child: _getSongImage(BoxFit.cover)),
                  )),
            ),
            _buildCDCover(), // cd控件会挡住点击事件
            _buildProgressIndicator(),
          ],
        ));
  }

  Widget _buildLyricPage() {
    return Expanded(
      child: _lyricPage, // 歌词
    );
  }

  Widget _buildControllerBar() {
    CycleType cycleType = musicController.playList.cycleType;
    return Container(
        padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyIconButton(
              icons: [
                MyIcons.player_cycle,
                MyIcons.player_single,
                MyIcons.player_random
              ],
              iconIndex: cycleType.index,
              size: 30,
              onPressed: () {
                musicController.playList.changCycleType();
                setState(() {});
              },
            ),
            SizedBox(width: 30.0),
            MyIconButton(
              icon: Icons.skip_previous,
              size: 40,
              onPressed: () {
                musicController.previous();
              },
            ),
            SizedBox(width: 24.0),
            MyIconButton(
              icons: [Icons.pause, Icons.play_arrow],
              iconIndex: isGoingPlaying() ? 0 : 1,
              size: 60.0,
              onPressed: () {
                isGoingPlaying()
                    ? musicController.pause()
                    : musicController.play();
              },
            ),
            SizedBox(width: 24.0),
            MyIconButton(
              icon: Icons.skip_next,
              size: 40,
              onPressed: () {
                musicController.next();
              },
            ),
            SizedBox(width: 30.0),
            MyIconButton(
              icon: MyIcons.player_list,
              size: 30,
              animEnable: false,
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return CurrentPlayList();
                    });
              },
            )
          ],
        ));
  }

  Widget _buildProgressBar() {
    return Container(
        padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
        child: MyProgressBar(
            duration: duration,
            position: position,
            onChanged: (double value) {
              setState(() {
                position = value.toInt();
              });
              _lyricPage.updatePosition(position, isTaping: true);
            },
            onChangeStart: (double value) {
              isTaping = true;
            },
            onChangeEnd: (double value) {
              isTaping = false;
              musicController.seek(value);
            }));
  }

  void _buildAnim() {
    if (playerState == PlayerState.playing) {
      if (!_animController.isAnimating) {
        _animController.forward();
        _animController.repeat();
      }
    } else {
      if (_animController.isAnimating) {
        _animController.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _buildAnim();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(builder: (BuildContext context) {
        return Stack(children: <Widget>[
          // 背景图片
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _getSongImage(BoxFit.fill),
          ),
          // 高斯模糊遮罩层
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: Opacity(
              opacity: 0.6,
              child: new Container(
                decoration: new BoxDecoration(
                  color: Colors.grey.shade900,
                ),
              ),
            ),
          ),

            SafeArea(
              child: Column(
            children: <Widget>[
              _buildTitle(),
              _buildMusicCover(),
              _buildLyricPage(),
              _buildProgressBar(),
              _buildControllerBar(),
            ],
          )),

          /* playerState == PlayerState.loading
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child:
                      SizedBox(height: 2.0, child: LinearProgressIndicator()))
              : Container(), */
        ]);
      }),
    );
  }

  void showMySimpleDialog(BuildContext context) {
    var itemlist = listData
        .map((value) => SimpleDialogOption(
              onPressed: () {
                insertPlayList(myid, value['name'], song['id'].toString());
                print("myid:$myid");
                print(value['name']);
                print(song['id']);
                Navigator.pop(context, value);
              },
              child: Text(value['name']),
            ))
        .toList();
    SimpleDialog dialog = SimpleDialog(
      title: Text("选择想要添加到的歌单"),
      children: itemlist,
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  insertPlayList(String userid, String playlistname, String musicid) async {
    var url = Api.url + '/api/music/';
    try {
      if (playlistname == "默认歌单") playlistname = userid + "default";
      Map<String, dynamic> map = Map();
      map['userid'] = userid;
      map['playlistname'] = playlistname;
      map['musicid'] = musicid;
      var dio = Dio();
      var response = await dio.post(url, data: map);
      print('Response: $response');
      Fluttertoast.showToast(msg: '添加成功!');
    } catch (e) {
      print(e);
      return null;
    }
  }

  createFootstep(String userid, String listentime, String musicid, String mood,
      String musicname, String artistname) async {
    var url = Api.url + '/api/history/';
    try {
      Map<String, dynamic> map = Map();
      map['userid'] = userid;
      map['listentime'] = listentime;
      map['musicid'] = musicid;
      map['perception'] = mood;
      map['musicname'] = musicname;
      map['musicsinger'] = artistname;
      map['musicalbum'] = '七里香';
      var dio = Dio();
      var response = await dio.post(url, data: map);
      print('Response: $response');
      Fluttertoast.showToast(msg: '添加成功!');
    } catch (e) {
      print(e);
      return null;
    }
  }
}
