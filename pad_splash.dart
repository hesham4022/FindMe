import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  final inputPath = 'assets/images/splash_logo.png';
  final outputPath = 'assets/images/splash_logo_padded.png';

  final bytes = File(inputPath).readAsBytesSync();
  final originalImage = img.decodeImage(bytes);

  if (originalImage == null) {
    print('Failed to decode image.');
    return;
  }

  // Create a transparent square canvas
  // Android 12 splash screen logo safe area is a circle of diameter 192dp within a 288dp square
  // This means the logo should fit in the central 2/3 of the image
  final maxDim = originalImage.width > originalImage.height ? originalImage.width : originalImage.height;
  // We make the canvas 2x the max dimension to ensure it has plenty of padding
  final canvasSize = (maxDim * 1.8).round();

  final canvas = img.Image(width: canvasSize, height: canvasSize, numChannels: 4);

  // Fill with transparent color
  // img.fill(canvas, color: img.ColorRgba8(0, 0, 0, 0));

  // Draw the original image in the center
  final offsetX = (canvasSize - originalImage.width) ~/ 2;
  final offsetY = (canvasSize - originalImage.height) ~/ 2;

  img.compositeImage(canvas, originalImage, dstX: offsetX, dstY: offsetY);

  File(outputPath).writeAsBytesSync(img.encodePng(canvas));
  print('Successfully padded image and saved to $outputPath');
}
