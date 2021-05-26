import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTaskPageWidget extends StatefulWidget {
  CreateTaskPageWidget({Key key}) : super(key: key);

  @override
  _CreateTaskPageWidgetState createState() => _CreateTaskPageWidgetState();
}

class _CreateTaskPageWidgetState extends State<CreateTaskPageWidget> {
  DateTime datePicked;
  TextEditingController descriptionFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    descriptionFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'New Task',
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final description = descriptionFieldController.text;
              final dueDate = Timestamp.fromDate(datePicked);
              final completed = false;
              final owner = currentUserUid;

              final tasksRecordData = createTasksRecordData(
                description: description,
                dueDate: dueDate,
                completed: completed,
                owner: owner,
              );

              await TasksRecord.collection.doc().set(tasksRecordData);
            },
            icon: Icon(
              Icons.save_alt,
              color: Colors.black,
              size: 30,
            ),
            iconSize: 30,
          )
        ],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextFormField(
                controller: descriptionFieldController,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                await DatePicker.showDatePicker(context, showTitleActions: true,
                    onConfirm: (date) {
                  setState(() => datePicked = date);
                }, currentTime: DateTime.now());
              },
              icon: FaIcon(
                FontAwesomeIcons.calendarAlt,
                color: Colors.black,
                size: 30,
              ),
              iconSize: 30,
            )
          ],
        ),
      ),
    );
  }
}
