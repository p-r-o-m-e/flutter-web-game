import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:logging/logging.dart';

class ImageProcessor {
  static final _log = Logger('ImageProcessor');
  static Future<List<Image>> sliceSpritesheetImage(
      Uint8List imageBytes, int cols, int rows) async {
    // {required String imagePath, required int cols, required int rows}) async {

    // Load the image using Flutter's Image widget

    if (cols < 1) cols = 1;
    if (rows < 1) rows = 1;

    late final int pieceWidth;
    late final int pieceHeight;
    List<Image> flutterImageList = [];
    img.Image slice;

    Uint8List uint8List = imageBytes;

    img.Image imgImage = img.decodeImage(uint8List)!;
    // _log.info('img width/height : $imgImage.width, $imgImage.height');
    pieceHeight = imgImage.height ~/ rows;
    pieceWidth = imgImage.width ~/ cols;

    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < cols; col++) {
        int startX = col * pieceWidth;
        int startY = row * pieceHeight;
        slice = img.copyCrop(imgImage,
            x: startX, y: startY, width: pieceWidth, height: pieceHeight);
        Uint8List uint8List = Uint8List.fromList(img.encodePng(slice));
        flutterImageList.add(Image.memory(uint8List));
      }
    }

    return flutterImageList;
  }
}
