import 'package:basic/utils/math.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class ImageProcessor {
  static List<Uint8List> sliceSpritesheetImage(
      Uint8List imageBytes, int cols, int rows,
      {double borderOffsetPercentage = 0.0}) {
    // Load the image using Flutter's Image widget

    if (cols < 1) cols = 1;
    if (rows < 1) rows = 1;

    late final int pieceWidth;
    late final int pieceHeight;
    List<Uint8List> imagesBytedata = [];
    img.Image slice;

    Uint8List uint8List = imageBytes;

    img.Image imgImage = img.decodeImage(uint8List)!;

    //if there is some offset at the border of spritesheet, then remove it
    if (borderOffsetPercentage > 0) {
      imgImage = img.copyCrop(imgImage,
          x: imgImage.width -
              (CustomMathUtils.getPercentageVal(
                      imgImage.width, 100 - borderOffsetPercentage)
                  .toInt()),
          y: imgImage.height -
              (CustomMathUtils.getPercentageVal(
                      imgImage.height, 100 - borderOffsetPercentage)
                  .toInt()),
          width: CustomMathUtils.getPercentageVal(
                  imgImage.width, 100 - (borderOffsetPercentage * 2))
              .toInt(),
          height: CustomMathUtils.getPercentageVal(
                  imgImage.height, 100 - (borderOffsetPercentage * 2))
              .toInt());
    }

    pieceHeight = imgImage.height ~/ rows;
    pieceWidth = imgImage.width ~/ cols;

    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < cols; col++) {
        int startX = col * pieceWidth;
        int startY = row * pieceHeight;
        slice = img.copyCrop(imgImage,
            x: startX, y: startY, width: pieceWidth, height: pieceHeight);
        uint8List = Uint8List.fromList(img.encodePng(slice));
        imagesBytedata.add(uint8List);
      }
    }

    return imagesBytedata;
  }
}
