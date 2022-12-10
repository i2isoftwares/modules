import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:i2iutils/helpers/common_functions.dart';
import 'package:optdesk/helpers/colors.dart';
import 'package:optdesk/models/ResponseGetQuestions.dart';
import 'package:optdesk/models/ResponseLogin.dart';
import 'package:optdesk/models/ResponsePandemicQnsAnsDetails.dart';
import 'package:optdesk/screens/covie_links_screen.dart';
import 'package:optdesk/widgets/textfield.dart';

import '../api/network_utils.dart';
import '../helpers/shared_preferences_helper.dart';
import '../helpers/utils.dart';

class CovidScreen extends StatefulWidget {
  final String companyId;

  CovidScreen({required this.companyId});

  @override
  _CovidScreenState createState() => _CovidScreenState();
}

class _CovidScreenState extends State<CovidScreen> {
  PageController controller = PageController();
  TextEditingController textEditingController = TextEditingController();

  // GetQuestions mainQuestions = GetQuestions();
  var mainQuestions;
  List<Option> answer = [];
  late File? file;
  late String selectedCompanyId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getQuestions();
  }

  _getQuestions() async {
    selectedCompanyId = await SharedPreferencesHelper.getPrefString(
        SharedPreferencesHelper.selectedCompany, '');
    GetQuestions response = await getQuestions(widget.companyId, context);
    if (response.status) {
      for (int i = 0; i <= response.returnData.length; i++) {
        // answer.add(Option());
      }

      setState(() {
        mainQuestions = response;
        print(selectedCompanyId);
        if (selectedCompanyId == '132325')
          mainQuestions.returnData.sort((a, b) => b.qnsid.compareTo(a.qnsid));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: Text(
          'Quiz',
          style:
              Theme.of(context).textTheme.bodyText2?.apply(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CovieLinksScreen()));
            },
            icon: const Icon(Icons.info),
            tooltip: "Sources of Information",
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: List<Widget>.generate(
              mainQuestions.returnData != null
                  ? mainQuestions.returnData.length
                  : 0, (index) {
            return _page(mainQuestions.returnData[index], index);
          }),
        ),
      ),
    );
  }

  Widget _page(Question questionData, int index) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Text(
                  questionData.question,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.apply(color: Colors.black)
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const SizedBox(height: 12),
                questionData.options == null
                    ? CustomTextField1(
                        controller: textEditingController,
                        placeholder: 'Remarks',
                      )
                    : Column(
                        children: questionData.options.map((item) {
                          return RadioListTile(
                            groupValue: answer[index],
                            title: Text(
                              item.optiondetail,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.apply(color: Colors.black),
                            ),
                            value: item,
                            activeColor: Colors.blue,
                            contentPadding: EdgeInsets.zero,
                            onChanged: (val) {
                              Option v = val!;
                              setState(() {
                                answer[index] = val;
                                mainQuestions.returnData[index].answer =
                                    v.optionid.toString();
                              });
                            },
                          );
                        }).toList(),
                      ),
                questionData.qnsid == 12 &&
                        mainQuestions.returnData[index].answer != '27' &&
                        mainQuestions.returnData[index].answer != null
                    ? MaterialButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null &&
                              result.files.single.path != null) {
                            File file = File(result.files.single.path!);
                            setState(() {
                              this.file = file;
                            });
                          }
                        },
                        child: Card(
                          child: Container(
                            height: 130,
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Attach Vaccination Certificate',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.apply(color: Colors.black)
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 12),
                                file != null
                                    ? Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Icon(Icons.attach_file),
                                          ),
                                          Expanded(
                                            child: AutoSizeText(
                                              file!.path,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  ?.apply(color: grey)
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal),
                                              maxLines: 2,
                                              minFontSize: 10,
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  file = null;
                                                });
                                              },
                                              icon: const Icon(Icons.cancel))
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Icon(Icons.attach_file),
                                          ),
                                          Text(
                                            'Attach Document',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2
                                                ?.apply(color: grey)
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          questionData.qnsid == 12 &&
                  selectedCompanyId == '132325' &&
                  mainQuestions.returnData[index].answer == '26' &&
                  mainQuestions.returnData[index].answer != null
              ? MaterialButton(
                  onPressed: () => btnSubmitTap(index),
                  child: Text(
                    "Submit",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.apply(color: Colors.black)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                )
              : MaterialButton(
                  onPressed: () {
                    btnNextTap(questionData, index);
                  },
                  child: Text(
                    "Next",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.apply(color: Colors.black)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
        ],
      ),
    );
  }

  void btnNextTap(Question questionData, int index) async {
    if (questionData.options == null) {
      setState(() {
        mainQuestions.returnData[index].answer = textEditingController.text;
        textEditingController.text = '';
      });
    }
    if ((mainQuestions.returnData[index].answer == null) ||
        (mainQuestions.returnData[index].answer?.isEmpty ?? true)) {
      showToastMsg('Please enter the value');
    } else {
      if (index == mainQuestions.returnData.length - 1) {
        // API
        List<Map<String, String>> quiz = [];

        Map<String, dynamic> object = {
          "CUID": "${Utils.userDetail!.userId}",
          "RoleFormid": "${Utils.userDetail!.roleformshowid}",
          "Quiz": []
        };

        for (int i = 0; i < mainQuestions.returnData.length; i++) {
          Map<String, String> detail = {
            "Optionid": "${mainQuestions.returnData[i].answer}",
            "Questionid": "${mainQuestions.returnData[i].qnsid}"
          };
          quiz.add(detail);
        }
        object["Quiz"] = quiz;

        Utils.showLoader(context);
        PandemicQnsAnsDetails? response =
            await postQnsAnsDetailsUpload(object, file!, context);
        if (response == null) return;

        showToastMsg(response.message);

        if (response.status) {
          if (response.data.toString() == "1") {
            SharedPreferencesHelper.setPrefBool(
                SharedPreferencesHelper.IS_LOGIN, false);
            SharedPreferencesHelper.setPrefString(
                SharedPreferencesHelper.LOGIN_RESPONSE, '');
            Utils.responseLogin = null;
            // Utils.userDetail = UserDetail();

            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);

            Utils.showContactAdminDialog(context);
          } else {
            Navigator.of(context).pop();
          }
        }
      } else {
        controller.nextPage(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInCubic);
      }
    }
  }

  void btnSubmitTap(int index) async {
    // API
    List<Map<String, String>> quiz = [];

    Map<String, dynamic> object = {
      "CUID": "${Utils.userDetail!.userId}",
      "RoleFormid": "${Utils.userDetail!.roleformshowid}",
      "Quiz": []
    };

    Map<String, String> detail = {
      "Optionid": "${mainQuestions.returnData[index].answer}",
      "Questionid": "${mainQuestions.returnData[index].qnsid}"
    };
    quiz.add(detail);
    object["Quiz"] = quiz;
    print(object);

    Utils.showLoader(context);
    PandemicQnsAnsDetails? response =
        await postQnsAnsDetailsUpload(object, file!, context);

    if (response == null) return;

    showToastMsg(response.message);

    if (response.status) {
      if (response.data.toString() == "1") {
        SharedPreferencesHelper.setPrefBool(
            SharedPreferencesHelper.IS_LOGIN, false);
        SharedPreferencesHelper.setPrefString(
            SharedPreferencesHelper.LOGIN_RESPONSE, '');
        Utils.responseLogin = null;
        // Utils.userDetail = UserDetail();

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

        Utils.showContactAdminDialog(context);
      } else {
        Navigator.of(context).pushNamed('/calender_screen');
      }
    }
  }
}
