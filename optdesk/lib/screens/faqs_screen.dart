import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/helpers/constants.dart';
import 'package:optdesk/helpers/utils.dart';
import 'package:optdesk/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQsScreen extends StatefulWidget {
  @override
  _FAQsScreenState createState() => _FAQsScreenState();
}

const _urlFAQ = 'https://ifazility.com/testoptdeskapi/floorplanimages/faq/FrequentlyAskedQuestions.pdf';

class _FAQsScreenState extends State<FAQsScreen> {
  late Map<String, String> dataLocationSetting;
  late Map<String, String> dataUserCan;
  late Map<String, String> dataNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Utils.userDetail!.roleformshowid == 1) {
      this.dataLocationSetting = dataLocationSettingsAdmin;
      this.dataUserCan = dataUsersCanAdmin;
      this.dataNotification = dataNotificationsAdmin;
    } else {
      this.dataLocationSetting = dataLocationSettingsUser;
      this.dataUserCan = dataUsersCanUser;
      this.dataNotification = dataNotificationsUser;
    }
  }

  void _launchURL() async =>
      await canLaunch(_urlFAQ) ? await launch(_urlFAQ) : throw 'Could not launch $_urlFAQ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        centerTitle: false,
        title: Text(
          'FAQs',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.apply(color: primary)
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: _launchURL,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Image.asset(
                'assets/optdesk/download.png',
                color: Colors.white,
                height: 26,
                width: 26,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _header('The Location Settings'),
          _expandableList(this.dataLocationSetting),
          _header('Users Can'),
          _expandableList(this.dataUserCan),
          _header('Notifications'),
          _expandableList(this.dataNotification),
        ],
      ),
    );
  }

  Widget _header(String header) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      height: 45,
      color: grey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AutoSizeText(
          header,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.apply(color: Colors.black)
              .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _expandableList(Map<String, String> data) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text(
            '${data.keys.toList()[index]}',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.apply(color: Colors.black)
                .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              color: lightGrey,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 12, top: 12, bottom: 12),
                child: Text(
                  '${data.values.toList()[index]}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.apply(color: Colors.black)
                      .copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
