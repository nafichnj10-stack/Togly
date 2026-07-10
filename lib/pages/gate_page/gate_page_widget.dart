import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'gate_page_model.dart';
export 'gate_page_model.dart';

class GatePageWidget extends StatefulWidget {
  const GatePageWidget({super.key});

  static String routeName = 'GatePage';
  static String routePath = '/gatePage';

  @override
  State<GatePageWidget> createState() => _GatePageWidgetState();
}

class _GatePageWidgetState extends State<GatePageWidget> {
  late GatePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GatePageModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'GatePage'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (loggedIn == false) {
        context.goNamed(
          S1HeroWidget.routeName,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );
      } else {
        if (valueOrDefault<bool>(
                currentUserDocument?.onboardingCompleted, false) ==
            true) {
          context.goNamed(
            HomeWidget.routeName,
            extra: <String, dynamic>{
              '__transition_info__': TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
              ),
            },
          );
        } else {
          if (valueOrDefault(currentUserDocument?.onboardingStep, '') ==
              'photo') {
            context.goNamed(
              S6PhotoWidget.routeName,
              extra: <String, dynamic>{
                '__transition_info__': TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 0),
                ),
              },
            );
          } else {
            if (valueOrDefault(currentUserDocument?.onboardingStep, '') ==
                'birthday') {
              context.goNamed(
                S7BirthWidget.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            } else {
              if (valueOrDefault(currentUserDocument?.onboardingStep, '') ==
                  'city') {
                context.goNamed(
                  S8CityWidget.routeName,
                  extra: <String, dynamic>{
                    '__transition_info__': TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                      duration: Duration(milliseconds: 0),
                    ),
                  },
                );
              } else {
                if (valueOrDefault(currentUserDocument?.onboardingStep, '') ==
                    'together') {
                  context.goNamed(
                    S9TogetherSinceWidget.routeName,
                    extra: <String, dynamic>{
                      '__transition_info__': TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                      ),
                    },
                  );
                } else {
                  if (valueOrDefault(currentUserDocument?.onboardingStep, '') ==
                      'demo') {
                    context.goNamed(
                      S10DemoLoveBuddyWidget.routeName,
                      extra: <String, dynamic>{
                        '__transition_info__': TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );
                  } else {
                    context.goNamed(
                      S6PhotoWidget.routeName,
                      extra: <String, dynamic>{
                        '__transition_info__': TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                          duration: Duration(milliseconds: 0),
                        ),
                      },
                    );
                  }
                }
              }
            }
          }
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Image.asset(
            'assets/images/heropic.webp',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
