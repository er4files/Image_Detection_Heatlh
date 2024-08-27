import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:glowifyflutter/screens/result_page.dart';
import 'package:glowifyflutter/widgets/face_area_widget.dart';

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  File? _imageForehead;
  File? _imageCheek;
  File? _imageNose;
  bool _loading = false;
  List<String> _results = [];
  List<String> _confidences = [];

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/face_health_detection/model.tflite",
      labels: "assets/face_health_detection/labels.txt",
    );
    print(res);
  }

  Future<void> _pickImage(String area) async {
    final picker = ImagePicker();
    final pickedFile = await showModalBottomSheet<File?>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Ambil dari Kamera'),
                onTap: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                  Navigator.pop(context, pickedFile != null ? File(pickedFile.path) : null);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Pilih dari Galeri'),
                onTap: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  Navigator.pop(context, pickedFile != null ? File(pickedFile.path) : null);
                },
              ),
            ],
          ),
        );
      },
    );

    if (pickedFile != null) {
      setState(() {
        if (area == "forehead") {
          _imageForehead = pickedFile;
        } else if (area == "cheek") {
          _imageCheek = pickedFile;
        } else if (area == "nose") {
          _imageNose = pickedFile;
        }
      });
    }
  }

  Future<void> classifyImage() async {
    setState(() {
      _loading = true;
    });

    var recognitionsForehead = await Tflite.runModelOnImage(
      path: _imageForehead!.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    var recognitionsCheek = await Tflite.runModelOnImage(
      path: _imageCheek!.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    var recognitionsNose = await Tflite.runModelOnImage(
      path: _imageNose!.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _loading = false;
      _results = [
        recognitionsForehead != null && recognitionsForehead.isNotEmpty
            ? recognitionsForehead[0]["label"]
            : '',
        recognitionsCheek != null && recognitionsCheek.isNotEmpty
            ? recognitionsCheek[0]["label"]
            : '',
        recognitionsNose != null && recognitionsNose.isNotEmpty
            ? recognitionsNose[0]["label"]
            : ''
      ];

      _confidences = [
        recognitionsForehead != null && recognitionsForehead.isNotEmpty
            ? (recognitionsForehead[0]["confidence"] * 100.0).toStringAsFixed(2)
            : '0.0',
        recognitionsCheek != null && recognitionsCheek.isNotEmpty
            ? (recognitionsCheek[0]["confidence"] * 100.0).toStringAsFixed(2)
            : '0.0',
        recognitionsNose != null && recognitionsNose.isNotEmpty
            ? (recognitionsNose[0]["confidence"] * 100.0).toStringAsFixed(2)
            : '0.0'
      ];

      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          results: _results,
          confidences: _confidences,
          imageForehead: _imageForehead,
          imageCheek: _imageCheek,
          imageNose: _imageNose,
        ),
      ),
    );

    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool allImagesSelected = _imageForehead != null && _imageCheek != null && _imageNose != null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Deteksi Kesehatan Wajah'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FaceAreaWidget(
                title: "Area Dahi",
                image: _imageForehead,
                onTap: () => _pickImage("forehead"),
              ),
              SizedBox(height: 16),
              FaceAreaWidget(
                title: "Area Pipi",
                image: _imageCheek,
                onTap: () => _pickImage("cheek"),
              ),
              SizedBox(height: 16),
              FaceAreaWidget(
                title: "Area Hidung",
                image: _imageNose,
                onTap: () => _pickImage("nose"),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: allImagesSelected && !_loading ? classifyImage : null,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFED6672),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  elevation: 4,
                ),
                child: _loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Analisis AI',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
