// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:io';
import 'dart:isolate';

import 'package:basic/style/my_button.dart';
import 'package:basic/style/palette.dart';
import 'package:basic/utils/image_processor.dart';
import 'package:basic/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class InitLoadingSession extends StatefulWidget {
  const InitLoadingSession({super.key});

  @override
  State<InitLoadingSession> createState() => _InitLoadingSessionState();
}

class _InitLoadingSessionState extends State<InitLoadingSession> {
  bool _loadingCompleted = true;
  final _log = Logger('InitLoader');
  late final String scrollText;

  @override
  void initState() {
    super.initState();

    scrollText =
        'As your consciousness slowly awakens, you find yourself enveloped in a cocoon of warmth. Faint murmurs echo around you, and the ethereal sound of hushed voices reaches your ears. The words resonate with a strange familiarity, as if whispered by unseen guardians.\n\n"Ah, \'tis a blessed child! I sense it," one voice utters with reverence, a soft symphony of hope and anticipation.\n\n Another voice chimes in, carrying the weight of prophecy, "Is this the child that will vanquish the evil in this land?"\n\nWith each passing moment, your senses gradually sharpen, and you become aware of a soft illumination that dances through closed eyelids. As you cautiously open your eyes, the warm glow reveals the sacred surroundings of what appears to be a medieval church. Sturdy stone walls adorned with age-old tapestries loom over you, casting shadows that dance in tandem with the flickering candlelight.\n\n A gentle breeze carries the scent of ancient scrolls and sacred incense, creating an atmosphere both mysterious and comforting. You lie nestled in a cradle, swathed in ornate fabrics that seem to cradle you with an otherworldly tenderness. \n\nSurveying the chamber, you catch glimpses of robed figures, their faces obscured by the dim light, murmuring prayers or perhaps incantations. The air is pregnant with a sense of destiny, as if the very walls bear witness to a tale foretold in the annals of time.\n\n As you attempt to make sense of this surreal arrival into existence, the voices persist, weaving a tapestry of your fate. The church, a haven of sanctity, seems to hold secrets that whisper of a journey awaiting you—one that transcends the boundaries of the mundane and beckons you into a fantastical medieval world teeming with magic, mystery, and the promise of heroic destiny';

    //Comenting out this and not creating any Isolates for now
    // _isolateFun();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundSettings,
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 54,
            child: Visibility(
              visible: !_loadingCompleted,
              child: SpinKitPouringHourGlass(
                color: palette.ink,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            _loadingCompleted ? "Press 'Continue' to proceed" : "\tLoading...",
            style: TextStyle(fontFamily: 'Chelsea'),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            flex: 20,
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    // width: 500,
                    // height: 900,
                    child: SingleChildScrollView(
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start
                          // crossAxisAlignment: ,
                          children: [
                            Text(
                              scrollText,
                              // overflow: TextOverflow,
                              // softWrap: true,
                              style: TextStyle(fontFamily: 'LTC'),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ]),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          MyButton(
              onPressed: _loadingCompleted
                  ? () {
                      GoRouter.of(context).go('/play');
                    }
                  : null,
              child: Text('Continue')),
          Expanded(
            child: SizedBox(
              height: 12,
            ),
          )
        ],
      ),
    );
  }

  static void performLoading(List<dynamic> args) async {
    ReceivePort receiver1 = ReceivePort();

    SendPort sender0 = args[0] as SendPort;
    final token = args[1] as RootIsolateToken;
    final imgPath = Constants.avatarSpritesheetPath;
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);

    // await Future.delayed(Duration(seconds: 2));

    final Uint8List imageBytes = await File(imgPath).readAsBytes();
    final flutterImageList = ImageProcessor.sliceSpritesheetImage(
        imageBytes,
        Constants.avatarSpriteSheetColRows[0],
        Constants.avatarSpriteSheetColRows[1],
        borderOffsetPercentage: Constants.avatarSpritesheetOffsetPercentage);

    sender0.send(receiver1.sendPort);

    //proceed to wait for further communication
    receiver1.listen((message) async {
      if (message == 'ACK') {
        sender0.send(flutterImageList);
      } else if (message is Map<String, dynamic> &&
          message.containsKey('functionName')) {
        final List<dynamic> args = message['args'] as List<dynamic>;
        switch (message['functionName']) {
          case 'bytesToFile':
            await File(args[1] as String).writeAsBytes(args[0] as Uint8List);
            sender0.send(false);
            break;
          default:
            throw ArgumentError("Unknown Function");
        }
      } else if (message == false) {
        //acknowledge shutting down isolates
        receiver1.close();
      }
    });
  }

  void bytesToFile() async {}

  void _isolateFun() {
    ReceivePort receiver0 = ReceivePort();
    late SendPort sender1;

    final token = RootIsolateToken.instance;
    // bool shutdownFlag = false;

    // final imgg = Image.asset("name");
    // ByteData b = imgg.to
    // BackgroundIsolateBinaryMessenger.ensureInitialized(token!);
    // WidgetsFlutterBinding.ensureInitialized();

    Isolate.spawn(performLoading, [
      receiver0.sendPort,
      token,
    ]);
    _log.info('isolate spawned');

    receiver0.listen((message) {
      _log.info('received ${message.runtimeType.toString()}');
      if (message is SendPort) {
        sender1 = message;

        sender1.send('ACK');
      } else if (message is bool && message == false) {
        setState(() {
          _loadingCompleted = true;

          //shutting down isolates
          _log.info('closing isolates now.');
          sender1.send(false);
          receiver0.close();
        });
      }
      // else if (message is List<Uint8List>) {
      //   for (Uint8List element in message) {
      //     VolatileStorage.addtoImageBytesDict(
      //         'aSs${message.indexOf(element)}', element);
      //   }
      // sender1.send({
      //   'functionName': 'bytesToFile',
      //   'args': [
      //     VolatileStorage.getFromImageBytesDict(
      //         VolatileStorage.getCurrentAvatarKey()),
      //     Constants.avatarWritePath
      //   ]
      // });
      // _log.info(
      // 'Got avtarSheet imageList and updated VolatileStorage. Setting loadingComplete to true.');
      // }
      else {
        throw ArgumentError(
            "Wrong message of type - ${message.runtimeType.toString()} received by receiver0.");
      }
    }, onError: (err) {
      _log.info('receiver error ${err.toString()}: closing');
      receiver0.close();
    }, onDone: () {
      receiver0.close();
    });
  }
}
