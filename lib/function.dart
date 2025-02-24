import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class ClassificationScreen extends StatefulWidget {
  @override
  _ClassificationScreenState createState() => _ClassificationScreenState();
}

class _ClassificationScreenState extends State<ClassificationScreen> {
  File? _image;
  List<String>? _labels;
  List<dynamic>? _output;
  bool _busy = false;
  Interpreter? _interpreter;

  @override
  void initState() {
    super.initState();
    _busy = true;
    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
      pickImage(); 
    });
  }

  Future loadModel() async {
    try {
      print("Model yükleme başlatıldı...");
      _interpreter = await Interpreter.fromAsset('assets/model.tflite');
      _labels = await loadLabels();
      print("Model başarıyla yüklendi.");
    } catch (e) {
      print("Model yüklenirken hata oluştu: $e");
    }
  }

  Future<List<String>> loadLabels() async {
    final labelData =
        await DefaultAssetBundle.of(context).loadString('assets/labels.txt');
    return labelData.split('\n');
  }

  Future predictImage(File image) async {
    setState(() {
      _busy = true;
    });

    img.Image? originalImage = img.decodeImage(image.readAsBytesSync());
    if (originalImage == null) return;

    img.Image resizedImage =
        img.copyResize(originalImage, width: 224, height: 224);
    var inputData = Float32List(1 * 224 * 224 * 3);
    var pixelIndex = 0;
    for (var i = 0; i < 224; i++) {
      for (var j = 0; j < 224; j++) {
        var pixel = resizedImage.getPixel(j, i);
        inputData[pixelIndex++] = img.getRed(pixel) / 255.0;
        inputData[pixelIndex++] = img.getGreen(pixel) / 255.0;
        inputData[pixelIndex++] = img.getBlue(pixel) / 255.0;
      }
    }

    var reshapedInput = inputData.reshape([1, 224, 224, 3]);
    var output = List.filled(1 * 1, 0.0).reshape([1, 1]);

    _interpreter?.run(reshapedInput, output);

    double dogConfidence = output[0][0];
    double catConfidence = 1 - dogConfidence;
    double confidenceThreshold = 0.9;
    String predictedClass;

    if (dogConfidence > confidenceThreshold) {
      predictedClass =
          "Ben köpeğim (${(dogConfidence * 100).toStringAsFixed(1)}% güven)";
    } else if (catConfidence > confidenceThreshold) {
      predictedClass =
          "Ben Kediyim (${(catConfidence * 100).toStringAsFixed(1)}% güven)";
    } else {
      predictedClass = "Nesne algılanamadı";
    }

    setState(() {
      _image = image;
      _output = [predictedClass];
      _busy = false;
    });
  }

  Future pickImage() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      print("Fotoğraf seçilmedi.");
      Navigator.pop(context); 
      return;
    }
    print("Fotoğraf başarıyla seçildi: ${image.path}");
    predictImage(File(image.path));
  }
@override
Widget build(BuildContext context) {
  return Scaffold(

    appBar:  AppBar(
          backgroundColor: Color(0xFFC2FB09),
          centerTitle: true,
          title: SizedBox(
            width: 261,
            height: 73,
            child: SizedBox(
              width: 261,
              height: 73,
              child: Text(
                'Estimating...',
                style: GoogleFonts.inriaSerif(
                  color: Color(0xFF2C056E),
                  fontSize: 36,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
    body: _busy
        ? Center(child: CircularProgressIndicator())
        : _image == null
            ? Center(child: Text('Fotoğraf çekiliyor...',
            style: GoogleFonts.inriaSerif(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            ))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: Image.file(
                        _image!,
                        height: 300,
                        
                        fit: BoxFit.fill,
                      )),
                  SizedBox(height: 20),
                  Text(
                    _output != null ? _output![0] : "Tahmin ediliyor...",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  if (_output != null && _output!.length > 1)
                    Text(
                      _output![1],
                      style: TextStyle(fontSize: 18),
                    ),
                ],
              ),
              bottomNavigationBar: Padding(padding: EdgeInsets.all(8),
              child: Text('Developed by Emre Mızrak © 2025',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,

              ),
              textAlign: TextAlign.center,
              ),
              ),
  );
}

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }
}
