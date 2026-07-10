import 'dart:async';

import 'serialization_util.dart';
import '/backend/backend.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'DailyQuestionPagee': (data) async => ParameterData(
        allParams: {
          'finalAnswerDocPath':
              getParameter<String>(data, 'finalAnswerDocPath'),
          'questionText': getParameter<String>(data, 'questionText'),
          'questionId': getParameter<String>(data, 'questionId'),
          'dayKey': getParameter<String>(data, 'dayKey'),
        },
      ),
  'DailyQuestionResultPage': (data) async => ParameterData(
        allParams: {
          'finalAnswerDocPath':
              getParameter<String>(data, 'finalAnswerDocPath'),
        },
      ),
  'WishesPage': ParameterData.none(),
  'CalenderPage': ParameterData.none(),
  'GaleryPageCopy': ParameterData.none(),
  'LoveNotePage': ParameterData.none(),
  'donationPageV2': ParameterData.none(),
  'OnBoardPage': ParameterData.none(),
  'ProfilePage': ParameterData.none(),
  'StatsPage': ParameterData.none(),
  'HowItWorksPage': ParameterData.none(),
  'LogRegPage': ParameterData.none(),
  'ForgotPassword': ParameterData.none(),
  'ConnectV2': ParameterData.none(),
  'connect': ParameterData.none(),
  'NewEmailPage': ParameterData.none(),
  'NewPasswordPage': ParameterData.none(),
  'BrakeUpPage': ParameterData.none(),
  'TermsPage': ParameterData.none(),
  'SupportPage': ParameterData.none(),
  'ShareYourStory': ParameterData.none(),
  'ComesNextPage': ParameterData.none(),
  'DailyQuestionsJournal': ParameterData.none(),
  'CompletedWishes': ParameterData.none(),
  'AlbumDetailPage': (data) async => ParameterData(
        allParams: {
          'albumRef': getParameter<DocumentReference>(data, 'albumRef'),
          'albumId': getParameter<String>(data, 'albumId'),
        },
      ),
  'GaleryPage': ParameterData.none(),
  'LoveNotesArchive': ParameterData.none(),
  'GoalList': ParameterData.none(),
  'BucketListCopy': ParameterData.none(),
  'CompletedGoals': ParameterData.none(),
  'WishesPageCopy': ParameterData.none(),
  'Restore': ParameterData.none(),
  'RoadmapAdmin': (data) async => ParameterData(
        allParams: {
          'roadmapItemRef':
              getParameter<DocumentReference>(data, 'roadmapItemRef'),
        },
      ),
  'donationPageV1': ParameterData.none(),
  'feeeeedback': ParameterData.none(),
  'homesingle': ParameterData.none(),
  'celebrate': ParameterData.none(),
  'RestoreCopy': ParameterData.none(),
  'S1_Hero': ParameterData.none(),
  'S2_Story': ParameterData.none(),
  'S3_name': ParameterData.none(),
  'S4_partner': ParameterData.none(),
  'S5_createaccount': ParameterData.none(),
  'S6_photo': ParameterData.none(),
  'S7_birth': ParameterData.none(),
  'S8_city': ParameterData.none(),
  'S9_together_since': ParameterData.none(),
  'S10_Demo_LoveBuddy': ParameterData.none(),
  'home': ParameterData.none(),
  'S1_Login': ParameterData.none(),
  'GatePage': ParameterData.none(),
  'LoveNotePageCopy': ParameterData.none(),
  'S11_moreWaysScreen': ParameterData.none(),
  'S_12FounderPage': ParameterData.none(),
  'Together': ParameterData.none(),
  'heartbeat_result': ParameterData.none(),
  'Heartbeat_start': ParameterData.none(),
  'Heartbeat_questions': (data) async => ParameterData(
        allParams: {
          'sessionId': getParameter<String>(data, 'sessionId'),
        },
      ),
  'Heartbeat_wait': ParameterData.none(),
  'love_treasure_main': (data) async => ParameterData(
        allParams: {
          'currentRelationshipRef':
              getParameter<DocumentReference>(data, 'currentRelationshipRef'),
        },
      ),
  'love_treasure_page_two': (data) async => ParameterData(
        allParams: {
          'treasurePath': getParameter<String>(data, 'treasurePath'),
          'currentRelationshipRef':
              getParameter<DocumentReference>(data, 'currentRelationshipRef'),
          'treasureId': getParameter<String>(data, 'treasureId'),
        },
      ),
  'coupon_wallet': (data) async => ParameterData(
        allParams: {
          'relationshipRef':
              getParameter<DocumentReference>(data, 'relationshipRef'),
        },
      ),
  'sticky_wall': ParameterData.none(),
  'sticy_wall_create': (data) async => ParameterData(
        allParams: {
          'relationshipId': getParameter<String>(data, 'relationshipId'),
          'relationshipRef':
              getParameter<DocumentReference>(data, 'relationshipRef'),
          'treasureId': getParameter<String>(data, 'treasureId'),
          'treasureRef': getParameter<DocumentReference>(data, 'treasureRef'),
        },
      ),
  'coupon_page': (data) async => ParameterData(
        allParams: {
          'currentTreasureId': getParameter<String>(data, 'currentTreasureId'),
          'currentTreasureRef':
              getParameter<DocumentReference>(data, 'currentTreasureRef'),
          'currentRelationshipRef':
              getParameter<DocumentReference>(data, 'currentRelationshipRef'),
        },
      ),
  'voice_notes_results': (data) async => ParameterData(
        allParams: {
          'treasureRef': getParameter<DocumentReference>(data, 'treasureRef'),
          'relationshipId': getParameter<String>(data, 'relationshipId'),
        },
      ),
  'treasure_memorys': (data) async => ParameterData(
        allParams: {
          'treasureRef': getParameter<DocumentReference>(data, 'treasureRef'),
          'relationshipId': getParameter<String>(data, 'relationshipId'),
        },
      ),
  'treasures_archive': (data) async => ParameterData(
        allParams: {
          'relationshipId': getParameter<String>(data, 'relationshipId'),
        },
      ),
  'photo_result': (data) async => ParameterData(
        allParams: {
          'treasureRef': getParameter<DocumentReference>(data, 'treasureRef'),
        },
      ),
  'coupon_archive': (data) async => ParameterData(
        allParams: {
          'relationshipRef':
              getParameter<DocumentReference>(data, 'relationshipRef'),
        },
      ),
  'coupon_result': (data) async => ParameterData(
        allParams: {
          'relationshipRef':
              getParameter<DocumentReference>(data, 'relationshipRef'),
        },
      ),
  'coupon_treasure': (data) async => ParameterData(
        allParams: {
          'relationshipId': getParameter<String>(data, 'relationshipId'),
          'treasureRef': getParameter<DocumentReference>(data, 'treasureRef'),
        },
      ),
  'sticky_wall_view': (data) async => ParameterData(
        allParams: {
          'relationshipId': getParameter<String>(data, 'relationshipId'),
          'relationshipRef':
              getParameter<DocumentReference>(data, 'relationshipRef'),
          'treasureId': getParameter<String>(data, 'treasureId'),
          'treasureRef': getParameter<DocumentReference>(data, 'treasureRef'),
        },
      ),
  'PairRequiredPage': ParameterData.none(),
  'pets_home': ParameterData.none(),
  'community': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
