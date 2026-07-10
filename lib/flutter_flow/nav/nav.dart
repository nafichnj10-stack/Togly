import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/main.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';
import 'package:firebase_storagelibrary_2sa6k9/index.dart'
    as $firebase_storagelibrary_2sa6k9;

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) {
  $firebase_storagelibrary_2sa6k9.initializeRoutes(
    homePageWidgetName: 'firebase_storagelibrary_2sa6k9.HomePage',
    homePageWidgetPath: '/homePage',
  );

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: appStateNotifier,
    navigatorKey: appNavigatorKey,
    errorBuilder: (context, state) =>
        appStateNotifier.loggedIn ? NavBarPage() : GatePageWidget(),
    routes: [
      FFRoute(
        name: '_initialize',
        path: '/',
        builder: (context, _) =>
            appStateNotifier.loggedIn ? NavBarPage() : GatePageWidget(),
      ),
      FFRoute(
        name: DailyQuestionPageeWidget.routeName,
        path: DailyQuestionPageeWidget.routePath,
        builder: (context, params) => DailyQuestionPageeWidget(
          finalAnswerDocPath: params.getParam(
            'finalAnswerDocPath',
            ParamType.String,
          ),
          questionText: params.getParam(
            'questionText',
            ParamType.String,
          ),
          questionId: params.getParam(
            'questionId',
            ParamType.String,
          ),
          dayKey: params.getParam(
            'dayKey',
            ParamType.String,
          ),
        ),
      ),
      FFRoute(
        name: DailyQuestionResultPageWidget.routeName,
        path: DailyQuestionResultPageWidget.routePath,
        builder: (context, params) => DailyQuestionResultPageWidget(
          finalAnswerDocPath: params.getParam(
            'finalAnswerDocPath',
            ParamType.String,
          ),
        ),
      ),
      FFRoute(
        name: WishesPageWidget.routeName,
        path: WishesPageWidget.routePath,
        builder: (context, params) => WishesPageWidget(),
      ),
      FFRoute(
        name: CalenderPageWidget.routeName,
        path: CalenderPageWidget.routePath,
        builder: (context, params) => CalenderPageWidget(),
      ),
      FFRoute(
        name: GaleryPageCopyWidget.routeName,
        path: GaleryPageCopyWidget.routePath,
        builder: (context, params) => GaleryPageCopyWidget(),
      ),
      FFRoute(
        name: LoveNotePageWidget.routeName,
        path: LoveNotePageWidget.routePath,
        builder: (context, params) => params.isEmpty
            ? NavBarPage(initialPage: 'LoveNotePage')
            : LoveNotePageWidget(),
      ),
      FFRoute(
        name: DonationPageV2Widget.routeName,
        path: DonationPageV2Widget.routePath,
        builder: (context, params) => DonationPageV2Widget(),
      ),
      FFRoute(
        name: OnBoardPageWidget.routeName,
        path: OnBoardPageWidget.routePath,
        builder: (context, params) => OnBoardPageWidget(),
      ),
      FFRoute(
        name: ProfilePageWidget.routeName,
        path: ProfilePageWidget.routePath,
        builder: (context, params) => params.isEmpty
            ? NavBarPage(initialPage: 'ProfilePage')
            : ProfilePageWidget(),
      ),
      FFRoute(
        name: StatsPageWidget.routeName,
        path: StatsPageWidget.routePath,
        builder: (context, params) => params.isEmpty
            ? NavBarPage(initialPage: 'StatsPage')
            : StatsPageWidget(),
      ),
      FFRoute(
        name: HowItWorksPageWidget.routeName,
        path: HowItWorksPageWidget.routePath,
        builder: (context, params) => HowItWorksPageWidget(),
      ),
      FFRoute(
        name: LogRegPageWidget.routeName,
        path: LogRegPageWidget.routePath,
        builder: (context, params) => LogRegPageWidget(),
      ),
      FFRoute(
        name: ForgotPasswordWidget.routeName,
        path: ForgotPasswordWidget.routePath,
        builder: (context, params) => ForgotPasswordWidget(),
      ),
      FFRoute(
        name: ConnectV2Widget.routeName,
        path: ConnectV2Widget.routePath,
        builder: (context, params) => ConnectV2Widget(),
      ),
      FFRoute(
        name: ConnectWidget.routeName,
        path: ConnectWidget.routePath,
        builder: (context, params) => params.isEmpty
            ? NavBarPage(initialPage: 'connect')
            : ConnectWidget(),
      ),
      FFRoute(
        name: NewEmailPageWidget.routeName,
        path: NewEmailPageWidget.routePath,
        builder: (context, params) => NewEmailPageWidget(),
      ),
      FFRoute(
        name: NewPasswordPageWidget.routeName,
        path: NewPasswordPageWidget.routePath,
        builder: (context, params) => NewPasswordPageWidget(),
      ),
      FFRoute(
        name: BrakeUpPageWidget.routeName,
        path: BrakeUpPageWidget.routePath,
        builder: (context, params) => BrakeUpPageWidget(),
      ),
      FFRoute(
        name: TermsPageWidget.routeName,
        path: TermsPageWidget.routePath,
        builder: (context, params) => TermsPageWidget(),
      ),
      FFRoute(
        name: SupportPageWidget.routeName,
        path: SupportPageWidget.routePath,
        builder: (context, params) => SupportPageWidget(),
      ),
      FFRoute(
        name: ShareYourStoryWidget.routeName,
        path: ShareYourStoryWidget.routePath,
        builder: (context, params) => ShareYourStoryWidget(),
      ),
      FFRoute(
        name: ComesNextPageWidget.routeName,
        path: ComesNextPageWidget.routePath,
        builder: (context, params) => ComesNextPageWidget(),
      ),
      FFRoute(
        name: DailyQuestionsJournalWidget.routeName,
        path: DailyQuestionsJournalWidget.routePath,
        builder: (context, params) => DailyQuestionsJournalWidget(),
      ),
      FFRoute(
        name: CompletedWishesWidget.routeName,
        path: CompletedWishesWidget.routePath,
        builder: (context, params) => CompletedWishesWidget(),
      ),
      FFRoute(
        name: AlbumDetailPageWidget.routeName,
        path: AlbumDetailPageWidget.routePath,
        builder: (context, params) => AlbumDetailPageWidget(
          albumRef: params.getParam(
            'albumRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['albums'],
          ),
          albumId: params.getParam(
            'albumId',
            ParamType.String,
          ),
        ),
      ),
      FFRoute(
        name: GaleryPageWidget.routeName,
        path: GaleryPageWidget.routePath,
        builder: (context, params) => GaleryPageWidget(),
      ),
      FFRoute(
        name: LoveNotesArchiveWidget.routeName,
        path: LoveNotesArchiveWidget.routePath,
        builder: (context, params) => LoveNotesArchiveWidget(),
      ),
      FFRoute(
        name: GoalListWidget.routeName,
        path: GoalListWidget.routePath,
        builder: (context, params) => GoalListWidget(),
      ),
      FFRoute(
        name: BucketListCopyWidget.routeName,
        path: BucketListCopyWidget.routePath,
        builder: (context, params) => BucketListCopyWidget(),
      ),
      FFRoute(
        name: CompletedGoalsWidget.routeName,
        path: CompletedGoalsWidget.routePath,
        builder: (context, params) => CompletedGoalsWidget(),
      ),
      FFRoute(
        name: WishesPageCopyWidget.routeName,
        path: WishesPageCopyWidget.routePath,
        builder: (context, params) => WishesPageCopyWidget(),
      ),
      FFRoute(
        name: RestoreWidget.routeName,
        path: RestoreWidget.routePath,
        requireAuth: true,
        builder: (context, params) => RestoreWidget(),
      ),
      FFRoute(
        name: RoadmapAdminWidget.routeName,
        path: RoadmapAdminWidget.routePath,
        builder: (context, params) => RoadmapAdminWidget(
          roadmapItemRef: params.getParam(
            'roadmapItemRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['roadmap_items'],
          ),
        ),
      ),
      FFRoute(
        name: DonationPageV1Widget.routeName,
        path: DonationPageV1Widget.routePath,
        builder: (context, params) => DonationPageV1Widget(),
      ),
      FFRoute(
        name: FeeeeedbackWidget.routeName,
        path: FeeeeedbackWidget.routePath,
        builder: (context, params) => FeeeeedbackWidget(),
      ),
      FFRoute(
        name: HomesingleWidget.routeName,
        path: HomesingleWidget.routePath,
        builder: (context, params) => HomesingleWidget(),
      ),
      FFRoute(
        name: CelebrateWidget.routeName,
        path: CelebrateWidget.routePath,
        requireAuth: true,
        builder: (context, params) => CelebrateWidget(),
      ),
      FFRoute(
        name: RestoreCopyWidget.routeName,
        path: RestoreCopyWidget.routePath,
        requireAuth: true,
        builder: (context, params) => RestoreCopyWidget(),
      ),
      FFRoute(
        name: S1HeroWidget.routeName,
        path: S1HeroWidget.routePath,
        builder: (context, params) => S1HeroWidget(),
      ),
      FFRoute(
        name: S2StoryWidget.routeName,
        path: S2StoryWidget.routePath,
        builder: (context, params) => S2StoryWidget(),
      ),
      FFRoute(
        name: S3NameWidget.routeName,
        path: S3NameWidget.routePath,
        builder: (context, params) => S3NameWidget(),
      ),
      FFRoute(
        name: S4PartnerWidget.routeName,
        path: S4PartnerWidget.routePath,
        builder: (context, params) => S4PartnerWidget(),
      ),
      FFRoute(
        name: S5CreateaccountWidget.routeName,
        path: S5CreateaccountWidget.routePath,
        builder: (context, params) => S5CreateaccountWidget(),
      ),
      FFRoute(
        name: S6PhotoWidget.routeName,
        path: S6PhotoWidget.routePath,
        builder: (context, params) => S6PhotoWidget(),
      ),
      FFRoute(
        name: S7BirthWidget.routeName,
        path: S7BirthWidget.routePath,
        builder: (context, params) => S7BirthWidget(),
      ),
      FFRoute(
        name: S8CityWidget.routeName,
        path: S8CityWidget.routePath,
        builder: (context, params) => S8CityWidget(),
      ),
      FFRoute(
        name: S9TogetherSinceWidget.routeName,
        path: S9TogetherSinceWidget.routePath,
        builder: (context, params) => S9TogetherSinceWidget(),
      ),
      FFRoute(
        name: S10DemoLoveBuddyWidget.routeName,
        path: S10DemoLoveBuddyWidget.routePath,
        builder: (context, params) => S10DemoLoveBuddyWidget(),
      ),
      FFRoute(
          name: HomeWidget.routeName,
          path: HomeWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'home')
              : NavBarPage(
                  initialPage: 'home',
                  page: HomeWidget(),
                )),
      FFRoute(
        name: S1LoginWidget.routeName,
        path: S1LoginWidget.routePath,
        builder: (context, params) => S1LoginWidget(),
      ),
      FFRoute(
        name: GatePageWidget.routeName,
        path: GatePageWidget.routePath,
        builder: (context, params) => GatePageWidget(),
      ),
      FFRoute(
        name: LoveNotePageCopyWidget.routeName,
        path: LoveNotePageCopyWidget.routePath,
        builder: (context, params) => LoveNotePageCopyWidget(),
      ),
      FFRoute(
        name: S11MoreWaysScreenWidget.routeName,
        path: S11MoreWaysScreenWidget.routePath,
        builder: (context, params) => S11MoreWaysScreenWidget(),
      ),
      FFRoute(
        name: S12FounderPageWidget.routeName,
        path: S12FounderPageWidget.routePath,
        builder: (context, params) => S12FounderPageWidget(),
      ),
      FFRoute(
        name: TogetherWidget.routeName,
        path: TogetherWidget.routePath,
        builder: (context, params) => params.isEmpty
            ? NavBarPage(initialPage: 'Together')
            : TogetherWidget(),
      ),
      FFRoute(
        name: HeartbeatResultWidget.routeName,
        path: HeartbeatResultWidget.routePath,
        builder: (context, params) => HeartbeatResultWidget(),
      ),
      FFRoute(
        name: HeartbeatStartWidget.routeName,
        path: HeartbeatStartWidget.routePath,
        builder: (context, params) => HeartbeatStartWidget(),
      ),
      FFRoute(
        name: HeartbeatQuestionsWidget.routeName,
        path: HeartbeatQuestionsWidget.routePath,
        builder: (context, params) => HeartbeatQuestionsWidget(
          sessionId: params.getParam(
            'sessionId',
            ParamType.String,
          ),
        ),
      ),
      FFRoute(
        name: HeartbeatWaitWidget.routeName,
        path: HeartbeatWaitWidget.routePath,
        builder: (context, params) => HeartbeatWaitWidget(),
      ),
      FFRoute(
        name: LoveTreasureMainWidget.routeName,
        path: LoveTreasureMainWidget.routePath,
        builder: (context, params) => LoveTreasureMainWidget(
          currentRelationshipRef: params.getParam(
            'currentRelationshipRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['relationships'],
          ),
        ),
      ),
      FFRoute(
        name: LoveTreasurePageTwoWidget.routeName,
        path: LoveTreasurePageTwoWidget.routePath,
        builder: (context, params) => LoveTreasurePageTwoWidget(
          treasurePath: params.getParam(
            'treasurePath',
            ParamType.String,
          ),
          currentRelationshipRef: params.getParam(
            'currentRelationshipRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['relationships'],
          ),
          treasureId: params.getParam(
            'treasureId',
            ParamType.String,
          ),
        ),
      ),
      FFRoute(
        name: CouponWalletWidget.routeName,
        path: CouponWalletWidget.routePath,
        builder: (context, params) => CouponWalletWidget(
          relationshipRef: params.getParam(
            'relationshipRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['relationships'],
          ),
        ),
      ),
      FFRoute(
        name: StickyWallWidget.routeName,
        path: StickyWallWidget.routePath,
        builder: (context, params) => StickyWallWidget(),
      ),
      FFRoute(
        name: SticyWallCreateWidget.routeName,
        path: SticyWallCreateWidget.routePath,
        builder: (context, params) => SticyWallCreateWidget(
          relationshipId: params.getParam(
            'relationshipId',
            ParamType.String,
          ),
          relationshipRef: params.getParam(
            'relationshipRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['relationships'],
          ),
          treasureId: params.getParam(
            'treasureId',
            ParamType.String,
          ),
          treasureRef: params.getParam(
            'treasureRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['love_treasures'],
          ),
        ),
      ),
      FFRoute(
        name: CouponPageWidget.routeName,
        path: CouponPageWidget.routePath,
        builder: (context, params) => CouponPageWidget(
          currentTreasureId: params.getParam(
            'currentTreasureId',
            ParamType.String,
          ),
          currentTreasureRef: params.getParam(
            'currentTreasureRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['love_treasures'],
          ),
          currentRelationshipRef: params.getParam(
            'currentRelationshipRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['relationships'],
          ),
        ),
      ),
      FFRoute(
        name: VoiceNotesResultsWidget.routeName,
        path: VoiceNotesResultsWidget.routePath,
        builder: (context, params) => VoiceNotesResultsWidget(
          treasureRef: params.getParam(
            'treasureRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['love_treasures'],
          ),
          relationshipId: params.getParam(
            'relationshipId',
            ParamType.String,
          ),
        ),
      ),
      FFRoute(
        name: TreasureMemorysWidget.routeName,
        path: TreasureMemorysWidget.routePath,
        builder: (context, params) => TreasureMemorysWidget(
          treasureRef: params.getParam(
            'treasureRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['love_treasures'],
          ),
          relationshipId: params.getParam(
            'relationshipId',
            ParamType.String,
          ),
        ),
      ),
      FFRoute(
        name: TreasuresArchiveWidget.routeName,
        path: TreasuresArchiveWidget.routePath,
        builder: (context, params) => TreasuresArchiveWidget(
          relationshipId: params.getParam(
            'relationshipId',
            ParamType.String,
          ),
        ),
      ),
      FFRoute(
        name: PhotoResultWidget.routeName,
        path: PhotoResultWidget.routePath,
        builder: (context, params) => PhotoResultWidget(
          treasureRef: params.getParam(
            'treasureRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['love_treasures'],
          ),
        ),
      ),
      FFRoute(
        name: CouponArchiveWidget.routeName,
        path: CouponArchiveWidget.routePath,
        builder: (context, params) => CouponArchiveWidget(
          relationshipRef: params.getParam(
            'relationshipRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['relationships'],
          ),
        ),
      ),
      FFRoute(
        name: CouponResultWidget.routeName,
        path: CouponResultWidget.routePath,
        builder: (context, params) => CouponResultWidget(
          relationshipRef: params.getParam(
            'relationshipRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['relationships'],
          ),
        ),
      ),
      FFRoute(
        name: CouponTreasureWidget.routeName,
        path: CouponTreasureWidget.routePath,
        builder: (context, params) => CouponTreasureWidget(
          relationshipId: params.getParam(
            'relationshipId',
            ParamType.String,
          ),
          treasureRef: params.getParam(
            'treasureRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['love_treasures'],
          ),
        ),
      ),
      FFRoute(
        name: StickyWallViewWidget.routeName,
        path: StickyWallViewWidget.routePath,
        builder: (context, params) => StickyWallViewWidget(
          relationshipId: params.getParam(
            'relationshipId',
            ParamType.String,
          ),
          relationshipRef: params.getParam(
            'relationshipRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['relationships'],
          ),
          treasureId: params.getParam(
            'treasureId',
            ParamType.String,
          ),
          treasureRef: params.getParam(
            'treasureRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['love_treasures'],
          ),
        ),
      ),
      FFRoute(
        name: PairRequiredPageWidget.routeName,
        path: PairRequiredPageWidget.routePath,
        builder: (context, params) => PairRequiredPageWidget(),
      ),
      FFRoute(
        name: PetsHomeWidget.routeName,
        path: PetsHomeWidget.routePath,
        builder: (context, params) => PetsHomeWidget(),
      ),
      FFRoute(
        name: CommunityWidget.routeName,
        path: CommunityWidget.routePath,
        builder: (context, params) => CommunityWidget(),
      ),
      FFRoute(
        name: $firebase_storagelibrary_2sa6k9.HomePageWidget.routeName,
        path: $firebase_storagelibrary_2sa6k9.HomePageWidget.routePath,
        builder: (context, params) =>
            $firebase_storagelibrary_2sa6k9.HomePageWidget(),
      )
    ].map((r) => r.toRoute(appStateNotifier)).toList(),
    observers: [routeObserver],
  );
}

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo {
    final possibleKeys = [
      '__transition_info__',
      '__transition_info__firebase_storagelibrary_2sa6k9'
    ];
    for (final key in possibleKeys) {
      if (extraMap.containsKey(key)) {
        return extraMap[key] as TransitionInfo;
      }
    }
    return TransitionInfo.appDefault();
  }
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/gatePage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
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
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
