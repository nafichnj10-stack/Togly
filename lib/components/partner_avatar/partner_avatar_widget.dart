import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'partner_avatar_model.dart';
export 'partner_avatar_model.dart';

/// Create a reusable FlutterFlow component called PartnerAvatar.
///
/// It shows the partner’s profile photo from the users collection. The
/// partner is the user with the same relationship_id as the authenticated
/// user but a different uid. Run a Firestore collection query on users with
/// filters: relationship_id == AuthUser.relationship_id and uid !=
/// AuthUser.uid, limit 1. Bind the photo_url of that document to an Image
/// widget. Add props: size (Number, default 48) for width/height, rounded
/// (Boolean, default true) for circular or square style, and placeholderUrl
/// (String) for fallback. If no partner or photo_url is empty, show
/// placeholderUrl or a default asset placeholder
/// (assets/images/avatar_placeholder.png). Use a Network image with caching.
/// The component must be standalone and reusable on any page without extra
/// queries.
class PartnerAvatarWidget extends StatefulWidget {
  const PartnerAvatarWidget({super.key});

  @override
  State<PartnerAvatarWidget> createState() => _PartnerAvatarWidgetState();
}

class _PartnerAvatarWidgetState extends State<PartnerAvatarWidget> {
  late PartnerAvatarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PartnerAvatarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthUserStreamWidget(
      builder: (context) => StreamBuilder<List<UsersRecord>>(
        stream: queryUsersRecord(
          queryBuilder: (usersRecord) => usersRecord
              .where(
                'uid',
                isNotEqualTo: currentUserUid,
              )
              .where(
                'relationship_id',
                isEqualTo:
                    valueOrDefault(currentUserDocument?.relationshipId, ''),
              ),
          singleRecord: true,
        ),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }
          List<UsersRecord> containerUsersRecordList = snapshot.data!;
          final containerUsersRecord = containerUsersRecordList.isNotEmpty
              ? containerUsersRecordList.first
              : null;

          return Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).alternate,
                  width: 1.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Image.network(
                  containerUsersRecord!.photoUrl,
                  width: 48.0,
                  height: 48.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
