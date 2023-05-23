// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:frontend/pages/components/app_bar_title.dart';
import 'package:frontend/pages/rulebook/rule_book.dart';
import 'package:frontend/provider/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final String widget;

  const AppbarWidget({Key? key, required this.text, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return PreferredSize(
      key: _scaffoldKey,
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).size.height * 0.15,
      ),
      child: AppBar(
        // backgroundColor: const Color(0XFF0F1F41),
        backgroundColor: Provider.of<ColorModel>(context).selectedColor,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
          ),
        ),
        title: const AppBarTitle(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    color:
                        const Color.fromARGB(255, 80, 79, 79).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                        Container(
                          width: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(255, 80, 79, 79)
                                  .withOpacity(0.5)),
                          child: widget == "Rule"
                              ? IconButton(
                                  iconSize: 20,
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.rule,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                )
                              : widget == "About"
                                  ? IconButton(
                                      iconSize: 20,
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                        Icons.person_2_rounded,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {},
                                    )
                                  : widget == "Prize"
                                      ? IconButton(
                                          iconSize: 20,
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(
                                            Icons.rule,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const RulebookScreen(),
                                              ),
                                            );
                                          },
                                        )
                                      : widget == "Help"
                                          ? IconButton(
                                              iconSize: 20,
                                              padding: EdgeInsets.zero,
                                              icon: const Icon(
                                                Icons.mail_outline,
                                                color: Colors.white,
                                              ),
                                              onPressed: () async {
                                                String email =
                                                    Uri.encodeComponent(
                                                        "fsd.rabgay@gmail.com");
                                                Uri mail =
                                                    Uri.parse("mailto:$email?");
                                                if (await launchUrl(mail)) {
                                                  //email app opened
                                                } else {
                                                  //email app is not opened
                                                }
                                              },
                                            )
                                          : widget == "Try"
                                              ? IconButton(
                                                  iconSize: 20,
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(
                                                    Icons.try_sms_star_sharp,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () async {},
                                                )
                                              : widget == "Color"
                                                  ? IconButton(
                                                      iconSize: 20,
                                                      padding: EdgeInsets.zero,
                                                      icon: const Icon(
                                                        Icons.colorize,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () async {},
                                                    )
                                                  : null,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 75);
}
