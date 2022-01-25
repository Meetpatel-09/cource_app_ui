import 'package:course_app_ui/model/course_model.dart';
import 'package:course_app_ui/model/mcq_models/user_settings_request_model.dart';
import 'package:course_app_ui/services/api_service.dart';
import 'package:course_app_ui/utils/routes.dart';
import 'package:course_app_ui/widgets/exam/start_exam_page/start_exam_button.dart';
import 'package:flutter/material.dart';

class StartExamWidget extends StatefulWidget {
  final List<Subject> subjectList;
  final int index;
  final bool wantExamTimer;
  final bool wantQuestionTimer;
  final String examTime;
  final String questionTime;
  final String numQuestions;
  final String token;
  final int mbid;
  final String userMCQID;
  const StartExamWidget({Key? key, required this.subjectList, required this.index, required this.wantExamTimer, required this.wantQuestionTimer, required this.examTime, required this.questionTime, required this.numQuestions, required this.token, required this.mbid, required this.userMCQID}) : super(key: key);

  @override
  _StartExamWidgetState createState() => _StartExamWidgetState();
}

class _StartExamWidgetState extends State<StartExamWidget> {
  bool isLoading = true;
  bool isCorrect = true;

  @override
  void initState() {
    super.initState();

    UserSettingsRequestModel model = UserSettingsRequestModel(
      token: widget.token,
      mbid: widget.mbid,
      setExamTimer: widget.wantExamTimer? "Yes" : "No",
      setPerQueTimer: widget.wantQuestionTimer? "Yes" : "No",
      // queRemainingTime: ,
      // queTotalTakenTime: ,
      mcqStartDatetime: true
    );

    APIServices.putUserSettings(model, widget.userMCQID).then((response) {
      if (response.toString().isNotEmpty) {
        if (response.status == 200) {
          isCorrect = true;
        } else {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text(response.status.toString()),
                content: Text(response.msg.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, MyRoutes.homeRoute);
                      },
                      child: const Text("OK")),
                ],
              )
          );
        }
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return isLoading
        ?
    const Center(child: CircularProgressIndicator(),)
        :
    Container();
  }

  Widget container() {
    return SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: Align(
          child: StartExamButton(
              token: widget.token,
              index: widget.index,
              mbid: widget.mbid,
              subjectList: widget.subjectList,
              wantExamTimer: widget.wantExamTimer,
              examTime: widget.examTime,
              wantQuestionTimer: widget.wantQuestionTimer,
              questionTime: widget.questionTime,
              numQuestions: widget.numQuestions,
              userMCQID: widget.userMCQID
          ),
        )
    );
  }
}
