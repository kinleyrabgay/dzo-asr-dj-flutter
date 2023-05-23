// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print, unused_local_variable, unused_element
import 'package:frontend/pages/components/app_bar.dart';
import 'package:frontend/provider/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RulebookScreen extends StatelessWidget {
  const RulebookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final englishState = Provider.of<EnglishState>(context);
    String _getAppBarText(EnglishState englishState) {
      return englishState.isEnglishSelected
          ? 'Impartial app record winner chosen fairly.'
          : 'ཕྱོགས་རིས་མེད་པ་རྒྱལ་ཁ་ཐོབ་མི་འདི་གདམ་ཁ་རྐྱབ།';
    }

    return Scaffold(
      appBar: AppbarWidget(
        text: _getAppBarText(englishState),
        widget: "Rule",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RuleContainer(
                number: englishState.isEnglishSelected ? '1' : '༡',
                text: englishState.isEnglishSelected
                    ? 'Participants must record their speech for at least one month.'
                    : 'བཅའ་མར་གཏོགས་མི་ཚུ་གིས་ ཁོང་རའི་གསུང་བཤད་འདི་ཟླཝ་གཅིག་དེ་ཅིག་གི་རིང་ལུ་ཐོ་ཡིག་ནང་བཙུགས་དགོ།',
              ),
              const SizedBox(height: 15.0),
              RuleContainer(
                // backgroundColor: Color.fromARGB(255, 250, 249, 249),
                number: englishState.isEnglishSelected ? '2' : '༢',
                text: englishState.isEnglishSelected
                    ? 'The correctness of their recordings will be checked against a provided text to ensure that they have been recorded accurately.'
                    : 'ཁོང་གི་གློག་བརྙན་ཚུ ་བདེན་ཡོདཔ་ཨིན་ན་བརྟན་བརྟན་བཟོ་ནིའི་དོན་ལུ་ཚུ་བཀོད་ཡོད་པའི་ཡི་གུ་དང་ཕྱདཔ་ད་ བརྟག་དཔྱད་འབད་འོང་།',
              ),
              const SizedBox(height: 15.0),
              RuleContainer(
                // backgroundColor: Color.fromARGB(255, 250, 249, 249),
                number: englishState.isEnglishSelected ? '3' : '༣',
                text: englishState.isEnglishSelected
                    ? 'The top three participants who have recorded the most within the month with the highest accuracy scores will be chosen as winners.'
                    : 'ཟླཝ་ནང་འཁོད་ལུ་ ངེས་བདེན་གྱི་རྟགས་ཚད་མཐོ་ཤོས་ཡོད་པའི་ནང་ གྲལ་གསུམ་དྲག་ཤོས་འདི་རྒྱལ་འཛིན་སྦེ་གདམ་ཁ་རྐྱབ་འོང་།',
              ),
              const SizedBox(height: 15.0),
              RuleContainer(
                // backgroundColor: Color.fromARGB(255, 250, 249, 249),
                number: englishState.isEnglishSelected ? '4' : '༤',
                text: englishState.isEnglishSelected
                    ? 'Each winner will be awarded a prize every month.'
                    : 'ང་བཅས་སྐྱི་ཁ་ཐུགས་ལས་ རྒྱལ་ཁ་ཐོབ་མི་ག་ར་ལུ་ཟླཝ་ཨ་རྟག་ར་གསོལ་རས་བྱིན་འོང་།',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RuleContainer extends StatelessWidget {
  final String number;
  final String text;

  const RuleContainer({
    Key? key,
    required this.number,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 4.0,
            offset: const Offset(2.0, 2.0),
          ),
        ],
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0F1F41),
            Color.fromARGB(255, 47, 82, 133),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '# $number',
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
