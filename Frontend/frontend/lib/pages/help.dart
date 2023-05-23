// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_field
import 'package:frontend/pages/components/app_bar.dart';
import 'package:frontend/provider/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    final englishState = Provider.of<EnglishState>(context);
    String _getAppBarText(EnglishState englishState) {
      return englishState.isEnglishSelected
          ? 'Contact and meet app devlopers instantly'
          : 'སྤྱི་བསྟོད་ཀྱི་གཟུགས་ཆོག་འབྲུ་གཡུགས་དང་།';
    }

    return Scaffold(
      appBar: AppbarWidget(
        text: _getAppBarText(englishState),
        widget: "Help",
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Walk-through
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 520,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[300]!),
                        image: const DecorationImage(
                          image: AssetImage('assets/img/getting.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 520,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[300]!),
                        image: const DecorationImage(
                          image: AssetImage('assets/img/dashboard.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 520,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[300]!),
                        image: const DecorationImage(
                          image: AssetImage('assets/img/record.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 520,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[300]!),
                        image: const DecorationImage(
                          image: AssetImage('assets/img/prize.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 520,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[300]!),
                        image: const DecorationImage(
                          image: AssetImage('assets/img/dashboard.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    // Permission
                    const SizedBox(width: 30),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 520,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[300]!),
                        image: const DecorationImage(
                          image: AssetImage('assets/img/permission.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "FAQ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 450),
                child: ListView(
                  children: const [
                    FAQItem(
                      question: 'What is Automatic Speech Recognition?',
                      answer:
                          'It is the technology that allows machines to recognize and transcribe human speech into text or commands. It uses machine learning algorithms and acoustic models to convert audio signals into written text.',
                    ),
                    FAQItem(
                      question: 'What are some common application of ASR?',
                      answer:
                          'ASR has a wide range of applications, including voice assistants, transcription services, language learning, and call center automation. It is also used in medical field for transcribing patient notes and in the legal field for transcribing court proceedings.',
                    ),
                    FAQItem(
                      question: 'How can ASR technology be improved?',
                      answer:
                          'ASR technology can be improved by using more advanced machine learning algorithms, incorporating more training data from diverse speakers and accents, and integrating contextual information to help disambiguate speech. Additionally, improving the quality of the audio input can also help improve the accuracy of ASR systems.',
                    ),
                    FAQItem(
                      question: 'What are some limitations of ASR?',
                      answer:
                          'ASR technology may have difficulty recognizing speech in noisy environments or with heavy accents or dialects. It may also struggle with recognizing speech that is spoken quickly or with unusual intonation patterns. Additionally, ASR systems may not always accurately capture the intended meaning or context of the speech.',
                    ),
                    FAQItem(
                      question:
                          'Can ASR technology recognize different accent and language?',
                      answer:
                          'Yes, ASR technology can recognize different accents and languages, but the accuracy may vary depending on the complexity of the language and the quality of the audio input. ASR systems may also require additional training data to recognize specific accents or dialects.',
                    ),
                    FAQItem(
                      question: 'What is the role of language models in ASR?',
                      answer:
                          'Language models are used to predict the probability of a sequence of words given a particular context. They are typically constructed from large corpora of text data and are used to constrain the set of possible transcriptions for a given audio signal. Language models help ASR systems disambiguate between words that sound similar and improve the overall accuracy of the transcription.',
                    ),
                    FAQItem(
                      question: 'What is the role of acoustic models in ASR?',
                      answer:
                          'Acoustic models are a key component of ASR technology and are used to model the relationship between speech signals and the corresponding phonemes in a language. They are trained using large datasets of audio recordings and transcriptions to learn the statistical patterns of speech. These models help ASR systems recognize and transcribe speech accurately, even in noisy or challenging environments.',
                    ),
                    FAQItem(
                      question:
                          'How can ASR technology be integrated with other applications?',
                      answer:
                          'ASR technology can be integrated with other applications through APIs or SDKs provided by ASR service providers. These tools allow developers to incorporate speech recognition capabilities into their own applications and services. ASR technology can also be integrated with other natural language processing tools, such as sentiment analysis or entity recognition, to provide more advanced language understanding capabilities.',
                    ),
                  ],
                ),
              )
            ],
            // FAQ
          ),
        ),
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  State<FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isOpen = !_isOpen;
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.question,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                Icon(
                  _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                  size: 28.0,
                )
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                widget.answer,
                style: const TextStyle(fontSize: 15.0, color: Colors.black54),
                // textAlign: TextAlign.justify,
              ),
            ),
            duration: const Duration(milliseconds: 300),
            crossFadeState:
                _isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
          const SizedBox(height: 16.0),
          const Divider(height: 1.0),
        ],
      ),
    );
  }
}
