// ignore_for_file: unnecessary_this, avoid_print, no_leading_underscores_for_local_identifiers
import 'dart:convert';

import 'package:frontend/provider/color.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/record/audio_player.dart';
import 'package:frontend/pages/record/audio_recorder.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:frontend/pages/components/app_bar_title.dart';
import '../../api/data.dart';

class Record extends StatefulWidget implements PreferredSizeWidget {
  const Record({Key? key}) : super(key: key);

  @override
  State<Record> createState() => _RecordState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 75);
}

class _RecordState extends State<Record> {
  bool showPlayer = false;
  String? audioPath;
  String currentTranscription = "";

  double progressValue = 0;
  int totalNumberOfValues = 100;

  void checkProgressStatus() {
    SharedPreferences.getInstance().then((prefs) {
      int numberOfClicks = prefs.getInt('progress') ?? 0;
      if (numberOfClicks >= totalNumberOfValues) {
        progressValue = 1.0;
      } else {
        progressValue = numberOfClicks.toDouble() / totalNumberOfValues;
      }
      setState(() {});
    });
  }

  double get percentage => progressValue * 100;

  @override
  void initState() {
    showPlayer = false;
    super.initState();
    getTranscription();
    checkProgressStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String currentTextID = '';

  void getTranscription() {
    DataServices.getTranscription().then(
      (value) => {
        if (!value.isNotEmpty) print("in"),
        {
          if (this.mounted)
            {
              if (value["message"] == "success")
                {
                  print(value["message"]),
                  setState(
                    () {
                      String convertedTranscription = utf8.decode(
                          value['next_transcription']['transcription']
                              .runes
                              .toList());
                      String transcriptionID =
                          value['next_transcription']['id'].toString();
                      print('TRS $transcriptionID');
                      print(convertedTranscription);
                      currentTranscription = convertedTranscription;
                      currentTextID = transcriptionID;
                    },
                  )
                },
            }
        },
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: widget.preferredSize,
        child: AppBar(
          backgroundColor: Provider.of<ColorModel>(context).selectedColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
            ),
          ),
          title: const AppBarTitle(),
          bottom: PreferredSize(
            preferredSize: widget.preferredSize,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                      color: const Color.fromARGB(255, 80, 79, 79)
                          .withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 3, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.70, // Set the width as desired
                            height: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                value: progressValue,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.orange),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 48,
                            width: 48,
                            child: SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                  minimum: 0,
                                  maximum: 100,
                                  showLabels: false,
                                  showTicks: false,
                                  startAngle: 270,
                                  endAngle: 270,
                                  radiusFactor: 0.8,
                                  axisLineStyle: AxisLineStyle(
                                    thickness: 0.05,
                                    color: Colors.white.withOpacity(0.4),
                                    thicknessUnit: GaugeSizeUnit.factor,
                                  ),
                                  pointers: <GaugePointer>[
                                    RangePointer(
                                        value: percentage,
                                        width: 0.15,
                                        sizeUnit: GaugeSizeUnit.factor,
                                        enableAnimation: true,
                                        animationDuration: 100,
                                        animationType: AnimationType.linear)
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      positionFactor: 0,
                                      widget: Text(
                                        '${percentage.toStringAsFixed(0)}%',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFF5ACFC9),
                        width: 0.5,
                      ),
                      right: BorderSide(
                        color: Color(0xFF5ACFC9),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Text(
                      currentTranscription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              child: showPlayer
                  ? AudioPlayer(
                      source: audioPath!,
                      onDelete: () {
                        setState(
                          () => showPlayer = false,
                        );
                      },
                      currentId: currentTextID,
                      onSuccess: () {
                        setState(
                          () => showPlayer = false,
                        );
                        // Request for another transcript
                        getTranscription();
                        checkProgressStatus();
                      },
                    )
                  : Recorder(
                      onStop: (path) {
                        if (kDebugMode) print('Recorded file path: $path');
                        setState(
                          () {
                            audioPath = path;
                            showPlayer = true;
                          },
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
