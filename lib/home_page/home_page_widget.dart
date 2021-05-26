import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../create_task_page/create_task_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../log_in_screen/log_in_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Task List',
          style: FlutterFlowTheme.title1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateTaskPageWidget(),
                ),
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            ),
            iconSize: 30,
          )
        ],
        centerTitle: true,
        elevation: 4,
      ),
      drawer: Drawer(
        elevation: 16,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () async {
                await signOut();
                await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInScreenWidget(),
                  ),
                  (r) => false,
                );
              },
              child: ListTile(
                title: Text(
                  'Log Out',
                  style: FlutterFlowTheme.title3.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                subtitle: Text(
                  currentUserEmail,
                  style: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                trailing: Icon(
                  Icons.logout,
                  color: Color(0xFF303030),
                  size: 20,
                ),
                tileColor: Color(0xFFF5F5F5),
                dense: false,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<List<TasksRecord>>(
          stream: queryTasksRecord(),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            List<TasksRecord> listViewTasksRecordList = snapshot.data;
            // Customize what your widget looks like with no query results.
            if (snapshot.data.isEmpty) {
              // return Container();
              // For now, we'll just include some dummy data.
              listViewTasksRecordList = createDummyTasksRecord(count: 4);
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: listViewTasksRecordList.length,
              itemBuilder: (context, listViewIndex) {
                final listViewTasksRecord =
                    listViewTasksRecordList[listViewIndex];
                return ListTile(
                  title: Text(
                    listViewTasksRecord.description,
                    style: FlutterFlowTheme.title3.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  subtitle: Text(
                    listViewTasksRecord.dueDate.toString(),
                    style: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF303030),
                    size: 20,
                  ),
                  tileColor: Color(0xFFF5F5F5),
                  dense: false,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
