import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class CovieLinksScreen extends StatefulWidget {
  @override
  _CovieLinksScreenState createState() => _CovieLinksScreenState();
}

class _CovieLinksScreenState extends State<CovieLinksScreen> {
  String text = """
Please find below the links to sources of information used as a guideline to create the form

return to work guidelines:
https://www.cdc.gov/coronavirus/2019-ncov/community/general-business-faq.html

WHO:
https://www.who.int/news-room/q-a-detail/coronavirus-disease-covid-19-health-and-safety-in-the-workplace

Direct link to a document WHO
https://cdn.who.int/media/docs/default-source/coronaviruse/risk-comms-updates/returning-to-work-29-05-2020.pdf?sfvrsn=da0a37fb_4&download=true

this is the site that clearly talks about Pre-return to work form The HSE (Health Service Executive) provides all of Ireland's public health services in hospitals and communities across the country.
https://www2.hse.ie/conditions/coronavirus/returning-to-work-safely.html

page 9: ILO (International Labour Organization)
https://www.ilo.org/wcmsp5/groups/public/---ed_dialogue/---act_emp/documents/publication/wcms_744033.pdf

Page3: point 4. Specific preventive measures for offices:
https://dopt.gov.in/sites/default/files/COVID_Attendance.PDF

page2: 4.Specific preventive measures foroffices
https://www.mohfw.gov.in/pdf/SOPonpreventivemeasurestocontainspreadofCOVID19inoffices.pdf""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: Text(
          'Resources',
          style:
              Theme.of(context).textTheme.bodyText2?.apply(color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        child: ListView(
          children: [
            Linkify(
              onOpen: (link) async {
                if (await canLaunch(link.url)) {
                  await launch(link.url);
                } else {
                  throw 'Could not launch $link';
                }
              },
              text: text,
              options: const LinkifyOptions(humanize: false),
            ),
//            Text(
//              text,
//              style: Theme.of(context)
//                  .textTheme
//                  .bodyText1
//                  ?.apply(color: Colors.black)
//                  .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
//            )
          ],
        ),
      ),
    );
  }
}
