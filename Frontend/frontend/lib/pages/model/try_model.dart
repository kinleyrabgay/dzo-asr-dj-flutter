// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, prefer_final_fields, avoid_print
import 'package:frontend/pages/components/app_bar.dart';
import 'package:frontend/provider/state.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../api/data.dart';
import 'package:flutter/services.dart';

class TryModel extends StatefulWidget {
  const TryModel({super.key});

  @override
  State<TryModel> createState() => _TryModelState();
}

class _TryModelState extends State<TryModel> {
  bool isLoading = false;
  var _predicted_text_controller = TextEditingController();
  bool showPlayer = false;
  String? audioPath;

  @override
  void initState() {
    super.initState();
    _predicted_text_controller.text = "";
  }

  void transcribeAudio(file) {
    setState(() {
      isLoading = true; // start the spinner
    });
    DataServices.transcribeAudio(file).then(
      (value) => {
        if (value["transcription"].length > 0)
          {
            setState(() {
              _predicted_text_controller.text = value["transcription"];
              isLoading = false; // stop the spinner
            })
          }
      },
    );
  }

  void playAudio() {
    _predicted_text_controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final englishState = Provider.of<EnglishState>(context);
    String _getAppBarText(EnglishState englishState) {
      return englishState.isEnglishSelected
          ? "Discover and enjoy our model's capabilities"
          : 'སྤྱི་བསྟོད་ཀྱི་གཟུགས་ཆོག་འབྲུ་གཡུགས་དང་།';
    }

    return Scaffold(
      appBar: AppbarWidget(text: _getAppBarText(englishState), widget: "Try"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Stack(
                children: [
                  TextField(
                    controller: _predicted_text_controller,
                    // if the controller is null and the model
                    textAlign: TextAlign.left,
                    expands: true,
                    maxLines: null,
                    enabled: false,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    style: const TextStyle(fontSize: 18, height: 2),
                  ),
                  if (isLoading) // conditionally render the spinner
                    Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: const Color(0XFF0F1F41),
                        size: 70.0,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (_predicted_text_controller.text.isNotEmpty) {
                        Clipboard.setData(ClipboardData(
                            text: _predicted_text_controller.text));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copied to clipboard')),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy),
                  ),
                  // Container(
                  //   child: showPlayer
                  //       ? AudioPlayer(
                  //           source: audioPath!,
                  //           onDelete: () {
                  //             setState(
                  //               () => showPlayer = false,
                  //             );
                  //           },
                  //           onSuccess: () {
                  //             setState(
                  //               () => showPlayer = false,
                  //             );
                  //             // Request for another transcript
                  //           },
                  //           currentId: '',
                  //         )
                  //       : Recorder(
                  //           onStop: (path) {
                  //             if (kDebugMode)
                  //               print('Recorded file path: $path');
                  //             setState(
                  //               () {
                  //                 audioPath = path;
                  //                 showPlayer = true;
                  //               },
                  //             );
                  //           },
                  //         ),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.mic,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Record',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      playAudio();
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.audio,
                        allowMultiple: false,
                      );
                      if (result != null) {
                        PlatformFile file = result.files.first;
                        print(file.name);
                        print(file.bytes);
                        print(file.size);
                        print(file.extension);
                        print(file.path);
                        transcribeAudio(file.path);
                      }
                    },
                    icon: const Icon(Icons.upload_file_outlined),
                  ),
                  // if (_predicted_text_controller.text.isNotEmpty)
                  //   AudioPlayerWidget(
                  //     filePath: file.path,
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
