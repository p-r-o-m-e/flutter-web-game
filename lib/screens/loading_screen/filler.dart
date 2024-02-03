// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:io';
import 'dart:isolate';

import 'package:basic/style/my_button.dart';
import 'package:basic/style/palette.dart';
import 'package:basic/utils/image_processor.dart';
import 'package:image/image.dart' as img;
import 'package:basic/utils/volatile_storage.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';

class LoadingSession extends StatefulWidget {
  final bool autoProceed;
  const LoadingSession({super.key, this.autoProceed = false});

  @override
  State<LoadingSession> createState() => _LoadingSessionState();
}

class _LoadingSessionState extends State<LoadingSession> {
  bool _loadingCompleted = false;
  final _log = Logger('Filler');

  @override
  void initState() {
    super.initState();
    _isolateFun();
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
          Visibility(
              visible: !_loadingCompleted,
              child: SpinKitPouringHourGlass(color: palette.ink)),
          SizedBox(
            height: 12,
          ),
          Visibility(visible: !_loadingCompleted, child: Text("\tLoading...")),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start
                      // crossAxisAlignment: ,
                      children: [
                        Text(
                          'As your consciousness slowly awakens, you find yourself enveloped in a cocoon of warmth. Faint murmurs echo around you, and the ethereal sound of hushed voices reaches your ears. The words resonate with a strange familiarity, as if whispered by unseen guardians.\n\n"Ah, \'tis a blessed child! I sense it," one voice utters with reverence, a soft symphony of hope and anticipation.\n\n Another voice chimes in, carrying the weight of prophecy, "Is this the child that will vanquish the evil in this land?"\n\nWith each passing moment, your senses gradually sharpen, and you become aware of a soft illumination that dances through closed eyelids. As you cautiously open your eyes, the warm glow reveals the sacred surroundings of what appears to be a medieval church. Sturdy stone walls adorned with age-old tapestries loom over you, casting shadows that dance in tandem with the flickering candlelight.\n\n A gentle breeze carries the scent of ancient scrolls and sacred incense, creating an atmosphere both mysterious and comforting. You lie nestled in a cradle, swathed in ornate fabrics that seem to cradle you with an otherworldly tenderness. \n\nSurveying the chamber, you catch glimpses of robed figures, their faces obscured by the dim light, murmuring prayers or perhaps incantations. The air is pregnant with a sense of destiny, as if the very walls bear witness to a tale foretold in the annals of time.\n\n As you attempt to make sense of this surreal arrival into existence, the voices persist, weaving a tapestry of your fate. The church, a haven of sanctity, seems to hold secrets that whisper of a journey awaiting you—one that transcends the boundaries of the mundane and beckons you into a fantastical medieval world teeming with magic, mystery, and the promise of heroic destiny',
                          style: TextStyle(fontFamily: 'LTC'),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ]),
                ),
              )
            ],
          )),
          MyButton(onPressed: null, child: Text('Continue'))
        ],
      ),
    );
  }

  static void performLoading(List<dynamic> args) async {
    print('performingLoading');
    SendPort sender1 = args[0] as SendPort;
    final token = args[1] as RootIsolateToken;
    final imgPath = Constants.avatarSpritesheetPath;
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);

    final Uint8List imageBytes = await File(imgPath).readAsBytes();
    final flutterImageList = await ImageProcessor.sliceSpritesheetImage(
        imageBytes,
        Constants.avatarSpriteSheetColRows[0],
        Constants.avatarSpriteSheetColRows[1]);

    sender1.send(flutterImageList);
  }

  void _isolateFun() {
    ReceivePort receiver0 = ReceivePort();
    final token = RootIsolateToken.instance;

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
      if (message is bool && message) {
        _log.info('Isolated process success. setting loadingComplete to true.');
        // receiver0.close();
        setState(() {
          _loadingCompleted = true;
        });
      } else if (message is List<Image>) {
        _log.info('Got imageList. setting loadingComplete to true.');
        setState(() {
          _loadingCompleted = true;
        });
      } else {
        _log.info(
            'INVALID: received a ${message.runtimeType.toString()} from Isolate1');
      }
    });
  }
}
