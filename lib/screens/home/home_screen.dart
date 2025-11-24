// ignore_for_file: use_build_context_synchronously

import 'package:aandm/backend/service/backend_service.dart';
import 'package:aandm/backend/service/cat_backend_service.dart';
import 'package:aandm/models/cat/cat_facts_api_model.dart';
import 'package:aandm/models/cat/cat_picture_api_model.dart';
import 'package:aandm/models/note/note_api_model.dart';
import 'package:aandm/models/tasklist/task_list_api_model.dart';
import 'package:aandm/screens/home/main_app_screen.dart';
import 'package:aandm/util/helpers.dart';
import 'package:aandm/widgets/activity_preview_widget.dart';
import 'package:aandm/widgets/app_drawer_widget.dart';
import 'package:aandm/widgets/cat_facts_widget.dart';
import 'package:aandm/widgets/navigation/bottom_menu.dart';
import 'package:aandm/widgets/notes_preview_widget.dart';
import 'package:aandm/widgets/option_button.dart';
import 'package:aandm/widgets/timer_preview_widget.dart';
import 'package:aandm/widgets/to_do_list_widget.dart';
import 'package:blvckleg_dart_core/exception/session_expired.dart';
import 'package:blvckleg_dart_core/service/auth_backend_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CatFactsApiModel> catFacts = [];
  List<CatPictureApiModel> catPictures = [];
  List<TaskList> _taskLists = [];
  List<Note> _notes = [];

  bool isLoading = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _getCatData() async {
    final backend = Provider.of<CatBackend>(context, listen: false);
    try {
      final pictures = await backend.getCatPictures();
      setState(() {
        catPictures = pictures;
      });
    } catch (e) {
      rethrow;
    }
    try {
      final facts = await backend.getCatFacts();
      setState(() {
        catFacts = facts;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _getTaskLists() async {
    try {
      final backend = Backend();
      final res = await backend.getAllTaskLists();
      final own = res
          .where((element) =>
              element.user!.username ==
              AuthBackend().loggedInUser?.user?.username)
          .toList();
      _taskLists = own;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _getNotes() async {
    try {
      final backend = Backend();
      final res = await backend.getAllNotes();
      final own = res
          .where((element) =>
              element.user!.username ==
              AuthBackend().loggedInUser?.user?.username)
          .toList();
      _notes = own;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        isLoading = true;
      });
      await Future.wait([_getTaskLists(), _getNotes(), _getCatData()]);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e is SessionExpiredException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bitte melde dich erneut an.')),
        );

        await deleteBoxAndNavigateToLogin(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: const BottomMenu(),
        appBar: AppBar(
          title: Text("Home",
              style: Theme.of(context).primaryTextTheme.titleMedium),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: false,
          actions: [
            OptionButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            )
          ],
        ),
        endDrawer: AppDrawer(),
        body: RefreshIndicator(
            color: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            onRefresh: () {
              return _loadData();
            },
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      AuthBackend().loggedInUser?.user?.username != null
                          ? "Willkommen zurück, ${AuthBackend().loggedInUser?.user?.username}!"
                          : "Willkommen zurück!",
                      style: Theme.of(context).primaryTextTheme.titleMedium),
                  const SizedBox(height: 24),
                  TimerPreviewWidget(
                    themeMode: MainAppScreen.of(context)!.currentTheme!,
                    onPressed: () {
                      navigateToRoute(context, 'timer');
                    },
                  ),
                  const SizedBox(height: 16),
                  TodoPreviewWidget(
                    themeMode: MainAppScreen.of(context)!.currentTheme!,
                    onPressed: () {
                      navigateToRoute(context, 'task-lists');
                    },
                    isLoading: isLoading,
                    taskLists: _taskLists,
                  ),
                  const SizedBox(height: 16),
                  NotesPreviewWidget(
                      themeMode: MainAppScreen.of(context)!.currentTheme!,
                      onPressed: () {
                        navigateToRoute(context, 'notes');
                      },
                      isLoading: isLoading,
                      notes: _notes),
                  const SizedBox(height: 16),
                  ActivityPreviewWidget(
                    onPressed: () {
                      navigateToRoute(context, 'activity');
                    },
                  ),
                  const SizedBox(height: 16),
                  CatPreviewWidget(
                      catFacts: catFacts, catPictures: catPictures),
                  const SizedBox(height: 24),
                ],
              ),
            )));
  }
}
