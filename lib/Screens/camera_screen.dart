// InputImage? inputImage;
//
// final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//
//
// void openCamera() async {
//   Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (_) => CameraCamera(
//             onFile: (file) {
//               print(file.path);
//               inputImage = InputImage.fromFile(file);
//               Navigator.pop(context);
//               process();
//               setState(() {});
//             },
//           )));
// }
// Future process() async {
//   final RecognizedText recognizedText =
//   await textRecognizer.processImage(inputImage!);
//
//   for (TextBlock block in recognizedText.blocks) {
//     for (TextLine line in block.lines) {
//       // Same getters as TextBlock سطر سطر
//       print('line line ${line.text}');
//       for (TextElement element in line.elements) {
//         // Same getters as TextBlock كلمة كلمة
//         print('element element ${element.text}');
//       }
//     }
//   }
// }