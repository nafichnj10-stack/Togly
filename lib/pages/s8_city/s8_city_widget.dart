import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 's8_city_model.dart';
export 's8_city_model.dart';

/// Create a full-screen onboarding page to collect the user’s city.
///
/// Use a full-screen Stack with a background image filling the screen.
///
/// Centered Column layout:
/// Large headline: “Where do you live?”
/// Subtitle below: “Enter your city name.”
/// White text with subtle shadow.
///
/// Add a rounded glassmorphism text input centered:
/// Hint text: “Enter your city…”
/// Slightly transparent white background, rounded corners, thin white border,
/// soft shadow.
/// Text and hint in white with good contrast.
///
/// Below the input add a primary rounded “Continue” button:
/// Soft purple/pink gradient, subtle gloss, soft shadow.
///
/// Style:
/// Romantic pastel purple theme, clean spacing, centered alignment, no
/// overflow, mobile-friendly.
class S8CityWidget extends StatefulWidget {
  const S8CityWidget({super.key});

  static String routeName = 'S8_city';
  static String routePath = '/s8City';

  @override
  State<S8CityWidget> createState() => _S8CityWidgetState();
}

class _S8CityWidgetState extends State<S8CityWidget> {
  late S8CityModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => S8CityModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'S8_city'});
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PublicUsersRecord>>(
      stream: queryPublicUsersRecord(
        queryBuilder: (publicUsersRecord) => publicUsersRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<PublicUsersRecord> s8CityPublicUsersRecordList = snapshot.data!;
        final s8CityPublicUsersRecord = s8CityPublicUsersRecordList.isNotEmpty
            ? s8CityPublicUsersRecordList.first
            : null;

        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: FlutterFlowTheme.of(context).primary,
          body: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 1.0,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/background_country.webp',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x40000000), Color(0x60000000)],
                      stops: [0.0, 1.0],
                      begin: AlignmentDirectional(0.0, 1.0),
                      end: AlignmentDirectional(0, -1.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'et9sxyne' /* Where do you live? */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .displayMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .displayMediumFamily,
                                color: Colors.white,
                                fontSize: 36.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 2.0,
                                  )
                                ],
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .displayMediumIsCustom,
                              ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 48.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'suptmxbh' /* Tap "Select location" and ente... */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyLargeFamily,
                                color: Color(0xE6FFFFFF),
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                lineHeight: 1.4,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodyLargeIsCustom,
                              ),
                        ),
                      ),
                      Form(
                        key: _model.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 90.0),
                              child: FlutterFlowPlacePicker(
                                iOSGoogleMapsApiKey: '<placeholder_key>',
                                androidGoogleMapsApiKey:
                                    'AIzaSyC2dwTu7CBJwgzU7ziDoMQEh2259PGefBg',
                                webGoogleMapsApiKey:
                                    'AIzaSyC2dwTu7CBJwgzU7ziDoMQEh2259PGefBg',
                                onSelect: (place) async {
                                  safeSetState(
                                      () => _model.placePickerValue = place);
                                },
                                defaultText:
                                    FFLocalizations.of(context).getText(
                                  'y75flzd7' /* Select Location */,
                                ),
                                icon: Icon(
                                  Icons.place,
                                  color: FlutterFlowTheme.of(context).error,
                                  size: 16.0,
                                ),
                                buttonOptions: FFButtonOptions(
                                  width: 200.0,
                                  height: 60.0,
                                  color: FlutterFlowTheme.of(context).secondary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts:
                                            !FlutterFlowTheme.of(context)
                                                .titleSmallIsCustom,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }
                          if (_model.placePickerValue == FFPlace()) {
                            return;
                          }
                          _model.geocodeResult =
                              await GoogleGeocodeLocationCall.call(
                            address: _model.placePickerValue.address,
                            language: valueOrDefault(
                                currentUserDocument?.appLanguage, ''),
                          );

                          _model.parsgoogle =
                              await actions.parseGoogleGeocodeLocation(
                            (_model.geocodeResult?.jsonBody ?? ''),
                          );
                          if (_model.parsgoogle != null) {
                            await s8CityPublicUsersRecord!.reference
                                .update(createPublicUsersRecordData(
                              city: getJsonField(
                                _model.parsgoogle,
                                r'''$.city''',
                              ).toString(),
                              countryName: getJsonField(
                                _model.parsgoogle,
                                r'''$.countryName''',
                              ).toString(),
                              countryCode: getJsonField(
                                _model.parsgoogle,
                                r'''$.countryCode''',
                              ).toString(),
                              homeLat: getJsonField(
                                _model.parsgoogle,
                                r'''$.lat''',
                              ),
                              homeLng: getJsonField(
                                _model.parsgoogle,
                                r'''$.lng''',
                              ),
                            ));

                            await currentUserReference!
                                .update(createUsersRecordData(
                              onboardingStep: 'together',
                              city: getJsonField(
                                _model.parsgoogle,
                                r'''$.city''',
                              ).toString(),
                              countryName: getJsonField(
                                _model.parsgoogle,
                                r'''$.countryName''',
                              ).toString(),
                              countryCode: getJsonField(
                                _model.parsgoogle,
                                r'''$.countryCode''',
                              ).toString(),
                              homeLat: getJsonField(
                                _model.parsgoogle,
                                r'''$.lat''',
                              ),
                              homeLng: getJsonField(
                                _model.parsgoogle,
                                r'''$.lng''',
                              ),
                            ));

                            context.pushNamed(
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  FFLocalizations.of(context).getVariableText(
                                    enText:
                                        'Please choose a city, not only a country.',
                                    deText:
                                        'Bitte wähle eine Stadt und nicht nur ein Land aus',
                                    esText:
                                        'Por favor, elige una ciudad y no solo un país',
                                  ),
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                          }

                          safeSetState(() {});
                        },
                        text: FFLocalizations.of(context).getText(
                          'ea2bm4l5' /* Continue */,
                        ),
                        options: FFButtonOptions(
                          width: 280.0,
                          height: 56.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              32.0, 0.0, 32.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xB4FF7AC8),
                          textStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleMediumFamily,
                                color: Colors.white,
                                fontSize: 18.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                shadows: [
                                  Shadow(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 2.0,
                                  )
                                ],
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .titleMediumIsCustom,
                              ),
                          elevation: 8.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryText,
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
