import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'de', 'es'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? deText = '',
    String? esText = '',
  }) =>
      [enText, deText, esText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // DailyQuestionPagee
  {
    '2h1uz91m': {
      'en': 'Today\'s Question',
      'de': 'Heutige Frage',
      'es': 'Pregunta de hoy',
    },
    'x2xobpyy': {
      'en': 'Share your thoughts here...',
      'de': 'Teile hier deine Gedanken mit...',
      'es': 'Escribe aquí lo que piensas…',
    },
    'v1qh04wl': {
      'en': 'Send answer',
      'de': 'Antwort senden',
      'es': 'Enviar respuesta',
    },
    'fm23psl8': {
      'en':
          'After you have answered, you will be taken to the page where your partner\'s answer will be visible.',
      'de': 'Nach deiner Antwort wirst du zur \"Antwortseite\" weitergeleitet.',
      'es':
          'Después de responder, serás llevado a la página donde podrás ver la respuesta de tu pareja.',
    },
    'evtpu0ey': {
      'en': 'Daily question',
      'de': 'Tägliche Frage',
      'es': 'Pregunta diaria',
    },
  },
  // DailyQuestionResultPage
  {
    '33sosmv7': {
      'en': 'Today\'s Answers',
      'de': 'Heutige Frage.',
      'es': 'Respuestas de hoy',
    },
    'g9r2ayf2': {
      'en': 'You said',
      'de': 'Deine Antwort.',
      'es': 'Tú dijiste',
    },
    'xg39cgr7': {
      'en': 'Your partner said',
      'de': 'Die Antwort deines Partners.',
      'es': 'Tu pareja dijo',
    },
    'mu4dsbbe': {
      'en': 'Waiting for your partner\'s answer…',
      'de': 'Warte auf die Antwort Ihres Partners/Ihrer Partnerin…',
      'es': 'Esperando la respuesta de tu pareja…',
    },
    'po6tf5wv': {
      'en': 'Both answers saved\n to your relationship journal',
      'de': 'Beide Antworten werden\nin eurem Archiv gespeichert.',
      'es': 'Ambas respuestas se han guardado en vuestro diario de pareja',
    },
    '7cr262ik': {
      'en': 'Back to Home',
      'de': 'Zurück zur Startseite',
      'es': 'Volver al inicio',
    },
    's0xm194p': {
      'en': 'Answers',
      'de': 'Antworten',
      'es': 'Respuestas',
    },
  },
  // WishesPage
  {
    '5ap37rmo': {
      'en': 'Add',
      'de': 'Erstellen',
      'es': 'Añadir',
    },
    'm6b5tqs7': {
      'en': 'Shared Wishes',
      'de': 'Geteilte Wünsche',
      'es': 'Deseos compartidos',
    },
    'angizlmo': {
      'en': 'Lets share together!',
      'de': 'Wünsche gemeinsam teilen!',
      'es': '¡Compartamos deseos juntos!',
    },
    'vkgtpdd1': {
      'en': 'Link',
      'de': 'Link',
      'es': 'Enlace',
    },
    'pnf0hr0n': {
      'en': 'Wishlist',
      'de': 'Wunschliste',
      'es': 'Lista de deseos',
    },
  },
  // CalenderPage
  {
    'kch0xqqn': {
      'en': 'Shared Calendar',
      'de': 'Gemeinsamer Kalender',
      'es': 'Calendario compartido',
    },
    'ksjgorwh': {
      'en': 'Plan or inform together',
      'de': 'Gemeinsam planen oder informieren',
      'es': 'Planifica o informa juntos',
    },
    'lmsu6q7g': {
      'en': 'Add',
      'de': 'Erstellen',
      'es': 'Añadir',
    },
    'wgi2p6k3': {
      'en': 'All Day',
      'de': 'Ganztägig',
      'es': 'Todo el día',
    },
    'teua2rw1': {
      'en': 'Upcoming • next 14 days',
      'de': 'Ausstehend • die nächsten 14 Tage',
      'es': 'Próximos · próximos 14 días',
    },
    '7m981rwu': {
      'en': 'Start: ',
      'de': 'Start: ',
      'es': 'Inicio:',
    },
    '4f5et1ws': {
      'en': 'End: ',
      'de': 'Ende: ',
      'es': 'Fin:',
    },
    '4607e943': {
      'en': 'Calendar',
      'de': 'Kalender',
      'es': 'Calendario',
    },
  },
  // GaleryPageCopy
  {
    'r6fu270y': {
      'en': 'Shared Gallery',
      'de': 'Gemeinsame Galerie',
      'es': '',
    },
    'won76ckj': {
      'en': 'Your favorite memories, all in one place – together.',
      'de': 'Eure schönsten Erinnerungen, alle an einem Ort zusammen.',
      'es': '',
    },
    '558096rn': {
      'en': 'Albums',
      'de': 'Alben',
      'es': '',
    },
    'h3xjh58c': {
      'en': 'Paris Trip',
      'de': 'Paris-Reise',
      'es': '',
    },
    '9scz6iod': {
      'en': '24 photos',
      'de': '24 Fotos',
      'es': '',
    },
    'qq2jvzc9': {
      'en': 'Sweet Moments',
      'de': '',
      'es': '',
    },
    '6y4bs18o': {
      'en': '18 photos',
      'de': '',
      'es': '',
    },
    '8u5wn9m0': {
      'en': 'Happy Laughs',
      'de': '',
      'es': '',
    },
    'rro89wvd': {
      'en': '12 photos',
      'de': '',
      'es': '',
    },
    'awzydv0i': {
      'en': 'Create Album',
      'de': '',
      'es': '',
    },
    '3wvsixkf': {
      'en': 'All Photos',
      'de': '',
      'es': '',
    },
    '8e8e8v1l': {
      'en': 'Gallery',
      'de': '',
      'es': '',
    },
  },
  // LoveNotePage
  {
    '80yil7ha': {
      'en': 'Love Notes',
      'de': 'Liebesbotschaften',
      'es': 'Notas de amor',
    },
    '25hu6edu': {
      'en': 'Little words. Big feelings\njust for the two of you.',
      'de': 'Wenige Worte. Große Gefühle.\nNur für euch beide.',
      'es': 'Pequeñas palabras. Grandes emociones. Solo para vosotros.',
    },
    'jb7t97h7': {
      'en': '💕',
      'de': '💕',
      'es': '💕',
    },
    '30nu5io8': {
      'en': 'Write your daily love note here...',
      'de': 'Schreibe hier deine tägliche Liebesbotschaft...',
      'es': 'Escribe aquí tu nota de amor diaria…',
    },
    '72pfl6w0': {
      'en': '💌 Send Note',
      'de': '💌 Nachricht senden',
      'es': 'Enviar nota',
    },
  },
  // donationPageV2
  {
    'wlz00na5': {
      'en': 'Support Togly 💜',
      'de': 'Unterstütze Togly 💜',
      'es': '',
    },
    'jyl9a4bn': {
      'en':
          'Help me build more beautiful moments for couples around the world.',
      'de': '',
      'es': '',
    },
    'mp9l6ork': {
      'en': '✨ That\'s me together with the reason for my vision ✨',
      'de': '',
      'es': '',
    },
    '2j7xfjzg': {
      'en': 'Why your support matters 💫',
      'de': '',
      'es': '',
    },
    'j4ogeyin': {
      'en':
          'Togly was developed with love and a vision. Just like you, I know how it feels to be in a long-distance relationship and what problems and challenges this brings.\n Your support helps me grow. \nEvery donation will help me to soon build a full team to improve features, add new tools, and spread more love. \nThis is just the beginning from my vision.',
      'de': '',
      'es': '',
    },
    'mc14jdsu': {
      'en': 'Doing good things together 🌱',
      'de': '',
      'es': '',
    },
    'hb6fq5ot': {
      'en':
          'My dream is to turn connection into action and give back to the world that inspires me and all of us.\nTogly wants to support concrete projects in the future, such as building schools, protecting nature and animals, and helping communities in need.\nEvery donation and every bit of support brings me one step closer to achieving these goals.\nWe will openly share our journey on our Togly YouTube channel in the future and show how your support really makes a difference.\ntogether, we prove that love can do more than just connect hearts\nit can change lives. 💜',
      'de': '',
      'es': '',
    },
    'oz3z9327': {
      'en': 'One time payment',
      'de': '',
      'es': '',
    },
    '8xu9kd1i': {
      'en': '💖 Buy me a coffee',
      'de': '',
      'es': '',
    },
    'ludbm02c': {
      'en': 'A small gesture of love',
      'de': '',
      'es': '',
    },
    'vecbq007': {
      'en': '\$5',
      'de': '',
      'es': '',
    },
    'j2div1rb': {
      'en': '🌸 Support my growth',
      'de': '',
      'es': '',
    },
    'nk5cia4y': {
      'en': 'Help us bloom together',
      'de': '',
      'es': '',
    },
    'r1rsacfe': {
      'en': '\$20',
      'de': '',
      'es': '',
    },
    'lqd3leca': {
      'en': '✨ Become a sponsor',
      'de': '',
      'es': '',
    },
    'p4p8a1ij': {
      'en': 'Shine bright',
      'de': '',
      'es': '',
    },
    'aldpg7j3': {
      'en': '\$50',
      'de': '',
      'es': '',
    },
    'z7aqa3qx': {
      'en': '💎 Custom amount',
      'de': '',
      'es': '',
    },
    'o9q47aph': {
      'en': 'Choose your own way',
      'de': '',
      'es': '',
    },
    'm3jh82n9': {
      'en': 'Monthly subscription',
      'de': '',
      'es': '',
    },
    'h7r55qar': {
      'en': '☕ Buy me a coffee',
      'de': '',
      'es': '',
    },
    'xq54hgdc': {
      'en': 'A small gesture of love',
      'de': '',
      'es': '',
    },
    'mg0la9gc': {
      'en': '\$5',
      'de': '',
      'es': '',
    },
    '33ehsgl4': {
      'en': '🌱 Support my growth',
      'de': '',
      'es': '',
    },
    'y4thy33w': {
      'en': 'Help us bloom together',
      'de': '',
      'es': '',
    },
    'mdca8quw': {
      'en': '\$20',
      'de': '',
      'es': '',
    },
    '232s84vd': {
      'en': '🍾 Become a sponsor',
      'de': '',
      'es': '',
    },
    'lqvtv14q': {
      'en': 'Shine bright',
      'de': '',
      'es': '',
    },
    '3g2ifxs4': {
      'en': '\$50',
      'de': '',
      'es': '',
    },
    'g7pqpn2b': {
      'en': '💎 Custom amount',
      'de': '',
      'es': '',
    },
    't8tbt4s7': {
      'en': 'Choose your own way',
      'de': '',
      'es': '',
    },
    'j40kppjt': {
      'en': 'Secure Payment Methods',
      'de': '',
      'es': '',
    },
    '4t862dou': {
      'en': 'All payments are securely processed by our trusted providers.',
      'de': '',
      'es': '',
    },
    'r5la8mr0': {
      'en': '\"\"Thanks to Togly',
      'de': '',
      'es': '',
    },
    '5a0zs9n8': {
      'en': '– A happy user ❤️',
      'de': '',
      'es': '',
    },
    'xql2re5e': {
      'en': 'Thank you for believing in me and the vision 💜',
      'de': '',
      'es': '',
    },
    'zglbsa8e': {
      'en': 'Your support means the world to couples everywhere',
      'de': '',
      'es': '',
    },
    'u24so468': {
      'en': 'Donation',
      'de': '',
      'es': '',
    },
  },
  // OnBoardPage
  {
    '3zjakn91': {
      'en': 'Some informations\nabout you 💜',
      'de': 'Ein paar Informationen\nüber dich 💜',
      'es': 'Algunos datos sobre ti 💜',
    },
    'akrrummq': {
      'en': 'Just a few more details before we get started.',
      'de': 'Nur noch ein paar Details, bevor wir anfangen.',
      'es': 'Solo algunos detalles más antes de empezar.',
    },
    '39ltwsh0': {
      'en': 'Upload your profile photo',
      'de': 'Laden ein Profilfoto hoch',
      'es': 'Sube tu foto de perfil',
    },
    '44zcv3d6': {
      'en': 'First Name',
      'de': 'Vorname',
      'es': 'Nombre',
    },
    '495ahltk': {
      'en': 'Enter your first name',
      'de': 'Gebe deinen Vornamen ein',
      'es': 'Introduce tu nombre',
    },
    'te9u80to': {
      'en': 'Current City',
      'de': 'Aktuelle Stadt',
      'es': 'Ciudad actual',
    },
    '7jqkh6q0': {
      'en': 'Enter your city',
      'de': 'Geben die Stadt an',
      'es': 'Introduce tu ciudad',
    },
    'why7h89o': {
      'en': 'Date of birth',
      'de': 'Geburtsdatum',
      'es': 'Fecha de nacimiento',
    },
    'zb2idk0y': {
      'en': 'Name is required!',
      'de': 'Name ist erforderlich!',
      'es': '¡El nombre es obligatorio!',
    },
    'k1cs05qd': {
      'en': 'Maximum 15 letters',
      'de': 'Maximal 15 Buchstaben',
      'es': 'Máximo 15 caracteres',
    },
    'pnmth6v5': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wähle  eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    '1z28pk1v': {
      'en': 'Current City is required',
      'de': 'Aktuelle Stadt ist erforderlich',
      'es': 'La ciudad actual es obligatoria',
    },
    'n55hvelg': {
      'en': 'Maximum 15 letters',
      'de': 'Maximal 15 Buchstaben',
      'es': 'HMáximo 15 caracteres',
    },
    'bke57hft': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    '37e2pb3a': {
      'en': 'Local Time',
      'de': 'Ortszeit',
      'es': 'Hora local',
    },
    'v1pcmp4n': {
      'en': 'Choose your dummy friend',
      'de': 'Wähle deinen Dummy-Partner',
      'es': 'Elige a tu pareja de prueba',
    },
    'zbvg99ve': {
      'en': '♂️ Male',
      'de': '♂️Mann',
      'es': '♂️Hombre',
    },
    'mmn8them': {
      'en': '♀️ Female',
      'de': '♀️Frau',
      'es': '♀️Mujer',
    },
    'itz36za3': {
      'en': '',
      'de': '',
      'es': '',
    },
    '0ldgg5a1': {
      'en': 'How did you find out about this app? Please select',
      'de': 'Wie hast du von dieser App erfahren? Bitte wähle aus.',
      'es': '¿Cómo conociste esta app?',
    },
    'wouo6mwf': {
      'en': 'Select...',
      'de': 'Auswählen...',
      'es': 'Por favor, selecciona',
    },
    '787sh9zg': {
      'en': 'Search...',
      'de': 'Suchen...',
      'es': 'Seleccionar…',
    },
    '1k1gvr1a': {
      'en': 'Instagram',
      'de': 'Instagram',
      'es': 'Instagram',
    },
    '62trm4ig': {
      'en': 'TikTok',
      'de': 'TikTok',
      'es': 'TikTok',
    },
    't6pf73um': {
      'en': 'Facebook',
      'de': 'Facebook',
      'es': 'Facebook',
    },
    '31lp5543': {
      'en': 'Recommendation',
      'de': 'Empfehlung',
      'es': 'Recomendación',
    },
    '70a4b84y': {
      'en': 'Advertising',
      'de': 'Werbung',
      'es': 'Publicidad',
    },
    'ujux9u63': {
      'en': 'App Store',
      'de': 'App Store',
      'es': 'App Store',
    },
    'l3lazkun': {
      'en': 'Other',
      'de': 'Andere',
      'es': 'Otro',
    },
    'ai49lscm': {
      'en': 'Continue',
      'de': 'Weiter',
      'es': 'Continuar',
    },
    'qgokrbe8': {
      'en':
          'You can always edit this information later in your profile settings.',
      'de':
          'Du kannst diese Informationen jederzeit später in deinem Profileinstellungen bearbeiten.',
      'es':
          'Siempre puedes editar esta información más tarde en la configuración de tu perfil.',
    },
  },
  // ProfilePage
  {
    '9hvj740b': {
      'en': 'Profile Settings',
      'de': 'Profileinstellungen',
      'es': 'Configuración del perfil',
    },
    'pun6dy4o': {
      'en': '💜 Support Togly',
      'de': 'Unterstütze Togly',
      'es': '💜 Apoya a Togly',
    },
    'jnc4thi7': {
      'en': '🤗 Give Feedback',
      'de': '🤗 Feedback geben',
      'es': '😊 Enviar comentarios',
    },
    'm59cd4h5': {
      'en': 'Personal Information',
      'de': 'Persönliche Informationen',
      'es': 'Información personal',
    },
    'djnisdp5': {
      'en': 'Name',
      'de': 'Vorname',
      'es': 'Nombre',
    },
    '72xer5tt': {
      'en': 'City / Location',
      'de': 'Stadt/Standort',
      'es': 'Ciudad / Ubicación',
    },
    'yu0rlim0': {
      'en': 'Country',
      'de': 'Land',
      'es': 'País',
    },
    '0edwarya': {
      'en': 'Change location',
      'de': 'Standort ändern',
      'es': 'Cambiar ubicación',
    },
    'ocg1ozcq': {
      'en': 'Together since',
      'de': 'Zusammen seit',
      'es': 'Juntos desde',
    },
    '1pdr7b6t': {
      'en': 'Current Local Time',
      'de': 'Aktuelle Ortszeit',
      'es': 'Hora local actual',
    },
    'ntem4azf': {
      'en': 'Update profile',
      'de': 'Profil aktualisieren',
      'es': 'Actualizar perfil',
    },
    '6ex66hwn': {
      'en': 'Change E-Mail',
      'de': 'E-Mail ändern',
      'es': 'Cambiar correo electrónico',
    },
    'mqwqijbp': {
      'en': 'Update your E-Mail-Adress',
      'de': 'Aktualisieren Sie Ihre E-Mail-Adresse',
      'es': 'Actualiza tu dirección de correo electrónico',
    },
    'd7xngh7q': {
      'en': 'Change Password',
      'de': 'Passwort ändern',
      'es': 'Cambiar contraseña',
    },
    'u8u184jj': {
      'en': 'Update your account password',
      'de': 'Aktualisieren Sie Ihr Kontopasswort',
      'es': 'Actualiza la contraseña de tu cuenta',
    },
    'o81rmyjv': {
      'en': 'Dummy and Language',
      'de': 'Dein Dummy',
      'es': 'Tu pareja de prueba',
    },
    'hjoiwnie': {
      'en': 'Change your dummy',
      'de': 'Wechsel deinen Dummy',
      'es': 'Cambiar tu pareja de prueba',
    },
    'm38smcbn': {
      'en': '♂️ Male',
      'de': '♂️ Mann',
      'es': '♂️Hombre',
    },
    'ky5ntja5': {
      'en': '♀️ Female',
      'de': '♀️ Frau',
      'es': '♀️Mujer',
    },
    'qo2a9v89': {
      'en': 'Change your language',
      'de': 'Sprache wechseln',
      'es': 'Cambiar tu pareja de prueba',
    },
    'b4b6qdup': {
      'en': '🗣️ Change language',
      'de': '🗣️ Sprache ändern',
      'es': '🗣️Cambiar idioma',
    },
    '1ibi3t8l': {
      'en': 'Notifications',
      'de': 'Benachrichtigungen',
      'es': 'Notificaciones',
    },
    'bvg35519': {
      'en': 'Messages & Notes',
      'de': 'Nachrichten und Notizen',
      'es': 'Mensajes y notas',
    },
    'maqhjqgt': {
      'en': 'Love Notes, Chat/Notes, “partner sent you something',
      'de':
          'Liebesbotschaften, Chat-/Notizen, „Dein Partner hat dir etwas geschickt“',
      'es': 'Notas de amor, chat/notas, “tu pareja te ha enviado algo”',
    },
    'ldrdhaki': {
      'en': 'Daily Question Alerts',
      'de': 'Tägliche Fragenbenachrichtigungen',
      'es': 'Notificaciones de la pregunta diaria',
    },
    'ul5it5ti': {
      'en':
          'Receive a message when your partner has answered the daily question',
      'de':
          'Erhalte eine Nachricht, wenn dein Partner die tägliche Frage beantwortet hat.',
      'es':
          'Recibe un mensaje cuando tu pareja haya respondido a la pregunta diaria',
    },
    '4blsi4wa': {
      'en': 'Relationship Alerts',
      'de': 'Beziehungsnachrichten',
      'es': 'Notificaciones de la relación',
    },
    'sf300sbe': {
      'en': 'Requests, accepts\nand disconnects',
      'de': 'Anfragen, Annahmen\nund wenn Verbindung getrennt wurde',
      'es': 'Solicitudes, aceptaciones y desconexiones',
    },
    'toa9ygcq': {
      'en': 'Shared Moments & Plans',
      'de': 'Gemeinsame Momente & Pläne',
      'es': 'Momentos y planes compartidos',
    },
    '0gucdcel': {
      'en': 'Get notified about shared memories and future plans',
      'de':
          'Lass dich über gemeinsame Erinnerungen und Zukunftspläne benachrichtigen.',
      'es':
          'Recibe notificaciones sobre recuerdos compartidos y planes futuros',
    },
    '8rg7k9a8': {
      'en': 'Daily Question Reminders',
      'de': 'Tägliche Fragenerinnerungen',
      'es': 'Recordatorios de la pregunta diaria',
    },
    '8gvb4fa0': {
      'en': 'Daily prompts to strengthen your connection',
      'de': 'Tägliche Anregungen zur Stärkung eurer Verbindung',
      'es': 'Sugerencias diarias para fortalecer vuestra conexión',
    },
    'c49q5jis': {
      'en': 'Stay Connected Reminder',
      'de': 'Erinnerung in Verbindung zu bleiben',
      'es': 'Recordatorio para mantener la conexión',
    },
    'dd7c5stp': {
      'en': 'Keep your connection alive with a daily reminder.',
      'de': 'Haltet eure Verbindung mit einer täglichen Erinnerung aufrecht.',
      'es': 'Mantén vuestra conexión viva con un recordatorio diario.',
    },
    's9hqatta': {
      'en': 'Travel Tracking',
      'de': 'Reiseverfolgung',
      'es': 'Seguimiento del viaje',
    },
    't0wpsozx': {
      'en': 'Enables GPS travel tracking',
      'de': 'Aktiviert die GPS-Reiseverfolgung',
      'es': 'Activa el seguimiento del viaje por GP',
    },
    '4jypingt': {
      'en': 'Mute all',
      'de': 'Alles stumm schalten',
      'es': 'Silenciar todo',
    },
    'je33r8tm': {
      'en': 'Turns off all notifications',
      'de': 'Schaltet alle Benachrichtigungen aus',
      'es': 'Desactiva todas las notificaciones',
    },
    '8j7ekbhz': {
      'en': 'Relationship',
      'de': 'Beziehung',
      'es': 'Relación',
    },
    'cd0e8y1m': {
      'en': 'Connect to your Partner',
      'de': 'Mit Partner verbinden',
      'es': 'Conectarte con tu pareja',
    },
    '2x5vw4m5': {
      'en': 'Make a connection to your Partner',
      'de': 'Stelle eine Verbindung zu deinem Partner her',
      'es': 'Establecer una conexión con tu pareja',
    },
    'awcdfas8': {
      'en': 'Disconnect from Partner',
      'de': 'Vom Partner trennen',
      'es': 'Desconectarte de tu pareja',
    },
    '82qs8obv': {
      'en': 'This will end your connection with your Partner',
      'de': 'Damit endet deine Verbindung zu deinem Partner',
      'es': 'Esto finalizará tu conexión con tu pareja',
    },
    'ozoxyccy': {
      'en': 'Support & Legal',
      'de': 'Support & Rechte',
      'es': 'Soporte y legal',
    },
    'fl6g6pmm': {
      'en': 'Terms & Privacy Policy',
      'de': 'AGB & Datenschutz',
      'es': 'Términos y privacidad',
    },
    'ot59l0mc': {
      'en': 'Contact Support',
      'de': 'Support kontaktieren',
      'es': 'Contactar con soporte',
    },
    '9lbklr2u': {
      'en': 'Tell your story',
      'de': 'Erzählt eure Geschichte',
      'es': 'Cuenta tu historia',
    },
    '8wo9nu9b': {
      'en': 'Logout',
      'de': 'Ausloggen',
      'es': 'Cerrar sesión',
    },
    '42k5einh': {
      'en': 'Delete account',
      'de': 'Account löschen',
      'es': 'Eliminar cuenta',
    },
    '3b730c4l': {
      'en': 'Me',
      'de': '',
      'es': '',
    },
  },
  // StatsPage
  {
    'ai8qoubs': {
      'en': 'Your Togly Journey',
      'de': 'Eure Togly Reise',
      'es': 'Tu viaje con Togly',
    },
    'hbc93zyc': {
      'en': 'Here\'s a look at your relationship milestones and memories',
      'de':
          'Hier ein Überblick über die Meilensteine ​​und Erinnerungen eurer Beziehung.',
      'es':
          'Aquí tienes un vistazo a los momentos y recuerdos más importantes de tu relación',
    },
    'w6g54hhn': {
      'en': 'Relationship Timeline',
      'de': 'Beziehungszeitleiste',
      'es': 'Línea de tiempo de la relación',
    },
    'ckeoccqy': {
      'en': 'Connected since',
      'de': 'Verbunden seitdem',
      'es': 'Conectados desde',
    },
    'h2px6t6b': {
      'en': 'Days connected',
      'de': 'Tage verbunden',
      'es': 'Días conectados',
    },
    'jlhlheu3': {
      'en': 'Next meeting in',
      'de': 'Nächstes Treffen in',
      'es': 'Próximo encuentro en',
    },
    '7abf1s74': {
      'en': 'Time zones apart',
      'de': 'Zeitzonen auseinander',
      'es': 'Diferencia horaria',
    },
    '88cnht6q': {
      'en': 'Kilometers away',
      'de': 'Kilometer entfernt',
      'es': 'kilómetros de distancia',
    },
    'f2i5vkyr': {
      'en': 'Interaction Statistics',
      'de': 'Interaktionsstatistik',
      'es': 'Estadísticas de interacción',
    },
    'k5r4vlsk': {
      'en': 'Daily Questions',
      'de': 'Tägliche Fragen',
      'es': 'Preguntas diarias',
    },
    'zsjm4zbe': {
      'en': 'Bucket list',
      'de': 'Bucket-Liste',
      'es': 'Lista de metas',
    },
    'o48w6dlc': {
      'en': 'Love Notes',
      'de': 'Liebesbotschaften',
      'es': 'Mensajes de amor',
    },
    'mw38m5pw': {
      'en': 'Wishes fulfilled',
      'de': 'Wünsche erfüllt',
      'es': 'Deseos cumplidos',
    },
    'h215ros5': {
      'en': 'Journey',
      'de': 'Reise',
      'es': 'Viaje',
    },
  },
  // HowItWorksPage
  {
    'ixt5p5ck': {
      'en': 'Welcome to Togly',
      'de': 'Willkommen bei Togly',
      'es': 'Bienvenido a Togly',
    },
    'dsxv7hjl': {
      'en':
          'Here\'s how we help couples stay connected no matter the distance.',
      'de':
          'So helfen wir Paaren, unabhängig von der Entfernung in Verbindung zu bleiben.',
      'es':
          'Así ayudamos a las parejas a mantenerse conectadas sin importar la distancia.',
    },
    '5nbmm7a8': {
      'en': 'Connect with Your Partner',
      'de': 'Mit Partner verbinden',
      'es': 'Conéctate con tu pareja',
    },
    'ieu18miy': {
      'en':
          'Use your unique code to pair with your partner and unlock shared features.',
      'de':
          'Verwende deinen Love-Code, um dich mit deinem Partner zu verbinden.',
      'es':
          'Usa tu código único para vincularte con tu pareja y desbloquear funciones compartidas.',
    },
    '6edmkegf': {
      'en': 'Daily Questions',
      'de': 'Tägliche Fragen',
      'es': 'Preguntas diarias',
    },
    'ho88bsuu': {
      'en':
          'Answer meaningful questions together, every day, to stay emotionally close.',
      'de':
          'Beantwortet jeden Tag gemeinsam sinnvolle Fragen, um die emotionale Nähe zu bewahren.',
      'es':
          'Respondan juntos preguntas significativas cada día para mantenerse emocionalmente cerca.',
    },
    'j1rw448m': {
      'en': '😊',
      'de': '😊',
      'es': '😊',
    },
    'ks4ugvw4': {
      'en': 'Mood Sharing & Sleep Status',
      'de': 'Stimmungsäußerung & Schlafstatus',
      'es': 'Estado de ánimo y estado de sueño',
    },
    'memcutl1': {
      'en':
          'Let your partner know how you feel and when you\'re heading to bed – instantly.',
      'de':
          'Teile deinem Partner sofort mit, wie du dich fühlst und wenn du schlafen gehst',
      'es':
          'Hazle saber a tu pareja cómo te sientes y cuándo te vas a dormir, al instante.',
    },
    'wwt77nya': {
      'en': 'Shared Wishlist',
      'de': 'Geteilte Wunschliste',
      'es': 'Lista de deseos compartida',
    },
    '9no81hts': {
      'en': 'Add dream gifts or special wishes – and surprise each other.',
      'de': 'Teilt eure Wünsche und überrascht euch gegenseitig.',
      'es':
          'Añadan regalos soñados o deseos especiales y sorpréndanse mutuamente.',
    },
    'ck7n0mgc': {
      'en': 'Shared Calendar',
      'de': 'Gemeinsamer Kalender',
      'es': 'Calendario compartido',
    },
    '6nxkpknk': {
      'en':
          'Plan your next meeting and save important relationship dates together.',
      'de':
          'Plant euer nächstes Treffen und haltet wichtige Termine für eure Beziehung gemeinsam fest.',
      'es':
          'Planifiquen su próximo encuentro y guarden juntos fechas importantes de su relación.',
    },
    '6ime0190': {
      'en': 'Gallery of Memories',
      'de': 'Galerie der Erinnerungen',
      'es': 'Galería de recuerdos',
    },
    'ejhwukyd': {
      'en': 'Keep your favorite pictures and create shared photo albums.',
      'de':
          'Bewahren eure Lieblingsbilder auf und erstellt gemeinsame Fotoalben.',
      'es': 'Guarden sus fotos favoritas y creen álbumes compartidos.',
    },
    '6ekii99x': {
      'en': 'Love Notes',
      'de': 'Liebesbotschaften',
      'es': 'Mensajes de amor',
    },
    'q5xnrx99': {
      'en':
          'Write sweet messages that are saved in your personal love journal.',
      'de': 'Schreibe liebevolle Botschaften  an deinen Partner',
      'es':
          'Escribe mensajes cariñosos que se guardan en tu diario personal de amor.',
    },
    'qjutmdgz': {
      'en': 'Shared Goal List',
      'de': 'Gemeinsame Zielliste',
      'es': 'Lista de metas compartidas',
    },
    'ptzfecwk': {
      'en': 'Achieve goals together or alone and stay up to date',
      'de': 'Erreicht eure Ziele gemeinsam',
      'es': 'Alcancen metas juntos o por separado y manténganse al día.',
    },
    'z6gq1u5s': {
      'en': 'Your Dashboard',
      'de': 'Gemeinsames Dashboard',
      'es': 'Tu panel principal',
    },
    'ka1iiur2': {
      'en': 'All features come together in one beautiful, shared dashboard.',
      'de':
          'Alle Funktionen sind in einem übersichtlichen, gemeinsamen Dashboard vereint.',
      'es': 'Todas las funciones se reúnen en un panel compartido y elegante.',
    },
    'berng87h': {
      'en': 'Let\'s get started',
      'de': 'Los geht\'s!',
      'es': 'Empecemos',
    },
  },
  // LogRegPage
  {
    'gyd3bvj4': {
      'en': 'TOGLY❤️',
      'de': 'TOGLY❤️',
      'es': 'TOGLY❤️',
    },
    'curqxvk7': {
      'en': 'Create Account',
      'de': 'Konto erstellen',
      'es': 'Crear cuenta',
    },
    '80f2yf47': {
      'en': 'Create Account',
      'de': 'Konto erstellen',
      'es': 'Crear cuenta',
    },
    'h4uzlhll': {
      'en': 'Let\'s get started by filling out the form below.',
      'de': 'Beginnen wir, indem du das untenstehende Formular ausfüllst.',
      'es': 'Comencemos completando el formulario a continuación.',
    },
    'bn3ej7fu': {
      'en': 'Email',
      'de': 'Email',
      'es': 'Correo electrónico',
    },
    'xdqr5cq7': {
      'en': 'Password',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    'ev5hr73n': {
      'en': 'Get Started',
      'de': 'Los geht\'s!',
      'es': 'Empezar',
    },
    'ccplim92': {
      'en': 'Log In',
      'de': 'Einloggen',
      'es': 'Iniciar sesión',
    },
    'fstyjr7g': {
      'en': 'Welcome Back',
      'de': 'Willkommen zurück',
      'es': 'Bienvenido de nuevo',
    },
    '41y63o8y': {
      'en': 'Fill out the information below in order to access your account.',
      'de':
          'Fülle die folgenden Informationen aus, um auf dein Konto zugreifen zu können.',
      'es': 'Completa la información a continuación para acceder a tu cuenta.',
    },
    'erz6qfqb': {
      'en': 'Email',
      'de': 'Email',
      'es': 'Correo electrónico',
    },
    'f7oywss1': {
      'en': 'Password',
      'de': 'Passwort',
      'es': 'Contraseña',
    },
    'bdirpwjp': {
      'en': 'Sign In',
      'de': 'Anmelden',
      'es': 'Iniciar sesión',
    },
    '3hzwa9y0': {
      'en': 'Forgot Password?',
      'de': 'Passwort vergessen?',
      'es': '¿Olvidaste tu contraseña?',
    },
    'k69m15rs': {
      'en': 'Home',
      'de': 'Start',
      'es': 'Inicio',
    },
  },
  // ForgotPassword
  {
    'bna5d82p': {
      'en': 'Back',
      'de': 'Zurück',
      'es': 'Volver',
    },
    'ydv2k22j': {
      'en': 'Forgot Password',
      'de': 'Passwort vergessen',
      'es': '¿Olvidaste tu contraseña?',
    },
    'cz2ggx1s': {
      'en':
          'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
      'de':
          'Wir senden dir eine E-Mail mit einem Link zum Zurücksetzen deines Passworts. Bitte gebe unten die mit deinem Konto verknüpfte E-Mail-Adresse ein.',
      'es':
          'Te enviaremos un correo electrónico con un enlace para restablecer tu contraseña. Introduce a continuación el correo electrónico asociado a tu cuenta.',
    },
    '9gbxh7jr': {
      'en': 'Your email address...',
      'de': 'Deine E-Mail-Adresse...',
      'es': 'Tu correo electrónico…',
    },
    'g6xd0s2a': {
      'en': 'Enter your email...',
      'de': 'Geben deine E-Mail-Adresse ein...',
      'es': 'Introduce tu correo electrónico…',
    },
    'plfixoy4': {
      'en': 'Send Link',
      'de': 'Link senden',
      'es': 'Enviar enlace',
    },
    'wapxqyjc': {
      'en': 'Home',
      'de': 'Home',
      'es': 'Inicio',
    },
  },
  // ConnectV2
  {
    '9d7myf4t': {
      'en': 'Connect with Your Partner',
      'de': 'Verbinde dich mit deinem Partner',
      'es': 'Conéctate con tu pareja',
    },
    'ucodv1h9': {
      'en':
          'Send a connection request by entering your partner\'s code or send yours.',
      'de':
          'Sende eine Verbindungsanfrage, indem du den Code deines Partners eingibst oder deinen eigenen Code teilst.',
      'es':
          'Envía una solicitud de conexión introduciendo el código de tu pareja o compartiendo el tuyo.',
    },
    '4j6lwr0m': {
      'en': 'Status',
      'de': 'Status',
      'es': 'Estado',
    },
    '804633h6': {
      'en': 'request received from:',
      'de': 'Anfrage erhalten von:',
      'es': 'solicitud recibida de:',
    },
    '50hdwxzl': {
      'en': 'Accept',
      'de': 'Akzeptieren',
      'es': 'Aceptar',
    },
    'mk44q5u7': {
      'en': 'Reject',
      'de': 'Ablehnen',
      'es': 'Rechazar',
    },
    'he7cuxiu': {
      'en': 'or',
      'de': 'oder',
      'es': 'o',
    },
    'vmxm8g2w': {
      'en': 'you are currently connected with:',
      'de': 'Du bist aktuell verbunden mit:',
      'es': 'Actualmente estás conectado con:',
    },
    '4eb0i0ss': {
      'en': 'Back to home',
      'de': 'Zurück zur Startseite',
      'es': 'Volver al inicio',
    },
    'qe2eex57': {
      'en': 'Your love code',
      'de': 'Dein Liebescode',
      'es': 'Tu código de amor',
    },
    'kdzt0v8q': {
      'en': ' Tap the copy icon to copy your code',
      'de': 'Tippe auf das Kopiersymbol, um deinen Code zu kopieren.',
      'es': 'Toca el icono de copiar para copiar tu código',
    },
    '452v68fq': {
      'en': 'or',
      'de': 'oder',
      'es': 'o',
    },
    'vef9gagv': {
      'en': 'Enter the full Partners love code',
      'de': 'Gebe den vollständigen Partner-Liebescode ein',
      'es': 'Introduce el código de amor completo de tu pareja',
    },
    '0u59vxie': {
      'en': 'Enter code here...',
      'de': 'Code hier eingeben...',
      'es': 'Introduce el código aquí…',
    },
    'zaflg3oi': {
      'en': 'Enter code here... is required',
      'de': 'Hier Code eingeben... ist erforderlich',
      'es': 'Es obligatorio introducir el código aquí',
    },
    'rd80auuc': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    'ncbyil95': {
      'en': 'Send request',
      'de': 'Anfrage senden',
      'es': 'Enviar solicitud',
    },
    'cskwlg9s': {
      'en': 'Cancel request',
      'de': 'Anfrage abbrechen',
      'es': 'Cancelar solicitud',
    },
    'w2qeqfh5': {
      'en': 'Once connected, you\'ll both appear on each other\'s dashboard.',
      'de':
          'Sobald die Verbindung hergestellt ist, werdet ihr beide im Dashboard des jeweils anderen angezeigt.',
      'es':
          'Una vez conectados, ambos aparecerán en el panel principal del otro.',
    },
    'juxtj1mh': {
      'en': 'Partner Connect',
      'de': 'Partner verbinden',
      'es': 'Conectar con la pareja',
    },
  },
  // connect
  {
    '3m67hksv': {
      'en': 'Daily Question',
      'de': 'Tägliche Frage',
      'es': 'Pregunta diaria',
    },
    'rw801e5j': {
      'en': 'Answer Now',
      'de': 'Jetzt beantworten',
      'es': 'Responder ahora',
    },
    'mt8bq9ys': {
      'en': 'How are you feeling?',
      'de': 'Wie fühlst du dich gerade?',
      'es': '¿Cómo te sientes ahora?',
    },
    '1uxvylz0': {
      'en': '😁',
      'de': '😁',
      'es': '😁',
    },
    'kufpw2ok': {
      'en': '😏',
      'de': '😏',
      'es': '😏',
    },
    'l5d0n0fi': {
      'en': '😎',
      'de': '😎',
      'es': '😎',
    },
    '2ytecbxi': {
      'en': '😍',
      'de': '😍',
      'es': '😍',
    },
    'hfw3gux2': {
      'en': '💪',
      'de': '💪',
      'es': '💪',
    },
    'fd1o97e8': {
      'en': '💩',
      'de': '💩',
      'es': '💩',
    },
    'lv73uisu': {
      'en': '🤒',
      'de': '🤒',
      'es': '🤒',
    },
    'vwfb16xl': {
      'en': '😭',
      'de': '😭',
      'es': '😭',
    },
    'fdjj0fpn': {
      'en': '😡',
      'de': '😡',
      'es': '😡',
    },
    '11uuwym2': {
      'en': '😓',
      'de': '😓',
      'es': '😓',
    },
    'frcagdon': {
      'en': 'Sleep Status:',
      'de': 'Schlafstatus',
      'es': 'Estado de sueño',
    },
    'muz0kv3l': {
      'en': 'Home',
      'de': 'Start',
      'es': 'Inicio',
    },
    '9svrhj4h': {
      'en': 'Journal',
      'de': 'Reise',
      'es': 'Diario',
    },
    'k755lpin': {
      'en': 'Gallery',
      'de': 'Galerie',
      'es': 'Galería',
    },
    'lvfth7vk': {
      'en': 'Calendar',
      'de': 'Kalender',
      'es': 'Calendario',
    },
    'q30t7hwq': {
      'en': 'Connect',
      'de': 'Start',
      'es': 'Inicio',
    },
  },
  // NewEmailPage
  {
    'v23mdnxb': {
      'en': 'Change Email Address',
      'de': 'E-Mail-Adresse ändern',
      'es': 'Cambiar dirección de correo electrónico',
    },
    'ig5ovm6u': {
      'en': 'Enter new email address',
      'de': 'Gib eine neue E-Mail-Adresse ein',
      'es': 'Introduce una nueva dirección de correo electrónico',
    },
    'wune4fgx': {
      'en': 'Confirm current password',
      'de': 'Bestätige dein aktuelles Passwort',
      'es': 'Confirma tu contraseña actual',
    },
    'm7whtvat': {
      'en': 'Update Email',
      'de': 'E-Mail aktualisieren',
      'es': 'Actualizar correo electrónico',
    },
    'aaqff8dp': {
      'en': 'You will receive an email with a verification link.',
      'de': 'Du erhältst eine E-Mail mit einem Bestätigungslink.',
      'es': 'Recibirás un correo electrónico con un enlace de verificación.',
    },
    'i8q2372l': {
      'en': 'E-Mail Settings',
      'de': 'E-Mail-Einstellungen',
      'es': 'Configuración de correo electrónico',
    },
  },
  // NewPasswordPage
  {
    'nbhkpuy8': {
      'en': 'Change Password',
      'de': 'Passwort ändern',
      'es': 'Cambiar contraseña',
    },
    '7f2gwx6s': {
      'en': 'New Password',
      'de': 'Neues Passwort',
      'es': 'Nueva contraseña',
    },
    '10p2jwdw': {
      'en': 'Confirm New Password',
      'de': 'Bestätige dein neues Passwort',
      'es': 'Confirma tu nueva contraseña',
    },
    'f5yffyw8': {
      'en': 'Passwords must match and be at least 6 characters.',
      'de':
          'Passwörter müssen übereinstimmen und mindestens 6 Zeichen lang sein.',
      'es': 'Las contraseñas deben coincidir y tener al menos 6 caracteres.',
    },
    '4frr8ams': {
      'en': 'Update Password',
      'de': 'Passwort aktualisieren',
      'es': 'Actualizar contraseña',
    },
    'jr2g6r1e': {
      'en': 'New password',
      'de': 'Neues Passwort',
      'es': 'Nueva contraseña',
    },
  },
  // BrakeUpPage
  {
    'tjqbwfpl': {
      'en': '\"Every shared moment tells a story worth remembering.\"',
      'de':
          '„Jeder gemeinsame Moment erzählt eine Geschichte, die es wert ist, erinnert zu werden.“',
      'es':
          '“Cada momento compartido cuenta una historia que vale la pena recordar.”',
    },
    's7zvu8vp': {
      'en': '— Anonymous',
      'de': '— Anonym',
      'es': '— Anónimo',
    },
    'a34okeu6': {
      'en': 'Days Connected',
      'de': 'Tage verbunden',
      'es': 'Días conectados',
    },
    'duhotbtx': {
      'en': 'First Connection',
      'de': 'Erste Verbindung',
      'es': 'Primera conexión',
    },
    'uwe2gkwx': {
      'en': 'First Love Note',
      'de': 'Erste Liebesbotschaft',
      'es': 'Primer mensaje de amor',
    },
    'rh40hfw5': {
      'en': 'First Photo Shared',
      'de': 'Erstes Foto geteilt',
      'es': 'Primera foto compartida',
    },
    '3m2q00mw': {
      'en': 'Take a Moment to Reflect',
      'de': 'Nimm dir einen Moment Zeit zum Nachdenken.',
      'es': 'Tómate un momento para reflexionar',
    },
    'ja1arioo': {
      'en':
          'Before you disconnect, take a moment to remember your shared journey. The laughter, the growth, the moments you\'ve built together. Are you sure this is the end of your story?',
      'de':
          'Bevor du die Verbindung abbrichst, nimm dir einen Moment Zeit, um auf eure gemeinsame Reise zurückzublicken. Das Lachen, das Wachstum und die Momente, die ihr zusammen erlebt habt. Bist du sicher, dass dies das Ende eurer Geschichte ist?',
      'es':
          'Antes de desconectarte, tómate un momento para recordar vuestro camino juntos. Las risas, el crecimiento y los momentos que habéis compartido. ¿Estás seguro de que este es el final de vuestra historia?',
    },
    '3daiqcqg': {
      'en': 'Important Warning',
      'de': 'Wichtige Warnung',
      'es': 'Advertencia importante',
    },
    'sn1un8dl': {
      'en':
          'If you disconnect from your partner, all shared content (messages, photos, replies, statistics) will be scheduled for permanent deletion after 14 days.\nIf you reconnect within that period, your shared data will be restored, unless technical limitations or data loss occur beyond our control.\n\nPlease note: This process is automatic and cannot be guaranteed in every case. We recommend saving important memories beforehand.\n\nThis action cannot be undone.',
      'de':
          'Wenn du die Verbindung zu deinem Partner oder deiner Partnerin trennst, werden alle geteilten Inhalte (Nachrichten, Fotos, Antworten und Statistiken) nach 14 Tagen dauerhaft gelöscht.\n\nWenn ihr euch innerhalb dieses Zeitraums wieder verbindet, werden eure geteilten Daten wiederhergestellt – sofern keine technischen Einschränkungen oder Datenverluste auftreten, die außerhalb unserer Kontrolle liegen.\n\nBitte beachte: Dieser Vorgang erfolgt automatisch und kann nicht in jedem Fall garantiert werden. Wir empfehlen dir daher, wichtige Erinnerungen vorher zu sichern.\n\nDiese Aktion kann nicht rückgängig gemacht werden.',
      'es':
          'Si te desconectas de tu pareja, todo el contenido compartido\n(mensajes, fotos, respuestas y estadísticas) se eliminará\npermanentemente después de 14 días.\n\nSi os volvéis a conectar dentro de este período, los datos\ncompartidos se restaurarán, salvo limitaciones técnicas o\npérdidas de datos fuera de nuestro control.\n\nEste proceso es automático y no puede garantizarse en todos\nlos casos. Te recomendamos guardar los recuerdos importantes\ncon antelación.\n\nEsta acción no se puede deshacer.',
    },
    'czjt0xrk': {
      'en':
          'It\'s okay to let go. But it\'s also okay to hold on \n if your heart still does.',
      'de':
          'Loszulassen ist in Ordnung. Aber es ist auch in Ordnung, festzuhalten,\nwenn dein Herz noch daran hängt.',
      'es':
          'Está bien dejar ir, pero también está bien aferrarse si tu corazón aún lo siente.',
    },
    'lk5try99': {
      'en': 'Are you absolutely certain about this decision?',
      'de': 'Bist du dir dieser Entscheidung absolut sicher?',
      'es': '¿Estás completamente seguro de esta decisión?',
    },
    'jfg8cd1m': {
      'en': 'Disconnect Now',
      'de': 'Jetzt trennen',
      'es': 'Desconectar ahora',
    },
    'dslnw3yw': {
      'en': 'Maybe Not Right Now',
      'de': 'Vielleicht gerade noch nicht',
      'es': 'Quizá ahora no',
    },
  },
  // TermsPage
  {
    '36xfwyld': {
      'en': 'Terms & Privacy',
      'de': 'Bedingungen und Datenschutz',
      'es': '',
    },
    'emjzv50r': {
      'en': 'Terms & Conditions',
      'de': 'AGBs',
      'es': '',
    },
    '0ab39nlh': {
      'en': '1. Introduction',
      'de': '1. Einführung',
      'es': '',
    },
    'y578ievw': {
      'en':
          'Welcome to Togly! These terms govern your use of our platform designed to support couples in long-distance relationships. By using our service, you agree to these terms and conditions.',
      'de':
          'Willkommen bei Togly! Diese Nutzungsbedingungen regeln Ihre Nutzung unserer Plattform, die Paare in Fernbeziehungen unterstützt. Mit der Nutzung unseres Dienstes erklären Sie sich mit diesen Nutzungsbedingungen einverstanden.',
      'es': '',
    },
    'dxgdh31z': {
      'en': '2. User Responsibilities',
      'de': '2. Verantwortlichkeiten des Nutzers',
      'es': '',
    },
    'k65orcww': {
      'en':
          'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. Please use our platform respectfully and in accordance with applicable laws.',
      'de':
          'Sie sind für die Geheimhaltung Ihrer Zugangsdaten und für alle Aktivitäten, die über Ihr Konto erfolgen, verantwortlich. Bitte nutzen Sie unsere Plattform respektvoll und in Übereinstimmung mit den geltenden Gesetzen.',
      'es': '',
    },
    '7cdm7zju': {
      'en': '3. Acceptable Use',
      'de': '3. Zulässige Nutzung',
      'es': '',
    },
    '2i1vi1r8': {
      'en':
          'Our platform is intended for couples to connect and share meaningful moments. Prohibited activities include harassment, sharing inappropriate content, or using the service for commercial purposes without permission.',
      'de':
          'Unsere Plattform dient Paaren dazu, sich zu vernetzen und besondere Momente zu teilen. Verboten sind Belästigung, das Teilen unangemessener Inhalte und die unbefugte Nutzung des Dienstes zu kommerziellen Zwecken.',
      'es': '',
    },
    '05i3j6hf': {
      'en': '4. Account Termination',
      'de': '4. Kontokündigung',
      'es': '',
    },
    '502kthvd': {
      'en':
          'We reserve the right to suspend or terminate accounts that violate these terms. You may also delete your account at any time through the app settings. Upon termination, your data will be handled according to our privacy policy.',
      'de':
          'Wir behalten uns das Recht vor, Konten, die gegen diese Nutzungsbedingungen verstoßen, zu sperren oder zu kündigen. Sie können Ihr Konto jederzeit über die App-Einstellungen löschen. Nach der Kündigung werden Ihre Daten gemäß unserer Datenschutzrichtlinie behandelt.',
      'es': '',
    },
    'af44vawq': {
      'en': '5. Limitation of Liability',
      'de': '5. Haftungsbeschränkung',
      'es': '',
    },
    'tgj2jsic': {
      'en':
          'Togly is provided \'as is\' without warranties. We are not liable for any indirect, incidental, or consequential damages arising from your use of the platform. Our liability is limited to the maximum extent permitted by law.',
      'de':
          'Togly wird ohne Gewährleistung bereitgestellt. Wir haften nicht für indirekte, zufällige oder Folgeschäden, die durch Ihre Nutzung der Plattform entstehen. Unsere Haftung ist auf das gesetzlich zulässige Höchstmaß beschränkt.',
      'es': '',
    },
    '1qzk2i7o': {
      'en': '6. Changes to Terms',
      'de': '6. Änderungen der Nutzungsbedingungen',
      'es': '',
    },
    'dsf0bzik': {
      'en':
          'We may update these terms from time to time. When we do, we\'ll notify you through the app or via email. Continued use of the service after changes constitutes acceptance of the new terms.',
      'de':
          'Wir können diese Nutzungsbedingungen von Zeit zu Zeit aktualisieren. In diesem Fall benachrichtigen wir Sie über die App oder per E-Mail. Die fortgesetzte Nutzung des Dienstes nach Änderungen gilt als Zustimmung zu den neuen Nutzungsbedingungen.',
      'es': '',
    },
    '7ej3mfar': {
      'en': 'Privacy Policy',
      'de': 'Datenschutzrichtlinie',
      'es': '',
    },
    'r8gpbdsb': {
      'en': 'What Data We Collect',
      'de': 'Welche Daten wir sammeln',
      'es': '',
    },
    'qyj1w9pa': {
      'en':
          'We collect personal information you provide (name, email, timezone), shared content (messages, photos, daily question responses), and technical data (device info, usage analytics) to provide and improve our service.',
      'de':
          'Wir erfassen personenbezogene Daten, die Sie uns zur Verfügung stellen (Name, E-Mail-Adresse, Zeitzone), geteilte Inhalte (Nachrichten, Fotos, Antworten auf tägliche Fragen) und technische Daten (Geräteinformationen, Nutzungsanalysen), um unseren Service bereitzustellen und zu verbessern.',
      'es': '',
    },
    'pb2dohpc': {
      'en': 'Why We Collect It',
      'de': 'Warum wir es sammeln',
      'es': '',
    },
    '0g99ppcw': {
      'en':
          'Your data helps us provide personalized experiences, sync content between partners, send notifications across timezones, and improve our platform. We only collect what\'s necessary for these purposes.',
      'de':
          'Ihre Daten helfen uns, personalisierte Erlebnisse zu bieten, Inhalte zwischen Partnern zu synchronisieren, Benachrichtigungen über Zeitzonen hinweg zu versenden und unsere Plattform zu verbessern. Wir erheben nur die Daten, die für diese Zwecke notwendig sind.',
      'es': '',
    },
    'gay9tuse': {
      'en': 'How We Store & Secure It',
      'de': 'Wie wir es aufbewahren und sichern',
      'es': '',
    },
    '0iwkkcpy': {
      'en':
          'Your data is stored securely using Firebase with industry-standard encryption. We implement multiple security layers including secure authentication, encrypted data transmission, and regular security audits.',
      'de':
          'Ihre Daten werden mit Firebase und branchenüblicher Verschlüsselung sicher gespeichert. Wir setzen mehrere Sicherheitsebenen ein, darunter sichere Authentifizierung, verschlüsselte Datenübertragung und regelmäßige Sicherheitsüberprüfungen.',
      'es': '',
    },
    'gmcedhdh': {
      'en': 'Data Sharing',
      'de': 'Datenaustausch',
      'es': '',
    },
    'ugqclpz8': {
      'en':
          'We don\'t sell your personal data. Information is only shared between connected partners within the app, with service providers who help us operate the platform, or when required by law.',
      'de':
          'Wir verkaufen Ihre personenbezogenen Daten nicht. Informationen werden nur zwischen verbundenen Partnern innerhalb der App, mit Dienstleistern, die uns beim Betrieb der Plattform unterstützen, oder wenn gesetzlich vorgeschrieben, ausgetauscht.',
      'es': '',
    },
    'zzixryrf': {
      'en': 'Your Rights',
      'de': 'Ihre Rechte',
      'es': '',
    },
    'phxuf4yq': {
      'en':
          'You have the right to access, update, or delete your personal data. You can export your content, disconnect from your partner, or permanently delete your account through the app settings at any time.',
      'de':
          'Sie haben das Recht, Ihre personenbezogenen Daten einzusehen, zu aktualisieren oder zu löschen. Sie können Ihre Inhalte exportieren, die Verbindung zu Ihrem Partner trennen oder Ihr Konto jederzeit über die App-Einstellungen endgültig löschen.',
      'es': '',
    },
    'wdttojr1': {
      'en': 'Data Retention',
      'de': 'Datenaufbewahrung',
      'es': '',
    },
    '7rulw3l4': {
      'en':
          'When you disconnect from your partner, shared data is retained for 14 days to allow reconnection. After this period, shared content is permanently deleted. Personal account data is retained until you delete your account.',
      'de':
          'Wenn Sie die Verbindung zu Ihrem Partner trennen, werden die gemeinsam genutzten Daten 14 Tage lang gespeichert, um eine erneute Verbindung zu ermöglichen. Nach Ablauf dieser Frist werden die geteilten Inhalte endgültig gelöscht. Ihre persönlichen Kontodaten bleiben so lange gespeichert, bis Sie Ihr Konto löschen.',
      'es': '',
    },
    '5s51eivh': {
      'en': 'Contact Us',
      'de': 'Kontaktieren Sie uns',
      'es': '',
    },
    'aka629ka': {
      'en':
          'For questions about these policies or your data, please contact us at privacy@gettogly.com. We\'re committed to addressing your concerns promptly and transparently.',
      'de':
          'Bei Fragen zu diesen Richtlinien oder Ihren Daten kontaktieren Sie uns bitte unter privacy@gettogly.com. Wir sind bestrebt, Ihre Anliegen umgehend und transparent zu bearbeiten.',
      'es': '',
    },
    'conu50fw': {
      'en': 'Last updated: December 2025',
      'de': 'Letzte Aktualisierung: Dezember 2025',
      'es': '',
    },
    'ishga91t': {
      'en':
          'These policies may be updated periodically. We\'ll notify you of any significant changes.',
      'de':
          'Diese Richtlinien können regelmäßig aktualisiert werden. Wir werden Sie über alle wesentlichen Änderungen informieren.',
      'es': '',
    },
  },
  // SupportPage
  {
    '0tbqpbq5': {
      'en':
          'Need help or do you have an idea? We are here for you. Send us a message and we\'ll get back to you as soon as possible. 💜',
      'de':
          'Brauchst du Hilfe oder hast du eine Idee? Wir sind für dich da. Schreib uns einfach eine Nachricht und wir melden uns schnellstmöglich zurück. 💜',
      'es':
          '¿Necesitas ayuda o tienes una idea? Estamos aquí para ti. Escríbenos un mensaje y nos pondremos en contacto contigo lo antes posible. 💜',
    },
    'vkzg9pdw': {
      'en': 'Full Name',
      'de': 'Vollständiger Name',
      'es': 'Nombre completo',
    },
    'a2ljqkz7': {
      'en': 'Enter your full name',
      'de': 'Gebe deinenvollständigen Namen ein',
      'es': 'Introduce tu nombre completo',
    },
    'fq1lrq4f': {
      'en': 'Email Address',
      'de': 'E-Mail-Adresse',
      'es': 'Dirección de correo electrónico',
    },
    '8itij83w': {
      'en': 'your.email@example.com',
      'de': 'Ihre.email@example.com',
      'es': 'tu.email@ejemplo.com',
    },
    '9oefp78q': {
      'en': 'Subject',
      'de': 'Grund',
      'es': 'Asunto',
    },
    '8rpngel4': {
      'en': 'What can we help you with?',
      'de': 'Womit können wir dir  helfen?',
      'es': '¿En qué podemos ayudarte?',
    },
    'j3kgcslh': {
      'en': 'Message',
      'de': 'Nachricht',
      'es': 'Mensaje',
    },
    '66oqdn9k': {
      'en': 'Tell us more about your question or issue...',
      'de': 'Beschreibe uns dein Problemoder deine Idee genauer …',
      'es': 'Cuéntanos más sobre tu pregunta o problema…',
    },
    'dtlvb02p': {
      'en': 'priority',
      'de': 'Priorität',
      'es': 'Prioridad',
    },
    '8bik8xit': {
      'en': 'Low',
      'de': 'Niedrig',
      'es': 'Baja',
    },
    '31ucwdb6': {
      'en': 'priority...',
      'de': 'Priorität...',
      'es': 'Prioridad…',
    },
    '2c2oabhm': {
      'en': 'Search...',
      'de': 'Suchen...',
      'es': 'Buscar…',
    },
    '4c6crxpn': {
      'en': 'Low',
      'de': 'Niedrig',
      'es': 'Baja',
    },
    'm9d0u37m': {
      'en': 'Middle',
      'de': 'Mittel',
      'es': 'Media',
    },
    'tw06ybvj': {
      'en': 'High',
      'de': 'Hoch',
      'es': 'Alta',
    },
    'hkrwiisn': {
      'en': 'Send Message',
      'de': 'Nachricht senden',
      'es': 'Enviar mensaje',
    },
    'ul1dfrsm': {
      'en': 'Full Name is required',
      'de': 'Der vollständige Name ist erforderlich',
      'es': 'El nombre completo es obligatorio',
    },
    'xfgc5goc': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
    },
    'v4my6dm8': {
      'en': 'Email Address is required',
      'de': 'E-Mail-Adresse ist erforderlich',
      'es': 'La dirección de correo electrónico es obligatoria',
    },
    '0mvsouyu': {
      'en': '',
      'de': '',
      'es': '',
    },
    'eptw7jmd': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    '9x85qu4q': {
      'en': 'Subject is required',
      'de': 'Betreff ist erforderlich',
      'es': 'El asunto es obligatorio',
    },
    '51vgfagp': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    'ur6zyacn': {
      'en': 'Message is required',
      'de': 'Nachricht ist erforderlich',
      'es': 'El mensaje es obligatorio',
    },
    'hssg6a55': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    'wgciait5': {
      'en':
          'Thank you! Your message has been sent. We\'ll get back to you soon! 💕',
      'de':
          'Danke! Deine Nachricht wurde erfolgreich gesendet. Wir melden uns bald bei dir! 💕',
      'es':
          '¡Gracias! Tu mensaje ha sido enviado. Nos pondremos en contacto contigo muy pronto. 💕',
    },
    'ju5p0g9z': {
      'en': 'See Common Questions',
      'de': 'Siehe Häufige Fragen',
      'es': 'Ver preguntas frecuentes',
    },
    'ebdo4osg': {
      'en': 'Or email us directly at\nsupport@gettogly.com',
      'de': 'Oder sende uns direkt eine E-Mail an\nsupport@gettogly.com',
      'es': 'O escríbenos directamente a support@gettogly.com',
    },
    '6ed7t154': {
      'en': 'Contact Support',
      'de': 'Support kontaktieren',
      'es': 'Contactar con soporte',
    },
  },
  // ShareYourStory
  {
    's87w9zm5': {
      'en': 'Tell Us Your Story',
      'de': 'Erzählt uns eure Geschichte',
      'es': 'Cuéntanos tu historia',
    },
    'bmd8kahd': {
      'en': 'Every love story is unique.',
      'de': 'Jede Liebesgeschichte ist einzigartig.',
      'es': 'Cada historia de amor es única.',
    },
    'h9xsmrxw': {
      'en':
          'Tell us how Togly fits into yours and help other couples on their journey.',
      'de':
          'Teile mit uns, wie Togly euch begleitet, und inspiriere andere Paare auf ihrem Weg',
      'es':
          'Cuéntanos cómo Togly encaja en tu historia y ayuda a otras parejas en su camino.',
    },
    'nsi21vxi': {
      'en': 'Your Love Story',
      'de': 'Eure  Liebesgeschichte',
      'es': 'Vuestra historia de amor',
    },
    'gctx8tr2': {
      'en':
          'Share your journey - how did you meet? What makes your relationship special?',
      'de':
          'Erzählt eure Geschichte: Wie habt ihr euch kennengelernt? Welche Hindernisse musstet ihr überwinden?',
      'es':
          'Comparte vuestra historia: ¿cómo os conocisteis? ¿Qué hace especial vuestra relación?',
    },
    'dzc6gtud': {
      'en': 'Tell us about your relationship journey...',
      'de': 'Erzähl uns eure gemeinsame Geschichte …',
      'es': 'Cuéntanos sobre vuestra historia como pareja…',
    },
    'sqcspxib': {
      'en': 'Countries and cities',
      'de': 'Länder und Städte',
      'es': 'Países y ciudades',
    },
    '9a6m6m9w': {
      'en': 'In which countries and cities do you both live?',
      'de': 'In welchem ​​Land und in welchen Städten wohnt ihr beide?',
      'es': '¿En qué países y ciudades vivís ambos?',
    },
    'bgjkwtu7': {
      'en': 'countries and cities...',
      'de': 'Länder und Städte...',
      'es': 'países y ciudades…',
    },
    '8rawt1ae': {
      'en': 'Your names',
      'de': 'Eure Namen',
      'es': 'Vuestros nombres',
    },
    'nfsk6ueq': {
      'en': 'What is your and your partner\'s name?',
      'de':
          'Wie lauten dein Name und der Name deines Partners oder deiner Partnerin?',
      'es': '¿Cómo te llamas tú y cómo se llama tu pareja?',
    },
    'igh017la': {
      'en': 'Tell us your names...',
      'de': 'Nennt uns eure Namen...',
      'es': 'Decidnos vuestros nombres…',
    },
    'd902hv6u': {
      'en': 'E-mail address',
      'de': 'E-Mail-Adresse',
      'es': 'Correo electrónico',
    },
    '0hjjgrz4': {
      'en': 'What is your email address so we can contact you?',
      'de':
          'Wie lautet deine E-Mail-Adresse, damit wir dich kontaktieren können?',
      'es':
          '¿Cuál es tu dirección de correo electrónico para que podamos contactarte?',
    },
    'w544bos1': {
      'en': 'Your email address...',
      'de': 'Deine E-Mail-Adresse...',
      'es': 'Tu dirección de correo electrónico…',
    },
    'o1iwcjp2': {
      'en': 'Your Experience',
      'de': 'Eure Erfahrung mit Togly',
      'es': 'Tu experiencia con togly',
    },
    'x25njqe1': {
      'en': 'How has Togly helped you feel closer to your partner?',
      'de': 'Wie hat Togly dir geholfen, dich deinem Partner näher zu fühlen?',
      'es': '¿Cómo te ha ayudado Togly a sentirte más cerca de tu pareja?',
    },
    'vekpmaam': {
      'en': 'Share how the app has impacted your relationship...',
      'de': 'Erzähl uns, wie die App eure Beziehung beeinflusst hat …',
      'es': 'Es obligatorio contar vuestra historia como pareja',
    },
    '8jnqlv77': {
      'en': 'Tell us about your relationship journey... is required',
      'de': 'Ist erforderlich',
      'es': 'Cuéntanos sobre tu recorrido relacional... es obligatorio',
    },
    '8rh8384q': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    'oz80qy36': {
      'en': 'countries and cities... is required',
      'de': 'Ist erforderlich',
      'es': 'Países y ciudades… es obligatorio',
    },
    '51hsvzj0': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    '0x1kslqk': {
      'en': 'Tell us your names... is required',
      'de': 'Ist erforderlich',
      'es': 'Los nombres son obligatorios',
    },
    '6o3swmps': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    'hxfce6sj': {
      'en': 'Your email address... is required',
      'de': 'Ist erforderlich',
      'es': 'La dirección de correo electrónico es obligatoria',
    },
    'ytbrdd3u': {
      'en': 'Check the input',
      'de': 'Überprüfe deine Eingabe',
      'es': 'Revisa los datos introducidos',
    },
    '1m2bt8lv': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    '2fy7ivcb': {
      'en': 'Share how the app has impacted your relationship... is required',
      'de': 'Ist erforderlich',
      'es': 'Es obligatorio explicar cómo la app ha impactado vuestra relación',
    },
    'qea4k90r': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    'jpy8xutu': {
      'en': 'Social media',
      'de': 'Social media',
      'es': 'Redes sociales',
    },
    'rwnqw4rk': {
      'en': 'Please tell us your social media accounts if you have',
      'de':
          'Teile uns bitte eure Social-Media-Konten mit, falls ihr welche habt.',
      'es': 'Por favor, indícanos tus redes sociales si tienes',
    },
    'myp0xpi7': {
      'en': 'Social media names...',
      'de': 'Social-Media-Namen...',
      'es': 'Nombres de redes sociales…',
    },
    'nxs5yop6': {
      'en': 'Picture',
      'de': 'Bild',
      'es': 'Imagen',
    },
    'yl6bz0lp': {
      'en': 'We would be happy to receive a picture from you both together',
      'de': 'Wir würden uns über ein gemeinsames Foto von euch beiden freuen.',
      'es': 'Nos encantaría recibir una foto vuestra juntos',
    },
    '1n0r93fk': {
      'en': 'Tap to add image',
      'de': 'Tippe, um ein Bild hinzuzufügen',
      'es': 'Toca para añadir una imagen',
    },
    'uxl2pxiq': {
      'en': 'Video',
      'de': 'Video',
      'es': 'Vídeo',
    },
    'nna1roy2': {
      'en': 'We would be happy to receive a video from you both together',
      'de':
          'Wir würden uns freuen, ein gemeinsames Video von euch beiden zu erhalten.',
      'es': 'Nos encantaría recibir un vídeo vuestro juntos',
    },
    'nez3bqnd': {
      'en': 'Tap to add video',
      'de': 'Tippe, um ein Video hinzuzufügen',
      'es': 'Toca para añadir un vídeo',
    },
    'akddi4nf': {
      'en': 'Tap to add video',
      'de': 'Tippe, um ein Video hinzuzufügen',
      'es': 'Toca para añadir un vídeo',
    },
    'wg0jrcag': {
      'en': 'Rate Your Experience',
      'de': 'Bewerte Togly',
      'es': 'Valora tu experiencia',
    },
    'put1331n': {
      'en': 'How would you rate your overall experience with Togly?',
      'de': 'Wie würdestdu deine Gesamterfahrung mit Togly bewerten?',
      'es': '¿Cómo valorarías tu experiencia general con Togly?',
    },
    '8uaxtth4': {
      'en': 'Suggestions & Wishes',
      'de': 'Vorschläge & Wünsche',
      'es': 'Sugerencias y deseos',
    },
    'jk8vntvn': {
      'en': 'What features would make Togly even better for couples like you?',
      'de': 'Welche Funktionen würden Togly noch besser machen?',
      'es':
          '¿Qué características harían que Togly fuera aún mejor para parejas como la vuestra?',
    },
    '1q0z9fuh': {
      'en': 'Share your ideas and suggestions...',
      'de': 'Teile  deine Ideen und Vorschläge mit...',
      'es': 'Comparte tus ideas y sugerencias…',
    },
    'cngvyoxg': {
      'en': 'Permission for public use',
      'de': 'Genehmigung zur öffentlichen Nutzung',
      'es': 'Permiso para uso público',
    },
    '5lg95fpn': {
      'en':
          'By checking the box you allow the Togly team to potentially use your story and any attached image and video for public purposes such as marketing, testimonials, or feature highlights in the app and on social media or on our website. We deeply value your trust personal details like your full name or email will never be shared without your explicit permission',
      'de':
          'Durch das Setzen des Häkchens erlaubst du dem Togly-Team, deine Geschichte sowie beigefügte Bilder und Videos gegebenenfalls für öffentliche Zwecke wie Marketing, Erfahrungsberichte oder Produktvorstellungen zu verwenden – innerhalb der App, in sozialen Medien oder auf unserer Website.\n\nWir schätzen dein Vertrauen sehr und geben persönliche Daten wie deinen vollständigen Namen oder deine E-Mail-Adresse niemals ohne deine ausdrückliche Zustimmung weiter.',
      'es':
          'Al marcar la casilla, permites al equipo de Togly utilizar tu historia y cualquier imagen o vídeo adjunto para fines públicos como marketing, testimonios o destacados de funciones en la app, en redes sociales o en nuestro sitio web. Valoramos profundamente tu confianza y nunca compartiremos datos personales como tu nombre completo o tu correo electrónico sin tu consentimiento explícito.',
    },
    '4q2mqggh': {
      'en': 'Share Your Story',
      'de': 'Teile eure Geschichte',
      'es': 'Compartir vuestra historia',
    },
  },
  // ComesNextPage
  {
    '342b7vrd': {
      'en': 'We are building this with you 💜',
      'de': 'Wir bauen Togly mit euch zusammen 💜',
      'es': 'Estamos construyendo esto contigo 💜',
    },
    'j1olxra8': {
      'en':
          'Here\'s a glimpse into the future of Togly  and what we\'re working on next.',
      'de':
          'Hier ein kleiner Einblick in die Zukunft von Togly und woran wir als Nächstes arbeiten.',
      'es':
          'Aquí tienes un pequeño adelanto del futuro de Togly y en lo que estamos trabajando a continuación.',
    },
    'c20wns2c': {
      'en': '🚀',
      'de': '🚀',
      'es': '🚀',
    },
    'fc9o1f0f': {
      'en': '😍',
      'de': '😍',
      'es': '😍',
    },
    'k5uh1y5r': {
      'en': '🎉',
      'de': '🎉',
      'es': '🎉',
    },
    '60pake22': {
      'en': '💜',
      'de': '💜',
      'es': '💜',
    },
    '0g09b04k': {
      'en': '🙏',
      'de': '🙏',
      'es': '🙏',
    },
    'k8gjdorm': {
      'en': 'Have an idea of your own?',
      'de': 'Hast du selbst eine Idee?',
      'es': '¿Tienes una idea propia?',
    },
    'mqyf20mp': {
      'en': 'Suggest a Feature',
      'de': 'Schlage eine Funktion vor',
      'es': 'Sugiere una función',
    },
  },
  // DailyQuestionsJournal
  {
    'ymwiat57': {
      'en': 'Your past questions and answers',
      'de': 'Eure bisherigen Fragen und Antworten',
      'es': 'Tus preguntas y respuestas anteriores',
    },
    '8wdzm0g0': {
      'en': 'You said',
      'de': 'Deine Antwort',
      'es': 'Tú dijiste',
    },
    'bbq5m6to': {
      'en': 'Your partner said',
      'de': 'Partner Antwort',
      'es': 'Tu pareja dijo',
    },
    '1myaq7cm': {
      'en': 'Daily Questions',
      'de': 'Tägliche Fragen',
      'es': 'Preguntas diarias',
    },
  },
  // CompletedWishes
  {
    '1urubfcu': {
      'en': 'Link',
      'de': 'Link',
      'es': 'Enlace',
    },
    'djcosqe4': {
      'en': '✅',
      'de': '✅',
      'es': '',
    },
    'ec3vpitv': {
      'en': 'Completed at:',
      'de': 'Erledigt am:',
      'es': 'Completado en:',
    },
    'h1n9d7et': {
      'en': 'Wishes we\'ve already made happen.',
      'de': 'Wünsche, die wir bereits erfüllt haben.',
      'es': 'Deseos que ya hemos hecho realidad.',
    },
  },
  // AlbumDetailPage
  {
    'x8m6rqbg': {
      'en': 'Long tap on an image to delete it or download it',
      'de': 'Tippe lange auf ein Bild, um es zu löschen oder herunterzuladen.',
      'es': 'Mantén pulsada una imagen para eliminarla o descargarla',
    },
  },
  // GaleryPage
  {
    'y88unzi5': {
      'en': 'Shared Gallery',
      'de': 'Gemeinsame Galerie',
      'es': 'Galería compartida',
    },
    'ow16jpfi': {
      'en': 'Your favorite memories, \nall in one place together.',
      'de': 'Eure schönsten Erinnerungen, \nalle an einem Ort vereint.',
      'es': 'Tus recuerdos favoritos, todos juntos en un solo lugar.',
    },
    '8g54uxzh': {
      'en': 'Albums',
      'de': 'Alben',
      'es': 'Álbumes',
    },
    '8soylblb': {
      'en': 'Create Album',
      'de': 'Album erstellen',
      'es': 'Crear álbum',
    },
    'tkwonjk8': {
      'en': 'All Photos',
      'de': 'Alle Bilder',
      'es': 'Todas las fotos',
    },
    'zli4v3d0': {
      'en': 'No photos yet',
      'de': 'Noch keine Fotos',
      'es': 'Aún no hay fotos',
    },
    '3pabtq81': {
      'en': 'create your first album and upload at least one picture',
      'de': 'Erstellt euer erstes Album und ladet mindestens ein Bild hoch.',
      'es': 'Crea tu primer álbum y sube al menos una foto',
    },
    'fbz9hz6m': {
      'en': 'Gallery',
      'de': 'Galerie',
      'es': 'Galería',
    },
  },
  // LoveNotesArchive
  {
    'uxkzqau6': {
      'en': 'Love Notes Archive',
      'de': 'Liebesbotschaften-Archiv',
      'es': 'Archivo de mensajes de amor',
    },
    '7x9nm25h': {
      'en': 'Your love messages ✉️♥️',
      'de': 'Eure Liebesbotschaften ✉️♥️',
      'es': 'Tus mensajes de amor ✉️❤️',
    },
    '11q079hz': {
      'en': '💕',
      'de': '💕',
      'es': '💕',
    },
  },
  // GoalList
  {
    '1m6s2qvf': {
      'en': '🏆',
      'de': '🏆',
      'es': '🏆',
    },
    '7pe8jyai': {
      'en': 'No goals yet',
      'de': 'Noch keine Ziele',
      'es': 'Aún no hay objetivos',
    },
    '0nnzyrv8': {
      'en': 'Add a goal to see it here',
      'de': 'Füge ein Ziel hinzu, um es hier zu sehen.',
      'es': 'Añade un objetivo para verlo aquí',
    },
    'cw66n1ye': {
      'en': 'Our Goal List 💜',
      'de': 'Unsere Zielliste 💜',
      'es': 'Nuestra lista de objetivos 💜',
    },
    'nazwxesp': {
      'en': 'Big dreams, small steps',
      'de': 'Große Träume, kleine Schritte',
      'es': 'Grandes sueños, pequeños pasos',
    },
  },
  // BucketListCopy
  {
    'ambbszk4': {
      'en': 'Our Dream List 💜',
      'de': '',
      'es': '',
    },
    'zaw90sd1': {
      'en': 'Big dreams, small steps – together',
      'de': '',
      'es': '',
    },
    'u0xpnsmp': {
      'en': '🏠',
      'de': '',
      'es': '',
    },
    'xenfaeza': {
      'en': 'Buy Our Dream Home',
      'de': '',
      'es': '',
    },
    'p2ifvuw9': {
      'en': 'A cozy place with a garden where we can build our future together',
      'de': '',
      'es': '',
    },
    '6fpo1nuj': {
      'en': 'Completed ✨',
      'de': '',
      'es': '',
    },
    '3wjzzqj8': {
      'en': '✈️',
      'de': '',
      'es': '',
    },
    'lndfeliy': {
      'en': 'Paris Anniversary Trip',
      'de': '',
      'es': '',
    },
    'm570fjno': {
      'en':
          'Celebrate our love in the city of romance with croissants and sunset walks',
      'de': '',
      'es': '',
    },
    '4hpi7jbu': {
      'en': 'Saving up... 60% there!',
      'de': '',
      'es': '',
    },
    '8eis7hka': {
      'en': '🐕',
      'de': '',
      'es': '',
    },
    'po6nhlst': {
      'en': 'Adopt a Golden Retriever',
      'de': '',
      'es': '',
    },
    'obdmymic': {
      'en':
          'A furry friend to complete our little family and go on adventures with us',
      'de': '',
      'es': '',
    },
    '5n5p7yrc': {
      'en': 'Planning phase 🎯',
      'de': '',
      'es': '',
    },
    'uedvv3kn': {
      'en': '🍳',
      'de': '',
      'es': '',
    },
    'qvfhh78c': {
      'en': 'Learn to Cook Together',
      'de': '',
      'es': '',
    },
    'havkhi1r': {
      'en':
          'Master the art of making pasta from scratch and other delicious meals',
      'de': '',
      'es': '',
    },
    'ibdldgdb': {
      'en': 'Completed ✨',
      'de': '',
      'es': '',
    },
    'wsbq259d': {
      'en': '💍',
      'de': '',
      'es': '',
    },
    'thx15a84': {
      'en': 'Plan Our Dream Wedding',
      'de': '',
      'es': '',
    },
    'sehn3fhf': {
      'en':
          'A magical day surrounded by loved ones in a beautiful garden setting',
      'de': '',
      'es': '',
    },
    'nthwjsul': {
      'en': 'The big dream! 💕',
      'de': '',
      'es': '',
    },
  },
  // CompletedGoals
  {
    'euyvukxf': {
      'en': '🏆',
      'de': '🏆',
      'es': '🏆',
    },
    'gc2lskbd': {
      'en': 'No completed goals yet',
      'de': 'Noch keine abgeschlossenen Ziele',
      'es': 'Aún no hay objetivos completados',
    },
    'mexmk9xb': {
      'en': 'Finish a goal to see it here',
      'de': 'Schließe ein Ziel ab, um es hier zu sehen',
      'es': 'Completa un objetivo para verlo aquí',
    },
    'jtjak3vw': {
      'en': 'Completed on',
      'de': 'Abgeschlossen am',
      'es': 'Completado el',
    },
  },
  // WishesPageCopy
  {
    '5b9v58nm': {
      'en': 'Add',
      'de': '',
      'es': '',
    },
    'yg55w1ac': {
      'en': 'Shared Wishes',
      'de': '',
      'es': '',
    },
    'ks6w3c4s': {
      'en': 'Lets share 2getherly!',
      'de': '',
      'es': '',
    },
    '5itmi1lv': {
      'en': 'Link to the wish',
      'de': '',
      'es': '',
    },
    'b14msfcf': {
      'en': 'Wishlist',
      'de': '',
      'es': '',
    },
  },
  // Restore
  {
    'xh1u0o0y': {
      'en': 'Don\'t lose your story.',
      'de': 'Verlieret nicht eure Geschichte.',
      'es': 'No pierdas tu historia.',
    },
    'rgvcw1h7': {
      'en':
          'You have a 14 day window to restore your relationship and keep all your shared memories.',
      'de':
          'Du hast 14 Tage Zeit, um eure Beziehung wiederherzustellen und all eure gemeinsamen Erinnerungen zu bewahren.',
      'es':
          'Tienes un plazo de 14 días para restaurar tu relación y conservar todos vuestros recuerdos compartidos.',
    },
    'xhhsbeqv': {
      'en':
          'We believe relationships deserve reflection. That’s why after a breakup, you can only reconnect with your ex or you start fresh after 14 days. This gives you both time to think, heal, and make conscious choices.',
      'de':
          'Wir sind der Meinung, dass Beziehungen Zeit zum Nachdenken brauchen. Deshalb kann man nach einer Trennung erst nach 14 Tagen wieder eine neue Verbindung beginnen. \n\nSo haben beide Seiten Zeit, nachzudenken, die Trennung zu verarbeiten und bewusste Entscheidungen zu treffen.',
      'es':
          'Creemos que las relaciones merecen reflexión. Por eso, después de una ruptura, solo podéis volver a conectar tras 14 días o empezar de nuevo. Esto les da a ambos tiempo para pensar, sanar y tomar decisiones conscientes.',
    },
    'mhol2uvr': {
      'en': 'Send a reconnect request',
      'de': 'Versöhnungsanfrage',
      'es': 'Enviar solicitud de reconciliación',
    },
    'afux9su0': {
      'en': 'Let your partner know you would like to restore the relationship',
      'de':
          'Teile deinem Partner mit, dass du die Verbindung wiederherstellen möchtest.',
      'es': 'Hazle saber a tu pareja que te gustaría restaurar la relación.',
    },
    'xgoyxhxg': {
      'en': 'Send request',
      'de': 'Anfrage senden',
      'es': 'Enviar solicitud',
    },
    'cwxx2nz5': {
      'en': 'Request sent \nwaiting…',
      'de': 'Anfrage gesendet...',
      'es': 'Solicitud enviada, esperando…',
    },
    'ivq6j875': {
      'en': 'Your partner will be notified',
      'de': 'Dein  Partner wird benachrichtigt.',
      'es': 'Tu pareja será notificada.',
    },
    'h66sq6rt': {
      'en': 'Cancel',
      'de': 'Abbrechen',
      'es': 'Cancelar',
    },
    'bwn16qsr': {
      'en': 'Reconnect request',
      'de': 'Versöhnungsanfrage',
      'es': 'Solicitud de reconciliación',
    },
    'ygz1n6r5': {
      'en': 'Accept the restore request from your partner?',
      'de': 'Die Versöhnungsanfrage deines Partners annehmen?',
      'es': '¿Aceptar la solicitud de restauración de tu pareja?',
    },
    'g7ugbc7v': {
      'en': 'Reject',
      'de': 'Ablehnen',
      'es': 'Rechazar',
    },
    '0vmy6xop': {
      'en': 'Accept',
      'de': 'Annehmen',
      'es': 'Aceptar',
    },
    'b5g5e174': {
      'en': 'Window expired',
      'de': 'Zeit ist abgelaufen!',
      'es': 'El plazo ha expirado.',
    },
    '8i4w3wpu': {
      'en': '14-day window has passed',
      'de': 'Die 14-tägige Frist ist abgelaufen.',
      'es': 'El plazo de 14 días ha finalizado.',
    },
    'uxxnl0d0': {
      'en': 'Start new connection',
      'de': 'Neue Verbindung starten',
      'es': 'Iniciar una nueva conexión',
    },
    'flbl642b': {
      'en': 'Request rejected',
      'de': 'Wiederherstellungsanfrage abgelehnt!',
      'es': 'Solicitud rechazada',
    },
    'zk3u30ff': {
      'en': 'Your partner rejected the request',
      'de': 'Dein Partner hat die Anfrage abgelehnt',
      'es': 'Tu pareja rechazó la solicitud.',
    },
    '2gymionf': {
      'en': 'Refresh',
      'de': 'Aktualisieren',
      'es': 'Actualizar',
    },
    'xfztfz4i': {
      'en': 'Restore Relationship',
      'de': 'Verbindung',
      'es': 'Restaurar relación',
    },
  },
  // RoadmapAdmin
  {
    '523k87bq': {
      'en': 'Roadmap Admin',
      'de': '',
      'es': '',
    },
    'i299xmw4': {
      'en': 'Feature Details',
      'de': '',
      'es': '',
    },
    '011kmqgq': {
      'en': 'Title',
      'de': '',
      'es': '',
    },
    'd6dc12zn': {
      'en': 'Enter feature title',
      'de': '',
      'es': '',
    },
    '3mzi0rn5': {
      'en': 'Description',
      'de': '',
      'es': '',
    },
    '6cu8xjdf': {
      'en': 'Describe the feature in detail',
      'de': '',
      'es': '',
    },
    'q4o3g6hp': {
      'en': 'Select Status',
      'de': '',
      'es': '',
    },
    '0cs5m342': {
      'en': 'Planned',
      'de': '',
      'es': '',
    },
    'i8nbcb3t': {
      'en': 'In Progress',
      'de': '',
      'es': '',
    },
    'gh5oh04o': {
      'en': 'Testing',
      'de': '',
      'es': '',
    },
    '77k51inp': {
      'en': 'Released',
      'de': '',
      'es': '',
    },
    'nzlfs5ul': {
      'en': 'Cancelled',
      'de': '',
      'es': '',
    },
    'ko0vlzvf': {
      'en': 'Bug/Error',
      'de': '',
      'es': '',
    },
    'ak2w3ac5': {
      'en': 'Fixed',
      'de': '',
      'es': '',
    },
    '5a3q09o6': {
      'en': 'Sort Order',
      'de': '',
      'es': '',
    },
    'oh9scuj2': {
      'en': '0',
      'de': '',
      'es': '',
    },
    'qt0aj5s5': {
      'en': 'When should the news be published?',
      'de': '',
      'es': '',
    },
    'pym1zdqs': {
      'en': 'Published',
      'de': '',
      'es': '',
    },
    'cx3bgrqn': {
      'en': 'Call to Action',
      'de': '',
      'es': '',
    },
    'jhj3rtoa': {
      'en': 'CTA Label',
      'de': '',
      'es': '',
    },
    'ilpxh37t': {
      'en': 'e.g., Learn More',
      'de': '',
      'es': '',
    },
    '1o1z5y39': {
      'en': 'CTA URL',
      'de': '',
      'es': '',
    },
    '4q8oprpj': {
      'en': 'https://example.com',
      'de': '',
      'es': '',
    },
    'vqpi7827': {
      'en': 'Release Text',
      'de': '',
      'es': '',
    },
    '5sf8tgyk': {
      'en': '',
      'de': '',
      'es': '',
    },
    '722mqfpz': {
      'en': 'Search...',
      'de': '',
      'es': '',
    },
    'lc09pvpj': {
      'en': 'Planned',
      'de': '',
      'es': '',
    },
    '6s4s12bz': {
      'en': 'In Progress',
      'de': '',
      'es': '',
    },
    'gxxek25x': {
      'en': 'Testing',
      'de': '',
      'es': '',
    },
    'bf7v8pa8': {
      'en': 'Released',
      'de': '',
      'es': '',
    },
    '5ytzddpa': {
      'en': 'Cancelled',
      'de': '',
      'es': '',
    },
    '52ly8sji': {
      'en': 'Bug/Error',
      'de': '',
      'es': '',
    },
    '58uis17l': {
      'en': 'Fixed',
      'de': '',
      'es': '',
    },
    '5saick21': {
      'en': 'Delete',
      'de': '',
      'es': '',
    },
    'f2t61t5z': {
      'en': 'Publish',
      'de': '',
      'es': '',
    },
    '7t8rzi2a': {
      'en': 'Feature Details',
      'de': '',
      'es': '',
    },
    'dvud6uyc': {
      'en': '',
      'de': '',
      'es': '',
    },
    'cpu8x927': {
      'en': 'Enter feature title',
      'de': '',
      'es': '',
    },
    'b6mzl2st': {
      'en': 'Description',
      'de': '',
      'es': '',
    },
    'dtjkxvin': {
      'en': 'Describe the feature in detail',
      'de': '',
      'es': '',
    },
    '0x98g8b9': {
      'en': '',
      'de': '',
      'es': '',
    },
    'zlgxwzjl': {
      'en': 'Planned',
      'de': '',
      'es': '',
    },
    'jvsfuj2a': {
      'en': 'In Progress',
      'de': '',
      'es': '',
    },
    'pvi5eacl': {
      'en': 'Testing',
      'de': '',
      'es': '',
    },
    'me4wzc0u': {
      'en': 'Released',
      'de': '',
      'es': '',
    },
    'x50vcgtz': {
      'en': 'Cancelled',
      'de': '',
      'es': '',
    },
    's0hnh032': {
      'en': 'Bug/Error',
      'de': '',
      'es': '',
    },
    'dta754tr': {
      'en': 'Fixed',
      'de': '',
      'es': '',
    },
    'q4dcxuij': {
      'en': 'Sort Order',
      'de': '',
      'es': '',
    },
    '5se4cup2': {
      'en': '0',
      'de': '',
      'es': '',
    },
    'y80a7w7g': {
      'en': 'Published',
      'de': '',
      'es': '',
    },
    'ed3s55yw': {
      'en': 'Call to Action',
      'de': '',
      'es': '',
    },
    'gbuxqcm8': {
      'en': 'CTA Label',
      'de': '',
      'es': '',
    },
    'nmlhc5ur': {
      'en': 'e.g., Learn More',
      'de': '',
      'es': '',
    },
    'izu8nwc3': {
      'en': 'CTA URL',
      'de': '',
      'es': '',
    },
    '7cj9wptz': {
      'en': 'https://example.com',
      'de': '',
      'es': '',
    },
    '6jnuooll': {
      'en': 'Release Text',
      'de': '',
      'es': '',
    },
    'aqyx9mk4': {
      'en': '',
      'de': '',
      'es': '',
    },
    'eln8dy0c': {
      'en': 'Search...',
      'de': 'Suchen...',
      'es': '',
    },
    '5vrpkmk2': {
      'en': 'Planned',
      'de': 'Geplant',
      'es': '',
    },
    'vvn7kh4x': {
      'en': 'In Progress',
      'de': 'Im Arbeit',
      'es': '',
    },
    'cnpojcsz': {
      'en': 'Testing',
      'de': 'Im Test',
      'es': '',
    },
    'a69i07hf': {
      'en': 'Released',
      'de': 'Veröffentlicht',
      'es': '',
    },
    'g3ajdnsv': {
      'en': 'Cancelled',
      'de': 'Abgesagt',
      'es': '',
    },
    'hb7f0w3v': {
      'en': 'Bug/Error',
      'de': 'Bug/Error',
      'es': '',
    },
    'i43p4v87': {
      'en': 'Fixed',
      'de': 'Gefixt',
      'es': '',
    },
    'gmf36s06': {
      'en': 'Delete',
      'de': 'Gelöscht',
      'es': '',
    },
    '162k4o0v': {
      'en': 'Edit',
      'de': 'Bearbeitet',
      'es': '',
    },
  },
  // donationPageV1
  {
    '3m7u8xtf': {
      'en': 'Support Togly 💜',
      'de': 'Unterstütze Togly 💜',
      'es': 'Apoya a Togly 💜',
    },
    '29o8hnf6': {
      'en':
          'I am one of you.\nI understand these challenges\nbecause i live them myself.\nTogly was created to grow into solutions \ntogether with you!\n\n✨ The Creator of Togly✨',
      'de':
          'Ich bin einer von euch.\nIch verstehe diese Herausforderungen,\nweil ich sie selbst erlebe.\nTogly wurde entwickelt, um gemeinsam mit euch Lösungen zu finden!\n\n✨ Der Gründer von Togly ✨',
      'es':
          'Soy uno de ustedes.\nEntiendo estos desafíos porque los vivo en carne propia.\nTogly fue creado para crecer y encontrar soluciones junto a ustedes.\n✨ El creador de Togly ✨',
    },
    'i5fq2dbo': {
      'en': 'Voluntary Personal Donation',
      'de': 'Freiwillige persönliche Spende',
      'es': 'Donación personal voluntaria',
    },
    'a98puqdf': {
      'en':
          'You can send a voluntary personal donation to support the creator of Togly.\nThis is not a purchase, not a subscription and not a payment for services.\nIt is a personal, optional gift to appreciate the development work behind the app.\n\nNo features will be unlocked and there is no compensation or benefit connected to a donation.\n\nThank you for your kindness and support. 💜',
      'de':
          'Du kannst dem Entwickler von Togly eine freiwillige Spende zukommen lassen.\nDies ist kein Kauf, kein Abonnement und keine Bezahlung für Dienstleistungen. Es handelt sich um eine persönliche, optionale Geste, um die Entwicklungsarbeit hinter der App zu würdigen.\n\nDurch die Spende werden keine Funktionen freigeschaltet und es entstehen keine Gegenleistungen oder Vorteile.\n\nVielen Dank für deine Unterstützung! 💜',
      'es':
          'Puedes enviar una donación personal voluntaria para apoyar al creador de Togly.\nEsto no es una compra, ni una suscripción, ni un pago por servicios.\nEs un gesto personal y opcional para valorar el trabajo de desarrollo detrás de la aplicación.\n\nNo se desbloqueará ninguna función ni habrá compensaciones o beneficios asociados a la donación.\n\nGracias por tu apoyo y generosidad. 💜',
    },
    'kdbs6dwj': {
      'en': 'Donate with Stripe',
      'de': 'Spende mit Stripe',
      'es': 'Donar con Stripe',
    },
    'stas6yny': {
      'en':
          '🔒 “This voluntary gift is not connected to Togly’s service availability, features or usage. The app can be used fully without donating.”',
      'de':
          '🔒 „Diese freiwillige Spende steht in keinem Zusammenhang mit der Verfügbarkeit, den Funktionen oder der Nutzung des Dienstes von Togly. Die App kann auch ohne Spende uneingeschränkt genutzt werden.“',
      'es': '',
    },
    'xpr95l3m': {
      'en': '💖 Buy me a coffee',
      'de': '💖 Einen Kaffee ausgeben',
      'es': '💖Invítame a un café',
    },
    'y3vfo7fl': {
      'en': 'A small gesture of love',
      'de': 'Eine kleine Geste der Liebe',
      'es': 'Un pequeño gesto de cariño',
    },
    '9surev52': {
      'en': '\$5',
      'de': '\$5',
      'es': '\$5',
    },
    '6tzdmts3': {
      'en': '✨Shine a little brighter',
      'de': '✨Leuchte ein bisschen heller',
      'es': '✨ Brilla un poco más',
    },
    'gk0pr9ab': {
      'en': 'Say thank you',
      'de': 'Sage \"Danke\"',
      'es': 'Decir gracias',
    },
    'a4cg36pd': {
      'en': '\$20',
      'de': '\$20',
      'es': '\$20',
    },
    'otaywc40': {
      'en': '💜 Big gesture of support',
      'de': '💜 Große Geste der Unterstützung',
      'es': '💜 Gran gesto de apoyo',
    },
    'anw8uhb2': {
      'en': 'Honor and pride',
      'de': 'Anerkennung',
      'es': 'Honor y orgullo',
    },
    'zmpwt6hx': {
      'en': '\$50',
      'de': '\$50',
      'es': '\$50',
    },
    'k80378vc': {
      'en': '💎 Custom stripe amount',
      'de': '💎 Andere Summe',
      'es': '💎Monto personalizado en Stripe',
    },
    '8nfn9aod': {
      'en': 'Enter amount',
      'de': 'Betrag eingeben',
      'es': 'Introducir monto',
    },
    'sokvmcxy': {
      'en': 'Donate Now →',
      'de': 'Jetzt spenden →',
      'es': 'Donar ahora →',
    },
    '76zkxlyo': {
      'en': ' Donate with PayPal',
      'de': 'Spenden mit  PayPal',
      'es': 'Donar con PayPal',
    },
    'osfjobtn': {
      'en': '💳 Donate with PayPal',
      'de': '💳 Spenden mit PayPal',
      'es': '💳 Donar con PayPal',
    },
    'a7prf8d4': {
      'en': 'Fast and secure contribution',
      'de': 'Schnell und sicher spenden',
      'es': 'Contribución rápida y segura',
    },
    '834yy7dg': {
      'en': 'Open PayPal',
      'de': 'PayPal öffnen',
      'es': 'Abrir PayPal',
    },
    'rbyjr2d2': {
      'en':
          'Donations are processed in USD.\nYour bank will automatically convert\n the amount to your local currency',
      'de':
          'Spenden werden in US-Dollar abgewickelt. Deine Bank rechnet den Betrag automatisch in deine Landeswährung um',
      'es':
          'Las donaciones se procesan en dólares estadounidenses (USD).\nTu banco convertirá automáticamente el monto a tu moneda local.',
    },
    'gv4qqsid': {
      'en': 'Secure Payment Methods',
      'de': 'Sichere Zahlungsmethoden',
      'es': 'Métodos de pago seguros',
    },
    'dl5j8374': {
      'en': '\"\"Thanks to Togly',
      'de': '„Vielen Dank an Togly',
      'es': '“Gracias a Togly”',
    },
    'k45dvlxj': {
      'en': '– A happy user ❤️',
      'de': '– Ein zufriedener Nutzer ❤️',
      'es': '- Un usuario feliz ❤️',
    },
    '8delte2u': {
      'en': 'Thank you for believing in me and the vision 💜',
      'de': 'Vielen Dank, dass du an mich und meine Vision glaubst💜',
      'es': 'Gracias por creer en mí y en esta visión 💜',
    },
    '7nk61mes': {
      'en': 'Your support means the world to couples everywhere',
      'de': 'Deine Unterstützung bedeutet Paaren weltweit unglaublich viel.',
      'es': 'Tu apoyo significa muchísimo para parejas en todo el mundo',
    },
    'nr7uvbcp': {
      'en': 'Donation',
      'de': 'Spende',
      'es': 'Donación',
    },
  },
  // feeeeedback
  {
    'dgr4hrtu': {
      'en': 'We love honest feedback',
      'de': 'Wir lieben ehrliches Feedback',
      'es': 'Nos encanta el feedback honesto',
    },
    '4legoifx': {
      'en':
          'Your feedback helps us improve the app experience and build features that matter most to you.',
      'de':
          'Dein Feedback hilft uns, die Nutzung der App zu verbessern und Funktionen zu entwickeln, die dir besonders wichtig sind.',
      'es':
          'Tu feedback nos ayuda a mejorar la experiencia de la app y a crear funciones que realmente te importan',
    },
    'vwy33zvq': {
      'en': 'What type of feedback do you have?',
      'de': 'Welche Art von Feedback hast du?',
      'es': '¿Qué tipo de feedback tienes?',
    },
    'nukg1c57': {
      'en': 'Select feedback type',
      'de': 'Wähle den Feedbacktyp aus',
      'es': 'Selecciona el tipo de feedback',
    },
    'bh27igsi': {
      'en': '🐛 Bug report',
      'de': '🐛 Fehlerbericht',
      'es': '🐛Reporte de error',
    },
    'g52gzrj4': {
      'en': '✨ Feature request',
      'de': '✨ Funktionswunsch',
      'es': '✨Solicitud de función',
    },
    'qr05qmmj': {
      'en': '💬 General feedback',
      'de': '💬 Allgemeines Feedback',
      'es': '💬Feedback general',
    },
    'v5yfka49': {
      'en': '❤️ Something I love',
      'de': '❤️ Etwas, das ich liebe',
      'es': '❤️Algo que me encanta',
    },
    'ls4esrwo': {
      'en': '💡 Something that could be better',
      'de': '💡 Etwas, das besser sein könnte',
      'es': '💡Algo que podría mejorar',
    },
    'wn5ss0va': {
      'en': 'Optional',
      'de': 'Optional',
      'es': 'Opcional',
    },
    '2c9hyb3r': {
      'en': 'How would you rate your overall experience?',
      'de': 'Wie würdest du deine Gesamterfahrung bewerten?',
      'es': '¿Cómo calificarías tu experiencia general?',
    },
    'yzyz8nlz': {
      'en': 'Tell us more about your experience',
      'de': 'Erzähl uns mehr über deine Erfahrungen mit der App',
      'es': 'Cuéntanos más sobre tu experiencia',
    },
    'mlut53kz': {
      'en':
          'Share your thoughts, suggestions, or describe any issues you\'ve encountered...',
      'de':
          'Teile deine Gedanken und Vorschläge mit uns oder beschreibe alle Probleme, auf die du gestoßen bist …',
      'es':
          'Comparte tus opiniones, sugerencias o describe cualquier problema que hayas encontrado…',
    },
    '44n70fbn': {
      'en': 'Email address',
      'de': 'E-Mail-Adresse',
      'es': 'Dirección de correo electrónico',
    },
    'ovz7eett': {
      'en': 'We only use this if we have any questions about your feedback',
      'de':
          'Wir verwenden diese E-Mail-Adresse nur, falls wir Rückfragen zu deinem Feedback haben.',
      'es': 'Solo usaremos esto si tenemos alguna pregunta sobre tu feedback',
    },
    'l108iaug': {
      'en': 'your.email@example.com',
      'de': 'Ihre.email@example.com',
      'es': 'tu.email@ejemplo.com',
    },
    'gytcthup': {
      'en': ' is required',
      'de': 'Ist erforderlich',
      'es': 'es obligatorio',
    },
    '039re5xy': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    'ihf3bk4a': {
      'en': ' is required',
      'de': 'Ist erforderlich',
      'es': 'es obligatorio',
    },
    '7zhg03cw': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    '44e5llxf': {
      'en': 'Send Feedback',
      'de': 'Feedback senden',
      'es': 'Enviar feedback',
    },
    'ot3uj1kk': {
      'en': 'Feedback',
      'de': 'Feedback',
      'es': 'Feedback',
    },
  },
  // homesingle
  {
    'emvaytfd': {
      'en': 'Dummy',
      'de': 'Dummy',
      'es': 'Dummy',
    },
    'ovpa80z8': {
      'en': 'Daily Question',
      'de': 'Tägliche Frage',
      'es': 'Pregunta diaria',
    },
    '3aovbbqh': {
      'en': 'Answer Now',
      'de': 'Jetzt beantworten',
      'es': 'Responder ahora',
    },
    'a9sc2h4f': {
      'en': 'How are you feeling?',
      'de': 'Wie fühlst du dich gerade?',
      'es': '¿Cómo te sientes ahora?',
    },
    'tau9oqa8': {
      'en': '😁',
      'de': '😁',
      'es': '😁',
    },
    'p583tu7m': {
      'en': '😏',
      'de': '😏',
      'es': '😏',
    },
    '8gfhvver': {
      'en': '😎',
      'de': '😎',
      'es': '😎',
    },
    'pvs5yyrj': {
      'en': '😍',
      'de': '😍',
      'es': '😍',
    },
    '7nelkvbm': {
      'en': '💪',
      'de': '💪',
      'es': '💪',
    },
    '5i6eyeoq': {
      'en': '💩',
      'de': '💩',
      'es': '💩',
    },
    'nb4qsmf4': {
      'en': '🤒',
      'de': '🤒',
      'es': '🤒',
    },
    'vhap5s9v': {
      'en': '😭',
      'de': '😭',
      'es': '😭',
    },
    'hrglekzh': {
      'en': '😡',
      'de': '😡',
      'es': '😡',
    },
    'hasgdvnq': {
      'en': '😓',
      'de': '😓',
      'es': '😓',
    },
    '6qg6qz85': {
      'en': 'Sleep Status',
      'de': 'Schlafstatus',
      'es': 'Estado de sueño',
    },
    'ft16wc8u': {
      'en': 'Sleeping',
      'de': 'Schlafen',
      'es': 'Durmiendo',
    },
    'afuxg5hj': {
      'en': 'Shared Wishlist',
      'de': 'Geteilte Wunschliste',
      'es': 'Lista de deseos compartida',
    },
    'ajmiyz0h': {
      'en': 'Shared Calendar',
      'de': 'Geteilter Kalender',
      'es': 'Calendario compartido',
    },
    'y4s63yce': {
      'en': 'Shared Gallery',
      'de': 'Geteilte Galerie',
      'es': 'Galería compartida',
    },
    'khdxb25z': {
      'en': 'Bucket\nList',
      'de': 'Bucket\nListe',
      'es': 'Lista de objetivos',
    },
    '87f0lqc4': {
      'en': 'Love Notes',
      'de': 'Liebesbotschaften',
      'es': 'Mensajes de amor',
    },
    '9gyj4xt0': {
      'en': '💡 See upcoming features',
      'de': '💡Roadmap',
      'es': '💡Hoja de ruta',
    },
    'aesezby2': {
      'en': '💜 Support Togly',
      'de': '💜 Supporte Togly',
      'es': '💜Apoyar a Togly',
    },
    'c4kyqbjo': {
      'en': 'Home',
      'de': 'Start',
      'es': 'Inicio',
    },
    '0tjzzzxc': {
      'en': 'Journal',
      'de': 'Reise',
      'es': 'Diario',
    },
    '3368pi0p': {
      'en': 'Gallery',
      'de': 'Galerie',
      'es': 'Galería',
    },
    'b5bqd1wq': {
      'en': 'Calendar',
      'de': 'Kalender',
      'es': 'Calendario',
    },
    'srfxmkpa': {
      'en': 'Home',
      'de': 'Start',
      'es': 'Inicio',
    },
  },
  // celebrate
  {
    'ouu566oc': {
      'en': 'You’re together again 💕',
      'de': 'Ihr seid wieder zusammen 💕',
      'es': 'Vuelven a estar juntos 💕',
    },
    'zprfbobu': {
      'en': 'Love always finds a way back ✨',
      'de': 'Die Liebe findet immer einen Weg zurück ✨',
      'es': 'El amor siempre encuentra la manera de volver ✨',
    },
  },
  // RestoreCopy
  {
    'myvotqjj': {
      'en': 'Don\'t lose your story.',
      'de': 'Verlieret nicht eure Geschichte.',
      'es': 'No pierdas tu historia.',
    },
    '4g4x5pio': {
      'en':
          'You have a 14 day window to restore your relationship and keep all your shared memories.',
      'de':
          'Du hast 14 Tage Zeit, um eure Beziehung wiederherzustellen und all eure gemeinsamen Erinnerungen zu bewahren.',
      'es':
          'Tienes un plazo de 14 días para restaurar tu relación y conservar todos vuestros recuerdos compartidos.',
    },
    'k40vuqyu': {
      'en':
          'We believe relationships deserve reflection. That’s why after a breakup, you can only reconnect with your ex or you start fresh after 14 days. This gives you both time to think, heal, and make conscious choices.',
      'de':
          'Wir sind der Meinung, dass Beziehungen Zeit zum Nachdenken brauchen. Deshalb kann man nach einer Trennung erst nach 14 Tagen wieder eine neue Verbindung beginnen. \n\nSo haben beide Seiten Zeit, nachzudenken, die Trennung zu verarbeiten und bewusste Entscheidungen zu treffen.',
      'es':
          'Creemos que las relaciones merecen reflexión. Por eso, después de una ruptura, solo podéis volver a conectar tras 14 días o empezar de nuevo. Esto les da a ambos tiempo para pensar, sanar y tomar decisiones conscientes.',
    },
    'nqwmstyb': {
      'en': 'Send a reconnect request',
      'de': 'Versöhnungsanfrage',
      'es': 'Enviar solicitud de reconciliación',
    },
    'dit29fn0': {
      'en': 'Let your partner know you would like to restore the relationship',
      'de':
          'Teile deinem Partner mit, dass du die Verbindung wiederherstellen möchtest.',
      'es': 'Hazle saber a tu pareja que te gustaría restaurar la relación.',
    },
    'q7vkhcp7': {
      'en': 'Send request',
      'de': 'Anfrage senden',
      'es': 'Enviar solicitud',
    },
    'c9cqxckt': {
      'en': 'Request sent \nwaiting…',
      'de': 'Anfrage gesendet...',
      'es': 'Solicitud enviada, esperando…',
    },
    '19gk1g9o': {
      'en': 'Your partner will be notified',
      'de': 'Dein  Partner wird benachrichtigt.',
      'es': 'Tu pareja será notificada.',
    },
    'n5kmym38': {
      'en': 'Cancel',
      'de': 'Abbrechen',
      'es': 'Cancelar',
    },
    's1lrs7ym': {
      'en': 'Reconnect request',
      'de': 'Versöhnungsanfrage',
      'es': 'Solicitud de reconciliación',
    },
    'mrl7t7jh': {
      'en': 'Accept the restore request from your partner?',
      'de': 'Die Versöhnungsanfrage deines Partners annehmen?',
      'es': '¿Aceptar la solicitud de restauración de tu pareja?',
    },
    't82wh7n5': {
      'en': 'Reject',
      'de': 'Ablehnen',
      'es': 'Rechazar',
    },
    'r3szlvso': {
      'en': 'Accept',
      'de': 'Annehmen',
      'es': 'Aceptar',
    },
    '2175xjag': {
      'en': 'Window expired',
      'de': 'Zeit ist abgelaufen!',
      'es': 'El plazo ha expirado.',
    },
    '5bte1jue': {
      'en': '14-day window has passed',
      'de': 'Die 14-tägige Frist ist abgelaufen.',
      'es': 'El plazo de 14 días ha finalizado.',
    },
    '3g3xav2l': {
      'en': 'Start new connection',
      'de': 'Neue Verbindung starten',
      'es': 'Iniciar una nueva conexión',
    },
    'p08ent7o': {
      'en': 'Request rejected',
      'de': 'Wiederherstellungsanfrage abgelehnt!',
      'es': 'Solicitud rechazada',
    },
    'ngbjq12x': {
      'en': 'Your partner rejected the request',
      'de': 'Dein Partner hat die Anfrage abgelehnt',
      'es': 'Tu pareja rechazó la solicitud.',
    },
    'rne9imso': {
      'en': 'Refresh',
      'de': 'Aktualisieren',
      'es': 'Actualizar',
    },
    '3e967nip': {
      'en': 'Restore Relationship',
      'de': 'Verbindung',
      'es': 'Restaurar relación',
    },
  },
  // S1_Hero
  {
    '54e2dmp6': {
      'en': 'Built for couples.\n Perfect for long distance.',
      'de': 'Für Paare entwickelt. \nPerfekt für Fernbeziehungen',
      'es': 'Hecho para parejas. \nPerfecto para relaciones a distancia',
    },
    'tzvcmu3p': {
      'en': 'Get Started',
      'de': 'Los gehts',
      'es': 'Comienza',
    },
    'eikyzwcq': {
      'en': 'Log In',
      'de': 'Einloggen',
      'es': 'Iniciar sesión',
    },
  },
  // S2_Story
  {
    'jktcxyyl': {
      'en': 'Strengthen your love',
      'de': 'Stärke eure Liebe',
      'es': 'Fortalece tu amor',
    },
    'gac4f4x5': {
      'en':
          'Discover meaningful ways to deepen your connection and build lasting memories together',
      'de':
          'Entdecke bedeutungsvolle Wege, um eure Verbindung zu vertiefen und gemeinsam bleibende Erinnerungen aufzubauen',
      'es':
          'Descubre formas significativas de profundizar tu conexión y crear recuerdos duraderos juntos',
    },
    'b6yc4d7h': {
      'en': 'Start your journey to a stronger relationship',
      'de': 'Starte deine Reise zu einer stärkeren Beziehung',
      'es': 'Comienza tu camino hacia una relación más fuerte',
    },
    'unyvzzrw': {
      'en': 'Companion',
      'de': 'Begleiter',
      'es': 'Compañero',
    },
    '5u6ijehr': {
      'en': 'Bring their world to life.',
      'de': 'Erweckt ihre Welt zum Leben.',
      'es': 'Den vida a su mundo.',
    },
    'q7puetvy': {
      'en': 'Heartbeat',
      'de': 'Herzschlag',
      'es': 'Latido del corazón',
    },
    'e4p4dy5r': {
      'en': 'Share your feelings',
      'de': 'Teilt eure Gefühle',
      'es': 'Comparte tus sentimientos',
    },
    'heh2olwd': {
      'en': 'Love Treasure',
      'de': 'Liebestruhe',
      'es': 'Cofre del amor',
    },
    '1ai6ffzj': {
      'en': 'Share secret surprises',
      'de': 'Teile geheime Überraschungen',
      'es': 'Comparte sorpresas secretas',
    },
    'hntvbx31': {
      'en': 'Continue 🩷',
      'de': 'Weiter 🩷',
      'es': 'Continuar 🩷',
    },
  },
  // S3_name
  {
    't8z127ru': {
      'en': 'How should we call you?',
      'de': 'Wie sollen wir dich nennen?',
      'es': '¿Cómo deberíamos llamarte?',
    },
    'vqw14zvl': {
      'en': 'This is how you’ll appear in Togly',
      'de': 'So wirst du in Togly angezeigt',
      'es': 'Así aparecerás en Togly',
    },
    '2ixt4gdw': {
      'en': '    Your name here...',
      'de': 'Dein Name hier …',
      'es': 'Tu nombre aquí…',
    },
    'nvxjzgk5': {
      'en': '    Your name here... is required',
      'de': '',
      'es': '',
    },
    'epley3jm': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
    },
    'd94zc2dp': {
      'en': 'Continue ➡️',
      'de': 'Weiter 🩷',
      'es': 'Continuar 🩷',
    },
  },
  // S4_partner
  {
    '4eoz1wrr': {
      'en': 'Connect with your partner',
      'de': 'Verbinde dich mit deinem Partner',
      'es': 'Conéctate con tu pareja',
    },
    'yj6vqt3m': {
      'en': 'Enter their Love Code or invite them later',
      'de': 'Gib seinen Liebescode ein oder lade ihn später ein',
      'es': 'Ingresa su código de amor o invítalo más tarde',
    },
    'bl2n24kz': {
      'en': 'LOVE-123456',
      'de': 'LOVE-123456',
      'es': 'LOVE-123456',
    },
    'zeyu1p0a': {
      'en': 'Send request 🩷',
      'de': 'Anfrage senden 🩷',
      'es': 'Enviar solicitud 🩷',
    },
    '9zlk6xb9': {
      'en': ' Skip for now',
      'de': 'Überspringen',
      'es': 'Omitir por ahora',
    },
  },
  // S5_createaccount
  {
    '07wreg8r': {
      'en': 'Create an account',
      'de': 'Ein Konto erstellen',
      'es': 'Crear una cuenta',
    },
    '0nm2gros': {
      'en': 'Enter your details to continue',
      'de': 'Gib deine Daten ein, um fortzufahren.',
      'es': 'Ingresa tus datos para continuar',
    },
    'qk68vwo6': {
      'en': 'Your email',
      'de': 'Deine E-Mail-Adresse',
      'es': 'Tu correo electrónico',
    },
    '8qanxd9r': {
      'en': 'Your password',
      'de': 'Dein Passwort',
      'es': 'Tu contraseña',
    },
    '56nr7xhv': {
      'en': 'Create Account 🩷',
      'de': 'Account anlegen 🩷',
      'es': 'Crear una cuenta🩷',
    },
    '2k3ozef6': {
      'en': 'By signing up, you agree to Terms of Service and Privacy Policy.',
      'de':
          'Mit der Registrierung stimmst du den Nutzungsbedingungen und der Datenschutzrichtlinie zu.',
      'es':
          'Al registrarte, aceptas los Términos del Servicio y la Política de Privacidad.',
    },
  },
  // S6_photo
  {
    'im8qczu0': {
      'en': 'Add your photo',
      'de': 'Füge dein Foto hinzu',
      'es': 'Agrega tu foto',
    },
    '4vgxbdni': {
      'en': 'Upload a photo to personalize your profile',
      'de': 'Lade ein Foto hoch, um dein Profil zu personalisieren',
      'es': 'Sube una foto para personalizar tu perfil',
    },
    'd4w0hy1y': {
      'en': 'Continue',
      'de': 'Weiter',
      'es': 'Continuar',
    },
    '3b76kzew': {
      'en': 'Skip',
      'de': 'Überspringen',
      'es': 'Omitir',
    },
  },
  // S7_birth
  {
    's73mzkoe': {
      'en': 'When is your birthday?',
      'de': 'Wann hast du Geburtstag?',
      'es': '¿Cuándo es tu cumpleaños?',
    },
    'yx8iz8de': {
      'en': 'So we can surprise you on your special day 🎁.',
      'de': 'Damit wir dich an deinem besonderen Tag überraschen können 🎁.',
      'es': 'Para poder sorprenderte en tu día especial 🎁.',
    },
    '2fj3293h': {
      'en': 'MONTH',
      'de': 'MONAT',
      'es': 'MES',
    },
    's3y9jp3u': {
      'en': 'DAY',
      'de': 'TAG',
      'es': 'DÍA',
    },
    'fdccyulx': {
      'en': 'YEAR',
      'de': 'JAHR',
      'es': 'AÑO',
    },
    '2wqa0pkc': {
      'en': 'Continue',
      'de': 'Weiter',
      'es': 'Continuar',
    },
  },
  // S8_city
  {
    'et9sxyne': {
      'en': 'Where do you live?',
      'de': 'Wo wohnst du?',
      'es': '¿Dónde vives?',
    },
    'suptmxbh': {
      'en': 'Tap \"Select location\" and enter the name of your city.',
      'de':
          'Tippe auf „Standort auswählen“ und gib den Namen deiner Stadt ein.',
      'es': 'Toca «Seleccionar ubicación» e ingresa el nombre de tu ciudad.',
    },
    'y75flzd7': {
      'en': 'Select Location',
      'de': 'Standort auswählen',
      'es': 'Seleccionar ubicación',
    },
    'ea2bm4l5': {
      'en': 'Continue',
      'de': 'Weiter',
      'es': 'Continuar',
    },
  },
  // S9_together_since
  {
    'mw2i5zxa': {
      'en': 'Since when have you been together?',
      'de': 'Seit wann seid ihr zusammen?',
      'es': '¿Desde cuándo están juntos?',
    },
    'gfpdxwjv': {
      'en': 'Let us know when your relationship began.',
      'de': 'Sag uns, wann eure Beziehung begonnen hat.',
      'es': 'Háganos saber cuándo comenzó su relación.',
    },
    'gj3hsr90': {
      'en': 'Continue',
      'de': 'Weiter',
      'es': 'Continuar',
    },
  },
  // S10_Demo_LoveBuddy
  {
    'm6yh2is4': {
      'en': 'Take care of your Companions',
      'de': 'Kümmert euch um eure Begleiter',
      'es': 'Cuiden de sus compañeros',
    },
    'yxhr3xwf': {
      'en':
          'The more time you spend in Togly, the happier your Companions will be!',
      'de':
          'Je mehr Zeit ihr in Togly verbringt, desto glücklicher werden eure Begleiter!',
      'es':
          '¡Cuanto más tiempo pasen en Togly, más felices serán sus compañeros!',
    },
    'rssi1xed': {
      'en':
          'Show your Companions some love by spending time together in the app!',
      'de':
          'Schenkt euren Begleitern etwas Liebe, indem ihr gemeinsam Zeit in der App verbringt!',
      'es':
          '¡Demuestren su cariño a sus compañeros pasando tiempo juntos en la aplicación!',
    },
    'evebd4b9': {
      'en': 'Okay, got it',
      'de': 'Okay, verstanden.',
      'es': 'De acuerdo, entendido.',
    },
  },
  // home
  {
    'mvyjb1lb': {
      'en': 'Couples \nAround the World 🌍',
      'de': 'Paare \nauf der ganzen Welt 🌍',
      'es': 'Parejas\nde todo el mundo 🌍',
    },
    'p3dh5cx8': {
      'en': 'Together\nAcross Borders.',
      'de': 'Gemeinsam\nüber Grenzen hinweg.',
      'es': 'Juntos más\nallá de las fronteras.',
    },
    '07iyyo22': {
      'en': 'Love \nconnects us all.',
      'de': 'Liebe\nverbindet uns alle.',
      'es': 'El amor\nnos une a todos.',
    },
    '7b2gnwtt': {
      'en': 'Explore the Community',
      'de': 'Entdecke die Community',
      'es': 'Explora la comunidad',
    },
    'ooxgm4pt': {
      'en': 'Our Companions',
      'de': 'Unsere Begleiter',
      'es': 'Nuestros compañeros',
    },
    'ise9790g': {
      'en': 'Bond Points collected today:',
      'de': 'Gesammelte Bindungspunkte:',
      'es': 'Puntos de vínculo obtenidos hoy:',
    },
    '31yyq6wz': {
      'en': 'Our Companions',
      'de': 'Unsere Begleiter',
      'es': 'Nuestros compañeros',
    },
    '97cn5zio': {
      'en': 'Bond Points collected today:',
      'de': 'Gesammelte Bindungspunkte:',
      'es': 'Puntos de vínculo obtenidos hoy:',
    },
    'h4xvwx66': {
      'en': 'Our Companions',
      'de': 'Unsere Begleiter',
      'es': 'Nuestros compañeros',
    },
    'gfs38053': {
      'en': 'Bond Points collected today:',
      'de': 'Gesammelte Bindungspunkte:',
      'es': 'Puntos de vínculo obtenidos hoy:',
    },
    '4c0gag5x': {
      'en': 'Our Companions',
      'de': 'Unsere Begleiter',
      'es': 'Nuestros compañeros',
    },
    'oktv6lbs': {
      'en': '65%',
      'de': '65%',
      'es': '65%',
    },
    'bltg6v9g': {
      'en': 'Bond Points collected today:',
      'de': 'Gesammelte Bindungspunkte:',
      'es': 'Puntos de vínculo obtenidos hoy:',
    },
    'wxwchkjw': {
      'en': 'Keep earning Points by interacting together.',
      'de': 'Sammelt weiter Punkte durch Nutzung der App.',
      'es': 'Sigan ganando puntos usando la aplicación juntos.',
    },
    'wx99kfrg': {
      'en': 'Heartbeat',
      'de': 'Herzschlag',
      'es': 'Latido',
    },
    '8an83ddx': {
      'en': 'Love treasure',
      'de': 'Liebestruhe',
      'es': 'Tesoro de amor',
    },
  },
  // S1_Login
  {
    'g2d9wqv2': {
      'en': 'Log in',
      'de': 'Einloggen',
      'es': 'Iniciar sesión',
    },
    'fknecj89': {
      'en': 'Enter your login details',
      'de': 'Gib deine Login-Daten ein',
      'es': 'Ingresa tus datos de inicio de sesión',
    },
    'zqxdtcu7': {
      'en': 'Your email',
      'de': 'Deine E-Mail-Adresse',
      'es': 'Tu correo electrónico',
    },
    't1hogazx': {
      'en': 'Your password',
      'de': 'Dein Passwort',
      'es': 'Tu contraseña',
    },
    '1ss4ml8c': {
      'en': 'Log in 🩷',
      'de': 'Einloggen 🩷',
      'es': 'Iniciar sesión 🩷',
    },
    '1eiavbit': {
      'en': 'We are happy that you are back.',
      'de': 'Wir freuen uns, dass du wieder da bist.',
      'es': 'Estamos felices de que hayas vuelto.',
    },
    'j7ebog1n': {
      'en': 'Forgot Password?',
      'de': 'Passwort vergessen?',
      'es': '¿Olvidaste tu contraseña?',
    },
  },
  // GatePage
  {
    'vvah411e': {
      'en': 'Home',
      'de': '',
      'es': '',
    },
  },
  // LoveNotePageCopy
  {
    'p666hy4u': {
      'en': 'Love Notes',
      'de': 'Liebesbotschaften',
      'es': 'Notas de amor',
    },
    'wh89nv5w': {
      'en': 'Little words. Big feelings\njust for the two of you.',
      'de': 'Wenige Worte. Große Gefühle.\nNur für euch beide.',
      'es': 'Pequeñas palabras. Grandes emociones. Solo para vosotros.',
    },
    '9pq8wawg': {
      'en': '💕',
      'de': '💕',
      'es': '💕',
    },
    'bk0dol8g': {
      'en': 'Write your daily love note here...',
      'de': 'Schreibe hier deine tägliche Liebesbotschaft...',
      'es': 'Escribe aquí tu nota de amor diaria…',
    },
    'oiy3vr8e': {
      'en': '💌 Send Note',
      'de': '💌 Nachricht senden',
      'es': 'Enviar nota',
    },
  },
  // S11_moreWaysScreen
  {
    'lnu8e3yn': {
      'en': 'More ways to stay close ✨',
      'de': 'Mehr Möglichkeiten, euch nah zu bleiben ✨',
      'es': 'Más formas de mantenerse cerca ✨',
    },
    'h3z5aayw': {
      'en': 'Everything you need to grow your relationship.',
      'de': 'Alles, was du brauchst, um eure Beziehung wachsen zu lassen.',
      'es': 'Todo lo que necesitas para hacer crecer tu relación.',
    },
    'xf3qczpd': {
      'en': 'Shared Calendar',
      'de': 'Gemeinsamer Kalender',
      'es': 'Calendario compartido',
    },
    'eafvjnoc': {
      'en': 'Plan your time together.',
      'de': 'Plant eure Zeit zusammen.',
      'es': 'Planifiquen su tiempo juntos.',
    },
    '26ao8np9': {
      'en': 'Couple Goals',
      'de': 'Paarziele',
      'es': 'Metas de pareja',
    },
    'yh6y7zfb': {
      'en': 'Dream together and track your goals.',
      'de': 'Träumt zusammen und verfolgt eure Ziele.',
      'es': 'Sueñen juntos y sigan sus metas.',
    },
    'k9sxefbj': {
      'en': 'Daily Question',
      'de': 'Tägliche Frage',
      'es': 'Pregunta diaria',
    },
    'k2bqxhy8': {
      'en': 'Discover new things about each other.',
      'de': 'Entdeckt neue Dinge voneinander.',
      'es': 'Descubran cosas nuevas el uno del otro.',
    },
    'gt5jc9ke': {
      'en': 'Love Notes',
      'de': 'Liebesnachrichten',
      'es': 'Notas de amor',
    },
    '7600tkr8': {
      'en': 'Send sweet messages at the perfect moment.',
      'de': 'Schick süße Nachrichten.',
      'es': 'Envía mensajes dulces en el momento perfecto.',
    },
    '5xqm4djn': {
      'en': 'Photo Album',
      'de': 'Fotoalbum',
      'es': 'Álbum de fotos.',
    },
    'ltn6vmvu': {
      'en': 'Save your favorite memories.',
      'de': 'Speichert eure Lieblingsmomente.',
      'es': 'Guarda tus recuerdos favoritos.',
    },
    'u0km0538': {
      'en': 'Wish List',
      'de': 'Wunschliste',
      'es': 'Lista de deseos',
    },
    'o1zgswf9': {
      'en': 'Share things you wish for.',
      'de': 'Teilt eure Wünsche',
      'es': 'Comparte las cosas que deseas.',
    },
    'zzv2z6fb': {
      'en': 'Continue 💗',
      'de': 'Weiter 💗',
      'es': 'Continuar 💗',
    },
  },
  // S_12FounderPage
  {
    '6cuzpuro': {
      'en': 'Hi, I’m the founder\n of Togly 👋',
      'de': 'Hi, ich bin der Gründer von Togly 👋',
      'es': 'Hola, soy el fundador de Togly 👋',
    },
    '0ibnlsu8': {
      'en':
          'A few years ago, I realized something simple:\nRelationships often fade into routines.\nBusy days.\nQuick messages.\nLess time to really connect.',
      'de':
          'Vor ein paar Jahren habe ich etwas Einfaches erkannt:\nBeziehungen verfallen oft in Routinen.\nVolle Tage.\nSchnelle Nachrichten.\nWeniger Zeit, um sich wirklich zu verbinden.',
      'es':
          'Hace unos años me di cuenta de algo sencillo:\nLas relaciones a menudo se convierten en rutina.\nDías ocupados.\nMensajes rápidos.\nMenos tiempo para conectar de verdad.',
    },
    'r20neehk': {
      'en':
          'I wanted to create something that helps couples\npause for a moment and truly see each other again.',
      'de':
          'Ich wollte etwas erschaffen, das Paaren hilft, einen Moment innezuhalten und sich wieder wirklich zu sehen.',
      'es':
          'Quería crear algo que ayude a las parejas a detenerse un momento y volver a verse de verdad.',
    },
    'as160ll4': {
      'en':
          'That’s why I built Togly\na small space where two people can\nshare memories, ask meaningful questions,\nand grow closer every day.',
      'de':
          'Deshalb habe ich Togly gebaut,\neinen kleinen Ort, an dem zwei Menschen\nErinnerungen teilen, bedeutungsvolle Fragen stellen\nund jeden Tag ein Stück näher zusammenwachsen können.',
      'es':
          'Por eso creé Togly,\nun pequeño espacio donde dos personas pueden\ncompartir recuerdos, hacer preguntas significativas\ny acercarse más cada día.',
    },
    'h78sx8l5': {
      'en':
          'Thank you for being here.\nI hope Togly becomes a small but meaningful\npart of your relationship.',
      'de':
          'Danke, dass du hier bist.\nIch hoffe, Togly wird ein kleiner, aber bedeutungsvoller\nTeil deiner Beziehung.',
      'es':
          'Gracias por estar aquí.\nEspero que Togly se convierta en una pequeña pero significativa\nparte de tu relación.',
    },
    '9phl2hr4': {
      'en': 'Start your journey 💗',
      'de': 'Starte deine Reise 💗',
      'es': 'Comienza tu viaje 💗',
    },
  },
  // Together
  {
    'mmyep412': {
      'en': 'Your world',
      'de': 'Eure Welt',
      'es': 'Tu mundo',
    },
    'i39xcs0x': {
      'en': 'Your shared world, in one place ✨',
      'de': 'Eure gemeinsame Welt an einem Ort ✨',
      'es': 'Su mundo compartido, en un solo lugar ✨',
    },
    'vm1m6k3h': {
      'en': 'Shared Calendar',
      'de': 'Gemeinsamer Kalender',
      'es': 'Calendario compartido',
    },
    'slad1glk': {
      'en': 'Plan your days together',
      'de': 'Plant eure Tage zusammen',
      'es': 'Planifiquen sus días juntos',
    },
    'ms3xybcv': {
      'en': 'Shared Wishlist',
      'de': 'Gemeinsame Wunschliste',
      'es': 'Lista de deseos compartida',
    },
    'yxg4vhbz': {
      'en': 'Gift ideas you\'ll both love',
      'de': 'Zeige deine Wünsche',
      'es': 'Muestra tus deseos.',
    },
    'lbuze7tu': {
      'en': 'Shared Gallery',
      'de': 'Gemeinsame Galerie.',
      'es': 'Galería compartida',
    },
    'we5pir56': {
      'en': 'Memories you\'ve made together',
      'de': 'Gemeinsame Erinnerungen',
      'es': 'Recuerdos compartidos',
    },
    'gn3rm4ya': {
      'en': 'Bucket List',
      'de': 'Bucket Liste',
      'es': 'Lista de sueños',
    },
    'drt72uzs': {
      'en': 'Adventures waiting to happen',
      'de': 'Erreicht eure Ziele zusammen',
      'es': 'Lograr metas juntos',
    },
    'lkkilhgd': {
      'en': 'Love Coupons',
      'de': 'Liebesgutscheine',
      'es': 'Cupones de amor',
    },
    '0bwqd7s9': {
      'en': 'Your shared love coupons',
      'de': 'Eure gemeinsamen Liebesgutscheine',
      'es': 'Sus cupones de amor compartidos',
    },
    'e50whitf': {
      'en': 'Love Treasures',
      'de': 'Liebestruhen',
      'es': 'Tesoro del amor',
    },
    '77gcv8fj': {
      'en': 'Your Shared Love Treasures',
      'de': 'Eure gemeinsamen Truhen',
      'es': 'Sus tesoros del amor compartidos',
    },
  },
  // heartbeat_result
  {
    '9vdr8lgy': {
      'en': 'Your Heartbeat Today',
      'de': 'Euer Herzschlag heute',
      'es': 'Tu latido de hoy',
    },
    'issioo70': {
      'en': '%',
      'de': '%',
      'es': '%',
    },
    'y56zjula': {
      'en': 'Your partner\'s answers',
      'de': 'Die Antworten deines Partners',
      'es': 'Las respuestas de tu pareja',
    },
    'z2dwwi09': {
      'en': '💌  Send Something Sweet',
      'de': '💌 Sende etwas Süßes',
      'es': '💌 Envía algo dulce',
    },
    'unocio8y': {
      'en': 'Share Your Result',
      'de': 'Teile dein Ergebnis',
      'es': 'Comparte tu resultado',
    },
  },
  // Heartbeat_start
  {
    '2jce9jgy': {
      'en': 'Today\'s Heartbeat',
      'de': 'Herzschlag',
      'es': 'El latido de hoy',
    },
    'fzbyrksa': {
      'en': 'A daily emotional check-in for you and your partner.',
      'de': 'Ein täglicher emotionaler Check-in für dich und deinen Partner.',
      'es': 'Un registro emocional diario para ti y tu pareja',
    },
    'ctkfq3nx': {
      'en': 'Take a moment to answer three quick questions.',
      'de': 'Nimm dir einen Moment, um drei kurze Fragen zu beantworten',
      'es': 'Tómate un momento para responder tres preguntas rápidas',
    },
    '8ajvgdmk': {
      'en':
          'Your answers will reveal how emotionally connected you feel today.',
      'de':
          'Deine Antworten zeigen, wie emotional verbunden ihr euch heute fühlt',
      'es':
          'Tus respuestas revelarán qué tan conectados emocionalmente se sienten hoy',
    },
    'ec9d0tk3': {
      'en': 'Start Heartbeat',
      'de': 'Herzschlag starten',
      'es': 'Comenzar el latido',
    },
    'xjinb4kh': {
      'en': 'Takes less than 30 seconds',
      'de': 'Dauert weniger als 30 Sekunden',
      'es': 'Toma menos de 30 segundos',
    },
  },
  // Heartbeat_questions
  {
    '4wsuryp8': {
      'en': 'Heartbeat',
      'de': 'Herzschlag',
      'es': 'Latido del corazón',
    },
    'edt090dg': {
      'en':
          'Take a moment to reflect on your emotional bond with your partner.',
      'de':
          'Nimm dir einen Moment, um über eure emotionale Verbindung nachzudenken',
      'es':
          'Tómate un momento para reflexionar sobre tu vínculo emocional con tu pareja',
    },
    '18g0ihqf': {
      'en':
          'Take a moment to reflect on your emotional bond with your partner.',
      'de':
          'Nimm dir einen Moment, um über eure emotionale Verbindung nachzudenken',
      'es':
          'Tómate un momento para reflexionar sobre tu vínculo emocional con tu pareja',
    },
    's1vjutsa': {
      'en':
          'Take a moment to reflect on your emotional bond with your partner.',
      'de':
          'Nimm dir einen Moment, um über eure emotionale Verbindung nachzudenken',
      'es':
          'Tómate un momento para reflexionar sobre tu vínculo emocional con tu pareja',
    },
    'oef4v62l': {
      'en': 'Rate how strongly this applies today',
      'de': 'Bewerte, wie stark das heute auf dich zutrifft',
      'es': 'Califica qué tan fuerte se aplica esto hoy',
    },
    'lepkvocx': {
      'en': '1',
      'de': '1',
      'es': '1',
    },
    'vd163tw8': {
      'en': 'Very weak',
      'de': 'Sehr schwach',
      'es': 'Muy débil.',
    },
    'dhzy63hb': {
      'en': '2',
      'de': '2',
      'es': '2',
    },
    'vw7lw76d': {
      'en': 'Weak',
      'de': 'Schwach',
      'es': 'Débil',
    },
    'gah7li8u': {
      'en': '3',
      'de': '3',
      'es': '3',
    },
    'z18j5vgi': {
      'en': 'Neutral',
      'de': 'Neutral',
      'es': 'Neutral',
    },
    '16azjzzx': {
      'en': '4',
      'de': '4',
      'es': '4',
    },
    'og8ithsu': {
      'en': 'Strong',
      'de': 'Stark',
      'es': 'Fuerte',
    },
    'r8uipzub': {
      'en': '5',
      'de': '5',
      'es': '5',
    },
    'q90618so': {
      'en': 'Very strong',
      'de': 'Sehr stark',
      'es': 'Muy fuerte.',
    },
    '62qthx3f': {
      'en': 'Next',
      'de': 'Weiter',
      'es': 'Siguiente',
    },
    'yg7j4zqh': {
      'en': 'Your answers are private and shared only with your partner.',
      'de': 'Deine Antworten sind privat\nfür dich und deinen Partner.',
      'es': 'Tus respuestas son privadas\ny solo se comparten con tu pareja.',
    },
  },
  // Heartbeat_wait
  {
    '6clytr63': {
      'en': 'Heartbeat',
      'de': 'Herzschlag',
      'es': 'Latido del corazón',
    },
    'glrqo173': {
      'en': 'You\'ve completed today\'s heartbeat',
      'de': 'Du hast den heutigen Herzschlag abgeschlossen',
      'es': 'Has completado el latido de hoy',
    },
    '68pdvjyy': {
      'en':
          'Your answers were saved. We\'re now waiting for your partner to finish.',
      'de':
          'Deine Antworten wurden gespeichert. Jetzt warten wir darauf, dass dein Partner fertig wird.',
      'es':
          'Tus respuestas se han guardado. Ahora estamos esperando a que tu pareja termine',
    },
    'qpoead4r': {
      'en': 'Waiting for your partner…',
      'de': 'Warte auf deinen Partner…',
      'es': 'Esperando a tu pareja…',
    },
    'ja78ikoh': {
      'en':
          'As soon as your partner answers, your shared heartbeat result will unlock.',
      'de':
          'Sobald dein Partner antwortet, wird euer gemeinsames Herzschlag-Ergebnis angezeigt.',
      'es':
          'En cuanto tu pareja responda, se desbloqueará el resultado de su latido compartido.',
    },
    'uxmm41jw': {
      'en': 'Back to Home',
      'de': 'Zurück zur Startseite',
      'es': 'Volver al inicio',
    },
    'hbittgtw': {
      'en': 'You\'ll automatically see the result once your partner answers.',
      'de': 'Du siehst das Ergebnis automatisch, sobald dein Partner antwortet',
      'es': 'Verás el resultado automáticamente en cuanto tu pareja responda',
    },
  },
  // love_treasure_main
  {
    'vt7p5o9s': {
      'en': 'Create a Love Treasure',
      'de': 'Erstelle eine Liebestruhe',
      'es': 'Crea un tesoro de amor',
    },
    'w7ifkp6y': {
      'en':
          'Create a secret treasure for your partner. Add little surprises and open them together when the time is up.',
      'de':
          'Erstelle einen geheimen Schatz für deinen Partner. Füge kleine Überraschungen hinzu und öffnet sie zusammen, wenn die Zeit abgelaufen ist.',
      'es':
          'Crea un tesoro secreto para tu pareja. Añade pequeñas sorpresas y ábranlas juntos cuando llegue el momento',
    },
    'jhakkc6x': {
      'en': 'Choose Duration',
      'de': 'Wähle die Dauer',
      'es': 'Elige la duración',
    },
    'hcjohf93': {
      'en': '3 Days',
      'de': '3 Tage',
      'es': '3 días',
    },
    'r0l0wn1v': {
      'en': 'up to 10 surprises per person',
      'de': 'bis zu 10 Überraschungen pro Person',
      'es': 'hasta 10 sorpresas por persona',
    },
    'hnnpv5bm': {
      'en': 'Most popular ✨',
      'de': 'Am beliebtesten ✨',
      'es': 'El más popular ✨',
    },
    '7o22bojh': {
      'en': '7 Days',
      'de': '7 Tage',
      'es': '7 días',
    },
    '3tju6cvi': {
      'en': 'up to 15 surprises per person',
      'de': 'bis zu 15 Überraschungen pro Person',
      'es': 'hasta 15 sorpresas por persona',
    },
    'ata3lbf4': {
      'en': '14 Days',
      'de': '14 Tage',
      'es': '14 días',
    },
    'h5qn3ghe': {
      'en': 'up to 20 surprises per person',
      'de': 'bis zu 20 Überraschungen pro Person',
      'es': 'hasta 20 sorpresas por persona',
    },
    '4jr512js': {
      'en': 'Create Treasure',
      'de': 'Truhe  erstellen',
      'es': 'Crear tesoro',
    },
    'vo74xn59': {
      'en':
          'Your partner won\'t see the surprises until you open it together ❤️',
      'de':
          'Dein Partner sieht die Überraschungen erst, wenn ihr sie gemeinsam öffnet ❤️',
      'es': 'Tu pareja no verá las sorpresas hasta que las abran juntos ❤️',
    },
  },
  // love_treasure_page_two
  {
    'w79tyk8m': {
      'en': 'Love Treasure',
      'de': '',
      'es': '',
    },
    'uzr8o9io': {
      'en': 'Your Love Treasure is ready ✨',
      'de': 'Deine Liebes Truhe ist bereit ✨',
      'es': 'Tu tesoro del amor está listo ✨',
    },
    'yp6c0zvp': {
      'en': 'The moment you\'ve been waiting for has arrived',
      'de': 'Der Moment, auf den du gewartet hast, ist da',
      'es': 'El momento que estabas esperando ha llegado',
    },
    'twvvphxz': {
      'en': 'Treasure unlocks in',
      'de': 'Verbleibende Zeit für die Truhe',
      'es': 'El tesoro se desbloquea en',
    },
    'rmgo2t81': {
      'en': 'Your partner added a surprise ✨',
      'de': 'Dein Partner hat eine Überraschung hinzugefügt ✨',
      'es': 'Tu pareja ha añadido una sorpresa ✨',
    },
    'rzk2sa84': {
      'en': 'Something special is waiting for you',
      'de': 'Etwas Besonderes wartet auf dich',
      'es': 'Algo especial te está esperando',
    },
    '4660pomf': {
      'en': 'Open Treasure',
      'de': 'Truhe öffnen',
      'es': 'Abrir tesoro',
    },
    'sqvy8t86': {
      'en': 'Add a Surprise',
      'de': 'Überraschung hinzufügen',
      'es': 'Añadir una sorpresa',
    },
    'a61f6fm5': {
      'en': 'Share our Treasure',
      'de': 'Truhe teilen',
      'es': 'Compartir nuestro tesoro',
    },
    'nsts1h6u': {
      'en':
          'This treasure stays available for 24 hours before it moves to your archive.',
      'de':
          'Diese Truhe bleibt 24 Stunden verfügbar, bevor sie ins Archiv wandert.',
      'es':
          'Este tesoro permanecerá disponible durante 24 horas antes de pasar a tu archivo.',
    },
    'lms9qttn': {
      'en': 'Voice Note',
      'de': 'Sprachnachricht',
      'es': 'Nota de voz',
    },
    'waful2u5': {
      'en': 'A voice message recorded just for you 💜',
      'de': 'Eine Sprachnachricht, nur für dich aufgenommen 💜',
      'es': 'Un mensaje de voz grabado solo para ti 💜',
    },
    'fsllfldn': {
      'en': 'Photos',
      'de': 'Fotos',
      'es': 'Fotos',
    },
    'w9txxtd9': {
      'en': 'Photos captured just for you 📸',
      'de': 'Fotos nur für dich gemacht 📸',
      'es': 'Fotos hechas solo para ti 📸',
    },
    '9b6as0xj': {
      'en': 'Love Coupon',
      'de': 'Liebesgutschein',
      'es': 'Cupón de amor',
    },
    'r95uof53': {
      'en': 'Use it anytime for something special… 😉',
      'de': 'Nutze es jederzeit für etwas Besonderes… 😉',
      'es': 'Úsalo en cualquier momento para algo especial… 😉',
    },
    '7f2tloro': {
      'en': 'Reason I Love You',
      'de': 'Warum ich dich liebe',
      'es': 'Razón por la que te amo',
    },
    'ij8z9w3f': {
      'en': 'Because you make every day magical ✨',
      'de': 'Weil du jeden Tag magisch machst ✨',
      'es': 'Porque haces que cada día sea mágico ✨',
    },
    'f2daqmrm': {
      'en': 'Share our Treasure',
      'de': 'Truhe teilen',
      'es': 'Compartir nuestro tesoro',
    },
  },
  // coupon_wallet
  {
    '3lhx70oj': {
      'en': 'Love Coupons',
      'de': 'Liebesgutscheine',
      'es': 'Cupones de amor',
    },
    '7narxddu': {
      'en': 'Sweet gestures you and your partner have shared',
      'de': 'Süße Gesten, die du und Partner geteilt habt',
      'es': 'Gestos dulces que tú y tu pareja han compartido',
    },
    '4lq0q5eu': {
      'en': '💌  Received',
      'de': '💌 Erhalten',
      'es': '💌 Recibidos',
    },
    'hostvw94': {
      'en': '🎁  Given',
      'de': '🎁 Gesendet',
      'es': '🎁 Enviados',
    },
    'g1sdcncn': {
      'en': 'Coupon Archive',
      'de': 'Gutschein Archiv',
      'es': 'Archivo de cupones',
    },
    '5szdzj8q': {
      'en': 'Use Now',
      'de': 'Jetzt einlösen',
      'es': 'Canjear ahora',
    },
    '9xfp9jph': {
      'en': '💕',
      'de': '💕',
      'es': '💕',
    },
    '1xsbksik': {
      'en': 'Togly',
      'de': 'Togly',
      'es': 'Togly',
    },
  },
  // sticky_wall
  {
    'fitdyxv9': {
      'en': '💕 Your Love Wall',
      'de': '',
      'es': '',
    },
    'sj07lcsg': {
      'en': 'Every reason you love them, pinned forever.',
      'de': '',
      'es': '',
    },
    'zoiah206': {
      'en': '💛',
      'de': '',
      'es': '',
    },
    '3e2tti6t': {
      'en': 'Your laugh makes every bad day disappear instantly.',
      'de': '',
      'es': '',
    },
    '41vpymuo': {
      'en': '🌸',
      'de': '',
      'es': '',
    },
    'kw5z0pb0': {
      'en': 'You always know exactly what I need before I say it.',
      'de': '',
      'es': '',
    },
    's42fr8vc': {
      'en': '🌷',
      'de': '',
      'es': '',
    },
    'x4uwuhzu': {
      'en': 'The way you hold my hand when I\'m scared.',
      'de': '',
      'es': '',
    },
    'xtanc1x2': {
      'en': '🍂',
      'de': '',
      'es': '',
    },
    '51xn4b8l': {
      'en': 'You make ordinary moments feel like magic.',
      'de': '',
      'es': '',
    },
    'rz0mjot8': {
      'en': '🌿',
      'de': '',
      'es': '',
    },
    'zpnl3qxa': {
      'en': 'Your kindness to strangers shows your beautiful soul.',
      'de': '',
      'es': '',
    },
    '50ubye4g': {
      'en': '💗',
      'de': '',
      'es': '',
    },
    'gdegfocq': {
      'en': 'You still give me butterflies after all this time.',
      'de': '',
      'es': '',
    },
    'q7ld48zd': {
      'en': '☀️',
      'de': '',
      'es': '',
    },
    'v7hsfbf0': {
      'en': 'You\'re the first thing I want to tell good news to.',
      'de': '',
      'es': '',
    },
    'se827opg': {
      'en': '🌙',
      'de': '',
      'es': '',
    },
    'swgpjq05': {
      'en': 'Falling asleep next to you is my favourite thing.',
      'de': '',
      'es': '',
    },
    '3z2svwqc': {
      'en': '🦋',
      'de': '',
      'es': '',
    },
    'b57tvv3v': {
      'en': 'Your courage inspires me to be braver every day.',
      'de': '',
      'es': '',
    },
    'm58aoskx': {
      'en': '🍓',
      'de': '',
      'es': '',
    },
    'go39myj6': {
      'en': 'You remember the little things that matter most to me.',
      'de': '',
      'es': '',
    },
    's9tzsnse': {
      'en': '🌻',
      'de': '',
      'es': '',
    },
    'xfiqr6ke': {
      'en': 'You make home feel like the safest place on earth.',
      'de': '',
      'es': '',
    },
    'ofoaluy4': {
      'en': '💌',
      'de': '',
      'es': '',
    },
    '1ern3s6b': {
      'en': 'Every text from you still makes me smile wide.',
      'de': '',
      'es': '',
    },
    'gz4mutug': {
      'en': '✨',
      'de': '',
      'es': '',
    },
    '0d1rwkha': {
      'en': 'You light up every room you walk into.',
      'de': '',
      'es': '',
    },
    '5gdripdm': {
      'en': '🎶',
      'de': '',
      'es': '',
    },
    'auln629z': {
      'en': 'Dancing with you in the kitchen is pure joy.',
      'de': '',
      'es': '',
    },
  },
  // sticy_wall_create
  {
    'psoqdk4w': {
      'en': 'Your Love Wall',
      'de': 'Deine Liebeswand',
      'es': 'Tu muro de amor',
    },
    'mb60z21m': {
      'en': 'All the little reasons why you love your partner 💕',
      'de': 'All die kleinen Gründe, warum du deinen Partner liebst  💕',
      'es': 'Todas las pequeñas razones por las que amas a tu pareja 💕',
    },
    '2a7p3bzu': {
      'en': 'Reasons',
      'de': 'Gründe',
      'es': 'Razones',
    },
    'bqcrj9z6': {
      'en': 'Add a Reason',
      'de': 'Grund hinzufügen',
      'es': 'Añadir una razón',
    },
  },
  // coupon_page
  {
    'pv86j85g': {
      'en': 'Create Love Coupon',
      'de': 'Liebesgutschein erstellen',
      'es': 'Crear cupón de amor',
    },
    'tupmhft3': {
      'en': 'Craft a sweet and meaningful Coupon for your partner',
      'de':
          'Erstelle einen süßen und bedeutungsvollen Gutschein für deinen Partner',
      'es': 'Crea un cupón dulce y significativo para tu pareja',
    },
    'zbktei63': {
      'en': 'Choose a Template',
      'de': 'Vorlage auswählen',
      'es': 'Elegir una plantilla',
    },
    '4y3u3w16': {
      'en': 'Pick a beautifully designed coupon to start with',
      'de': 'Wähle einen fertig gestalteten Gutschein als Vorlage',
      'es': 'Elige un cupón con un diseño bonito para empezar',
    },
    'dmrh1jyx': {
      'en': 'Movie Night',
      'de': 'Filmabend',
      'es': 'Noche de cine',
    },
    '61kh0jzo': {
      'en': 'Massage',
      'de': 'Massage',
      'es': 'Masaje',
    },
    'y5i6glpv': {
      'en': 'Date Night',
      'de': 'Date-Abend',
      'es': 'Noche de cita',
    },
    'ammbzmdv': {
      'en': 'Adventure',
      'de': 'Abenteuer',
      'es': 'Aventura',
    },
    'ptrm1lgt': {
      'en': 'Surprise',
      'de': 'Überraschung',
      'es': 'Sorpresa',
    },
    'ck10eznz': {
      'en': 'Or...',
      'de': 'Oder...',
      'es': 'O...',
    },
    'efeoa678': {
      'en': 'Add your own photo',
      'de': 'Füge dein eigenes Foto hinzu',
      'es': 'Añade tu propia foto',
    },
    'udc1vegd': {
      'en': 'optional',
      'de': 'optional',
      'es': 'opcional',
    },
    'kzkv9714': {
      'en': 'Upload a personal photo to make this coupon truly one-of-a-kind',
      'de':
          'Lade ein persönliches Foto hoch, um den Gutschein einzigartig zu machen',
      'es': 'Sube una foto personal para hacer este cupón verdaderamente único',
    },
    'mawe353h': {
      'en': 'Tap to upload a photo',
      'de': 'Tippe, um ein Foto hochzuladen',
      'es': 'Toca para subir una foto',
    },
    '5jsl5f7l': {
      'en': 'Coupon Details',
      'de': 'Gutschein-Details',
      'es': 'Detalles del cupón',
    },
    'vk3jfrmd': {
      'en': 'e.g. A Cozy Movie Night Just for Us',
      'de': 'z. B. Ein gemütlicher Filmabend nur für uns',
      'es': 'p. ej. Una noche de cine acogedora solo para nosotros',
    },
    'jai1g633': {
      'en': 'Write a heartfelt message your partner will treasure...',
      'de':
          'Schreibe eine liebevolle Nachricht, die Partner in der Truhe aufbewahren wird…',
      'es':
          'Escribe un mensaje lleno de cariño que tu pareja guardará en el tesoro…',
    },
    'owwr8b3w': {
      'en': 'e.g. A Cozy Movie Night Just for Us is required',
      'de': '',
      'es': '',
    },
    'ut7k29i4': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
    },
    'jj5t7ajh': {
      'en':
          'Write a heartfelt message your partner will treasure... is required',
      'de': '',
      'es': '',
    },
    's6l7koqq': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
    },
    '0pak0b45': {
      'en': 'Category',
      'de': 'Kategorie',
      'es': 'Categoría',
    },
    'c88jassz': {
      'en': '👩‍❤️‍👨',
      'de': '👩‍❤️‍👨',
      'es': '👩‍❤️‍👨',
    },
    'j8uj3sx5': {
      'en': 'Quality \nTime',
      'de': 'Gemeinsame\nZeit',
      'es': 'Tiempo\nde calidad',
    },
    'fk0c834x': {
      'en': '🌹',
      'de': '🌹',
      'es': '🌹',
    },
    'qzo9llsy': {
      'en': 'Romance',
      'de': 'Romantik',
      'es': 'Romance',
    },
    'll1qi1f0': {
      'en': '🍳',
      'de': '🍳',
      'es': '🍳',
    },
    '933jepr3': {
      'en': 'Breakfast',
      'de': 'Frühstück',
      'es': 'Desayuno',
    },
    'atln1quu': {
      'en': '💆',
      'de': '💆',
      'es': '💆',
    },
    'zq9vbt10': {
      'en': 'Massage',
      'de': 'Massage',
      'es': 'Masaje',
    },
    'rwvi11ga': {
      'en': '🎬',
      'de': '🎬',
      'es': '🎬',
    },
    'wcpi4zbk': {
      'en': 'Movie Night',
      'de': 'Filmabend',
      'es': 'Noche de cine',
    },
    'rzlrrwwo': {
      'en': '🍷',
      'de': '🍷',
      'es': '🍷',
    },
    'iqx6p8mc': {
      'en': 'Date Night',
      'de': 'Date Abend',
      'es': 'Noche de cita',
    },
    '7eum1qjk': {
      'en': '✈️',
      'de': '✈️',
      'es': '✈️',
    },
    'xdownjih': {
      'en': 'Adventure',
      'de': 'Abenteuer',
      'es': 'Aventura',
    },
    'prnzgshl': {
      'en': '🎁',
      'de': '🎁',
      'es': '🎁',
    },
    'g7qjbei8': {
      'en': 'Surprise',
      'de': 'Überraschung',
      'es': 'Sorpresa',
    },
    'r187zona': {
      'en': 'Create Coupon 💝',
      'de': 'Gutschein erstellen 💝',
      'es': 'Crear cupón 💝',
    },
  },
  // voice_notes_results
  {
    'sefj9w0h': {
      'en': 'Voice Notes',
      'de': 'Sprachnachrichten',
      'es': 'Notas de voz',
    },
    '4z1q0tl6': {
      'en': '🎙️',
      'de': '🎙️',
      'es': '🎙️',
    },
    '7garehy3': {
      'en': 'Listen to the voice messages your partner left for you',
      'de':
          'Höre dir die Sprachnachrichten an, die Partner für dich hinterlassen hat 💕',
      'es': 'Escucha los mensajes de voz que tu pareja dejó para ti 💕',
    },
    'ha7vc06m': {
      'en': 'Saved from your opened treasure',
      'de': 'Aus einer geöffneten Truhe gespeichert',
      'es': 'Guardado de un tesoro abierto',
    },
    'ji433e5t': {
      'en': 'These messages were left just for you 💕',
      'de': 'Diese Nachrichten wurden nur für dich hinterlassen 💕',
      'es': 'Estos mensajes fueron dejados solo para ti 💕',
    },
  },
  // treasure_memorys
  {
    'sh0rqp3e': {
      'en': 'Treasure Memory',
      'de': 'Truhen Erinnerung',
      'es': 'Recuerdo del tesoro',
    },
    'fzc0kk0l': {
      'en': 'Your opened Treasure ✨',
      'de': 'Eure geöffnete Truhe ✨',
      'es': 'Su tesoro abierto ✨',
    },
    'bcs4aze9': {
      'en': 'Moments you shared together',
      'de': 'Gemeinsame Momente',
      'es': 'Momentos compartidos',
    },
    'xlyglhnh': {
      'en': '💝',
      'de': '💝',
      'es': '💝',
    },
    'rzgqm3l6': {
      'en': 'Reasons i love you...',
      'de': 'Warum ich dich liebe...',
      'es': 'Razones por las que te amo...',
    },
    'm90vkgpn': {
      'en': 'Voice Notes',
      'de': 'Sprachnachrichten',
      'es': 'Notas de voz',
    },
    'epqp4yii': {
      'en': 'Listen to the messages from you both💕',
      'de': 'Eure Sprachnachrichten💕',
      'es': 'Sus notas de voz 💕',
    },
    'a2on2xp7': {
      'en': 'A message from your love...',
      'de': 'Eine Nachricht mit Liebe...',
      'es': 'Un mensaje de tu amor...',
    },
    'x49kurv7': {
      'en': '0:42',
      'de': '',
      'es': '',
    },
    'a4w80fqi': {
      'en': 'Photos',
      'de': 'Fotos',
      'es': 'Fotos',
    },
    'm9c57fr7': {
      'en': 'Captured moments',
      'de': 'Festgehaltene Momente',
      'es': 'Momentos capturados',
    },
    'rpiom7ky': {
      'en': 'Love Coupons',
      'de': 'Liebesgutscheine',
      'es': 'Cupones de amor',
    },
    'moon3iqg': {
      'en': 'Special surprises you can use anytime',
      'de': 'Gutscheine, die du jederzeit nutzen kannst',
      'es': 'Sorpresas especiales que puedes usar en cualquier momento',
    },
  },
  // treasures_archive
  {
    'eu2yjmyh': {
      'en': 'Revisit the treasures you opened together ✨',
      'de': 'Erlebt eure geöffneten Truhen noch einmal ✨',
      'es': 'Revivan los tesoros que abrieron juntos ✨',
    },
    '865j4srr': {
      'en': '💎',
      'de': '💎',
      'es': '💎',
    },
    'znrdad42': {
      'en': 'Opened Treasure ✨',
      'de': 'Geöffnete Truhen ✨',
      'es': 'Tesoro abierto ✨',
    },
    '0jtqemkx': {
      'en': 'Tap to revisit your memories 💝',
      'de': 'Tippe, um deine Erinnerungen noch einmal zu erleben 💝',
      'es': 'Toca para revivir tus recuerdos 💝',
    },
    'ga6lipn2': {
      'en': 'Treasure Archive',
      'de': 'Truhen-Archiv',
      'es': 'Archivo de tesoros',
    },
  },
  // photo_result
  {
    'hvmxnvc8': {
      'en': 'Photos',
      'de': 'Fotos',
      'es': 'Fotos',
    },
    'iedhu318': {
      'en': 'Love Treasure',
      'de': 'Liebestruhe',
      'es': 'Tesoro del amor',
    },
  },
  // coupon_archive
  {
    '980b7qc8': {
      'en': 'Redeemed Love Coupons',
      'de': 'Eingelöste Liebesgutscheine',
      'es': 'Cupones de amor canjeados',
    },
    'ypkoodtv': {
      'en': 'A collection of every coupon you\'ve enjoyed together ✨',
      'de':
          'Eine Sammlung aller Gutscheine, die ihr gemeinsam eingelöst habt ✨',
      'es': 'Una colección de todos los cupones que han disfrutado juntos ✨',
    },
    'j5ae6s9i': {
      'en': 'Redeemed at',
      'de': 'Eingelöst am',
      'es': 'Canjeado el',
    },
    'gnrmooya': {
      'en': '💕',
      'de': '💕',
      'es': '💕',
    },
    'jfnf9ebd': {
      'en': 'Togly',
      'de': 'Togly',
      'es': 'Togly',
    },
  },
  // coupon_result
  {
    '0nkyek42': {
      'en': 'Redeemed Love Coupons',
      'de': 'Eingelöste Liebesgutscheine',
      'es': 'Cupones de amor canjeados',
    },
    'pws9oqzw': {
      'en': 'A collection of every coupon you\'ve enjoyed together ✨',
      'de':
          'Eine Sammlung aller Gutscheine, die ihr gemeinsam eingelöst habt ✨',
      'es': 'Una colección de todos los cupones que han disfrutado juntos ✨',
    },
    'sw0t48z8': {
      'en': 'Redeemed at',
      'de': 'Eingelöst am',
      'es': 'Canjeado el',
    },
    'yx8iiiqt': {
      'en': '💕',
      'de': '💕',
      'es': '💕',
    },
    'yz46j93e': {
      'en': 'Togly',
      'de': 'Togly',
      'es': 'Togly',
    },
  },
  // coupon_treasure
  {
    '9e99gwvc': {
      'en': 'Coupons from this Treasure',
      'de': 'Gutscheine aus dieser Truhe',
      'es': 'Cupones de este tesoro',
    },
    'n62fc0fc': {
      'en': 'Created at',
      'de': 'Erstellt am',
      'es': 'Creado el',
    },
    '9d154gag': {
      'en': '💕',
      'de': '💕',
      'es': '💕',
    },
    'lbnp56tb': {
      'en': 'Togly',
      'de': 'Togly',
      'es': 'Togly',
    },
  },
  // sticky_wall_view
  {
    'icfj0ygl': {
      'en': 'Love Wall',
      'de': 'Liebeswand',
      'es': 'Muro de amor',
    },
    'dm4vn71l': {
      'en': 'All the little reasons why your partner loves you 💕',
      'de': 'All die kleinen Gründe, warum Partner dich liebt 💕',
      'es': 'Todas esas pequeñas razones por las que tu pareja te ama 💕',
    },
  },
  // PairRequiredPage
  {
    'lopy9zp3': {
      'en': 'Everything Is Better Together 💜',
      'de': 'Gemeinsam ist alles schöner 💜',
      'es': 'Todo es mejor juntos 💜',
    },
    'av3d2t8v': {
      'en':
          'Create memories together, stay connected every day, and unlock the full Togly experience.',
      'de':
          'Schafft gemeinsam Erinnerungen, bleibt jeden Tag verbunden und entdeckt das volle Togly-Erlebnis',
      'es':
          'Creen recuerdos juntos, manténganse conectados cada día y descubran toda la experiencia de Togly',
    },
    'xnkiwg2y': {
      'en': '🐣 Companions',
      'de': '🐣 Love Buddy',
      'es': '🐣 Love Buddy',
    },
    'stf8dub9': {
      'en': 'Bring your Companions\' world to life.',
      'de': 'Erweckt die Welt eurer Begleiter zum Leben.',
      'es': 'Den vida al mundo de sus compañeros.',
    },
    'pxugawme': {
      'en': '💓 Heartbeat',
      'de': '💓 Heartbeat',
      'es': '💓 Heartbeat',
    },
    'upngxaqt': {
      'en': 'Stay emotionally connected every day.',
      'de': 'Bleibt jeden Tag emotional verbunden.',
      'es': 'Manténganse emocionalmente conectados cada día.',
    },
    '15lad6qi': {
      'en': '🎁 Love Treasure',
      'de': '🎁 Love Treasure',
      'es': '🎁 Love Treasure',
    },
    '3aoa4cfg': {
      'en': 'Create surprise treasures filled with love and memories.',
      'de': 'Erstellt überraschende Truhen voller Liebe und Erinnerungen.',
      'es': 'Creen tesoros sorpresa llenos de amor y recuerdos.',
    },
    'varjr2b0': {
      'en': 'And much more...',
      'de': 'Und vieles mehr...',
      'es': 'Y mucho más...',
    },
    'canjj9n0': {
      'en': '📅 Shared Calendar',
      'de': '📅 Gemeinsamer Kalender',
      'es': '📅 Calendario compartido',
    },
    'iwswj14o': {
      'en': '🖼 Shared Gallery',
      'de': '🖼️ Gemeinsame Galerie',
      'es': '🖼️ Galería compartida',
    },
    '4beo4ox9': {
      'en': '🎯 Bucket List',
      'de': '🎯 Bucket List',
      'es': '🎯 Lista de deseos',
    },
    'xygfjisq': {
      'en': '🎟 Love Coupons',
      'de': '🎟 Liebesgutscheine',
      'es': '🎟 Cupones de amor',
    },
    '1wlcw3d0': {
      'en': '💌 Love Notes',
      'de': '💌 Liebesnachrichten',
      'es': '💌 Notas de amor',
    },
    'vrpkuj7e': {
      'en': '✨ Shared Memories',
      'de': '✨ Gemeinsame Erinnerungen',
      'es': '✨ Recuerdos compartidos',
    },
    '4o3trma3': {
      'en': '🎁 Wishlist',
      'de': '🎁 Wunschliste',
      'es': '🎁 Lista de deseos',
    },
    '4mf2vpsk': {
      'en': 'Ready to experience Togly together?',
      'de': 'Bereit, Togly gemeinsam zu erleben?',
      'es': '¿Listos para disfrutar Togly juntos?',
    },
    'lo4cby94': {
      'en':
          'Connect with your partner to unlock all shared features and start building your story together.',
      'de':
          'Verbinde dich mit deinem Partner, um alle gemeinsamen Funktionen freizuschalten und eure Geschichte gemeinsam zu schreiben',
      'es':
          'Conéctate con tu pareja para desbloquear todas las funciones compartidas y comenzar a escribir su historia juntos.',
    },
    'hx2dtif5': {
      'en': 'Connect Now!',
      'de': 'Jetzt verbinden!',
      'es': '¡Conéctense ahora!',
    },
  },
  // pets_home
  {
    'rt5uai9y': {
      'en': 'Our Companions',
      'de': 'Unsere Begleiter',
      'es': 'Nuestros compañeros',
    },
    '29xv0jv7': {
      'en': 'Happiness',
      'de': 'Zufriedenheit',
      'es': 'Felicidad',
    },
    'cuvgeyju': {
      'en': '/100',
      'de': '/100',
      'es': '/100',
    },
    '4m99voe9': {
      'en': 'Bond Points collected today:',
      'de': 'Heute gesammelte Bindungspunkte:',
      'es': 'Puntos de vínculo obtenidos hoy:',
    },
    '0acnxmox': {
      'en': '😊',
      'de': '😊',
      'es': '😊',
    },
    'ci8z4e25': {
      'en': 'Your Companions are Happy!',
      'de': 'Eure Begleiter sind glücklich!',
      'es': '¡Sus compañeros están felices!',
    },
    's8w2r1za': {
      'en':
          'Your relationship is bringing their world to life. Keep sharing moments together.',
      'de':
          'Eure Beziehung bringt ihre Welt zum Leben. Schafft weiterhin gemeinsame Momente.',
      'es':
          'Su relación da vida a su mundo. Sigan compartiendo momentos juntos.',
    },
    'a78ylr7d': {
      'en': '😞',
      'de': '',
      'es': '',
    },
    'aqwrsgqg': {
      'en': 'Your Companions miss your connection.',
      'de': 'Eure Begleiter vermissen eure Nähe.',
      'es': 'Sus compañeros extrañan la conexión entre ustedes.',
    },
    'r6rlguxz': {
      'en':
          'Spend a little time together and watch their world become brighter again.',
      'de':
          'Verbringt ein wenig Zeit miteinander und lasst ihre Welt wieder heller werden.',
      'es':
          'Pasen un poco de tiempo juntos y vean cómo su mundo vuelve a brillar.',
    },
    'd0ti13o2': {
      'en': '😭',
      'de': '',
      'es': '',
    },
    'hlemvqsc': {
      'en': 'Their world needs your love.',
      'de': 'Ihre Welt braucht eure Liebe.',
      'es': 'Su mundo necesita su amor.',
    },
    'f7vtv19m': {
      'en':
          'Your relationship has been quiet lately. Share a moment together and help bring their world back to life.',
      'de':
          'Eure Beziehung war in letzter Zeit etwas ruhiger. Verbringt einen gemeinsamen Moment und helft dabei, ihre Welt wieder zum Leben zu erwecken.',
      'es':
          'Su relación ha estado un poco tranquila últimamente. Compartan un momento juntos y ayuden a que su mundo vuelva a cobrar vida.',
    },
    'qb77r4ao': {
      'en':
          'Choose which Companion\nrepresents you in Togly. \nThis affects Travel Mode, widget animations, \nand whether you appear as a dog or a cat.',
      'de':
          'Wähle aus, welcher Begleiter \ndich in Togly repräsentiert. \nDas beeinflusst den Reisemodus, \ndie Widget-Animationen \nund ob du als Hund oder Katze \nangezeigt wirst.',
      'es':
          'Elige qué compañero \nte representa en Togly. \nEsto afecta al modo viaje, las animaciones\ndel widget y si apareces como perro o gato.',
    },
  },
  // community
  {
    '0u976guz': {
      'en': '🌍 Couples Around the World',
      'de': '🌍 Paare auf der ganzen Welt',
      'es': '🌍 Parejas de todo el mundo',
    },
    'ttjne0uh': {
      'en': 'Different places. Same love.',
      'de': 'Verschiedene Orte. Dieselbe Liebe.',
      'es': 'Diferentes lugares. El mismo amor.',
    },
    'iype10qm': {
      'en':
          'Every relationship has its own story. No matter where we live, love connects us.',
      'de': '',
      'es': '',
    },
    'wupaac4v': {
      'en': '❤️ Featured Couples',
      'de': '❤️ Vorgestellte Paare',
      'es': '❤️ Parejas destacadas',
    },
    'bl26xt4v': {
      'en': '🌍 Long Distance Love',
      'de': '🌍 Fernliebe',
      'es': '🌍 Amor a distancia',
    },
    'k2modjsz': {
      'en': 'Sarah & Mateo',
      'de': '',
      'es': '',
    },
    'umarzgj6': {
      'en': '📍 Accra, Ghana ↔ Berlin, Germany',
      'de': '📍 Accra, Ghana ↔ Berlin, Germany',
      'es': '📍 Accra, Ghana ↔ Berlin, Germany',
    },
    'ypis0e7q': {
      'en':
          'We met through a language exchange app in 2023. What started as short conversations quickly turned into daily video calls, shared routines, and visits whenever we could. Even with thousands of kilometers between us, we\'ve learned that love grows through the little moments we create every day.',
      'de':
          'Wir haben uns 2023 über eine Sprachlern-App kennengelernt. Aus kurzen Gesprächen wurden schnell tägliche Videoanrufe, gemeinsame Routinen und Besuche, wann immer es möglich war. Obwohl tausende Kilometer zwischen uns liegen, haben wir gelernt, dass Liebe durch die kleinen Momente wächst, die wir jeden Tag gemeinsam schaffen.',
      'es':
          'Nos conocimos en 2023 a través de una app de intercambio de idiomas. Lo que empezó como conversaciones cortas rápidamente se convirtió en videollamadas diarias, rutinas compartidas y visitas siempre que podíamos. Aunque miles de kilómetros nos separan, hemos aprendido que el amor crece con esos pequeños momentos que creamos cada día.',
    },
    'fi5jo3ht': {
      'en': '❤️ Together for 3 years',
      'de': '❤️ Seit 3 Jahren zusammen',
      'es': '❤️ Juntos desde hace 3 años',
    },
    'l10i0m44': {
      'en': '🌍 Long Distance Love',
      'de': '🌍 Fernliebe',
      'es': '🌍 Amor a distancia',
    },
    'b15owyli': {
      'en': 'Sofia & Luca',
      'de': '',
      'es': '',
    },
    'trpefxx5': {
      'en': '📍 Barcelona, Spain ↔ Naples, Italy',
      'de': '📍 Barcelona, Spain ↔ Naples, Italy',
      'es': '📍 Barcelona, Spain ↔ Naples, Italy',
    },
    'p90bhl0k': {
      'en':
          'We met during a summer trip in Barcelona in 2024. What started as a chance conversation turned into weekend flights, late night video calls, and countless memories across two countries. Every goodbye reminds us that the next hello is always worth waiting for.',
      'de':
          'Wir haben uns 2024 während einer Reise  in Barcelona kennengelernt. Was mit einem zufälligen Gespräch begann, wurde schnell zu Wochenendflügen, nächtlichen Videoanrufen und unzähligen gemeinsamen Erinnerungen zwischen zwei Ländern. Jeder Abschied erinnert uns daran, dass sich das Warten auf das nächste Wiedersehen immer lohnt.',
      'es':
          'Nos conocimos en 2024 durante un viaje de verano a Barcelona. Lo que comenzó como una conversación casual pronto se convirtió en vuelos de fin de semana, videollamadas hasta altas horas de la noche y un sinfín de recuerdos compartidos entre dos países. Cada despedida nos recuerda que siempre vale la pena esperar el próximo reencuentro.',
    },
    'mah4e37n': {
      'en': '❤️ Together for 1 year',
      'de': '❤️ Seit 1 Jahr zusammen',
      'es': '❤️ Juntos desde hace 1 año',
    },
    'hcqlaio0': {
      'en': '🏡 Growing Together',
      'de': '🏡 Gemeinsam wachsen',
      'es': '🏡 Creciendo juntos',
    },
    'rypal767': {
      'en': 'Noah & Emily',
      'de': '',
      'es': '',
    },
    '84nt3kr6': {
      'en': '📍 Manchester, England',
      'de': '📍 Manchester, England',
      'es': '📍 Manchester, England',
    },
    'ibfj99yr': {
      'en':
          'We met through mutual friends in 2020 and quickly realized that the best moments are often the simplest ones. Whether it\'s cooking dinner, watching movies, or planning weekend trips, we\'ve learned that love grows in everyday life.',
      'de':
          'Wir haben uns 2020 durch gemeinsame Freunde kennengelernt und schnell gemerkt, dass die schönsten Momente oft die einfachsten sind. Ob wir zusammen kochen, Filme schauen oder Wochenendausflüge planen wir haben gelernt, dass Liebe im Alltag wächst.',
      'es':
          'Nos conocimos en 2020 gracias a amigos en común y enseguida nos dimos cuenta de que los mejores momentos suelen ser los más sencillos. Ya sea cocinando juntos, viendo películas o planeando escapadas de fin de semana, hemos aprendido que el amor crece en la vida cotidiana.',
    },
    'ktrs7b7s': {
      'en': '❤️ Together for 5 years',
      'de': '❤️ Seit 5 Jahren zusammen',
      'es': '❤️ Juntos desde hace 5 años',
    },
    'st6rmrfb': {
      'en': '⛷️ Travel Couple',
      'de': '⛷️ Reisepaar',
      'es': '⛷️ Pareja viajera',
    },
    'd2vp3hdi': {
      'en': 'Lena & Eva',
      'de': '',
      'es': '',
    },
    'd27z9hqh': {
      'en': '📍 Innsbruck, Austria',
      'de': '📍 Innsbruck, Austria',
      'es': '📍 Innsbruck, Austria',
    },
    'mew8bw0n': {
      'en':
          'We started as friends who loved exploring new places. Somewhere between ski trips, road trips, and countless sunsets, friendship quietly turned into love. Now every adventure feels better because we share it.',
      'de':
          'Wir haben als Freunde angefangen, die gemeinsam gerne neue Orte entdeckt haben. Irgendwo zwischen Skiurlauben, Roadtrips und unzähligen Sonnenuntergängen wurde aus Freundschaft ganz leise Liebe. Heute ist jedes Abenteuer noch schöner, weil wir es gemeinsam erleben.',
      'es':
          'Empezamos siendo amigos a los que les encantaba descubrir nuevos lugares. En algún momento, entre viajes de esquí, rutas por carretera e incontables atardeceres, la amistad se convirtió silenciosamente en amor. Ahora cada aventura es aún mejor porque la vivimos juntos.',
    },
    '6oxt5ybq': {
      'en': '❤️ Together for 3 years',
      'de': '❤️ Seit 3 Jahren zusammen',
      'es': '❤️ Juntos desde hace 3 años',
    },
    '66ji0xa9': {
      'en': '🐾 Dog Parents',
      'de': '🐾 Hundeeltern',
      'es': '🐾 Papás perrunos',
    },
    '5m93y1sg': {
      'en': 'Hannah & Chris',
      'de': '',
      'es': '',
    },
    'jscvzy0o': {
      'en': '📍 Portland, Oregon, USA',
      'de': '📍 Portland, Oregon, USA',
      'es': '📍 Portland, Oregon, USA',
    },
    'uwbghtfp': {
      'en':
          'We met while volunteering at a local animal shelter in 2019. It didn\'t take long before we adopted our first dog together, and a year later, a second one joined our little family. Some of our favorite weekends are spent hiking through forests, discovering new trails, and letting the dogs lead the way.',
      'de':
          'Wir haben uns 2019 kennengelernt, als wir gemeinsam ehrenamtlich in einem örtlichen Tierheim geholfen haben. Es dauerte nicht lange, bis wir unseren ersten Hund adoptierten, und ein Jahr später wurde unsere kleine Familie mit einem zweiten Vierbeiner komplett. Unsere schönsten Wochenenden verbringen wir damit, durch Wälder zu wandern, neue Wege zu entdecken und unseren Hunden die Richtung überlassen.',
      'es':
          'Nos conocimos en 2019 mientras hacíamos voluntariado en un refugio de animales. Poco después adoptamos a nuestro primer perro y, un año más tarde, un segundo se unió a nuestra pequeña familia. Algunos de nuestros fines de semana favoritos los pasamos caminando por el bosque, descubriendo nuevos senderos y dejando que nuestros perros marquen el camino',
    },
    'cj5qr0pg': {
      'en': '❤️ Together for 8 years',
      'de': '❤️ Seit 8 Jahren zusammen',
      'es': '❤️ Juntos desde hace 8 año',
    },
    'ogbnufe2': {
      'en': '⭐️ From LDR to Forever',
      'de': '⭐️Von LDR zu für immer',
      'es': '⭐️De la distancia para siempre',
    },
    'du1p0qhn': {
      'en': 'Valentina & Leon',
      'de': '',
      'es': '',
    },
    'lcl9loqw': {
      'en': '📍 Munich, Germany',
      'de': '📍 Munich, Germany',
      'es': '📍 Munich, Germany',
    },
    'vchcqf6d': {
      'en':
          'We met online and spent nearly four years in a long distance relationship between Colombia and Germany. Today we call Munich our home, and every year we celebrate our journey together with friends at Oktoberfest.',
      'de':
          'Wir haben uns online kennengelernt und fast vier Jahre lang eine Fernbeziehung zwischen Kolumbien und Deutschland geführt. Heute nennen wir München unser Zuhause, und jedes Jahr feiern wir unsere gemeinsame Reise mit Freunden auf dem Oktoberfest.',
      'es':
          'Nos conocimos por internet y pasamos casi cuatro años en una relación a distancia entre Colombia y Alemania. Hoy llamamos a Múnich nuestro hogar y cada año celebramos nuestro camino juntos con amigos en el Oktoberfest.',
    },
    '6g81t774': {
      'en': '❤️ Together for 5 years',
      'de': '❤️ Seit 5 Jahren zusammen',
      'es': '❤️ Juntos desde hace 5 años',
    },
    'q47b7pbt': {
      'en':
          'Every relationship has a unique journey. We\'d love to hear how your story began and what makes your relationship special.',
      'de':
          'Jede Beziehung hat ihre eigene Geschichte. Wir würden gerne erfahren, wie eure begonnen hat und was eure Beziehung besonders macht.',
      'es':
          'Cada relación tiene una historia única. Nos encantaría saber cómo comenzó la suya y qué hace especial a su relación',
    },
    '7aciow0p': {
      'en': 'Share your story',
      'de': 'Erzählt eure Geschichte',
      'es': 'Compartan su historia',
    },
  },
  // PairRequiredSheet
  {
    'ye4r1e8o': {
      'en': 'Connect with your partner 💜',
      'de': 'Verbinde dich mit deinem Partner 💜',
      'es': 'Conéctate con tu pareja 💜',
    },
    'kv3jok0y': {
      'en': 'to unlock this feature.',
      'de': 'um diese Funktion freizuschalten',
      'es': 'para desbloquear esta función',
    },
    'z6ugpr9y': {
      'en': 'Connect Now',
      'de': 'Jetzt verbinden',
      'es': 'Conectar ahora',
    },
    'wmffofz6': {
      'en': 'Maybe Later',
      'de': 'Vielleicht später',
      'es': 'Quizás más tarde',
    },
  },
  // EventSheet
  {
    'voenoph3': {
      'en': 'Add Event',
      'de': 'Ereignis hinzufügen',
      'es': 'Agregar evento',
    },
    '2goqxjkb': {
      'en': 'TITLE',
      'de': 'TITEL',
      'es': 'TÍTULO',
    },
    '4r0rrbae': {
      'en': 'What\'s the plan?',
      'de': 'Was ist der Plan?',
      'es': '¿Cuál es el plan?',
    },
    '6bmtq60e': {
      'en': 'CATEGORY',
      'de': 'KATEGORIE',
      'es': 'CATEGORÍA',
    },
    'cdympyao': {
      'en': 'Next meeting',
      'de': 'Nächstes Treffen',
      'es': 'Próximo encuentro',
    },
    '6vfariv8': {
      'en': 'Birthday',
      'de': 'Geburtstag',
      'es': 'Cumpleaños',
    },
    'ruf11nay': {
      'en': 'Trip',
      'de': 'Reise',
      'es': 'Viaje',
    },
    '3cq0z5cm': {
      'en': 'Reminder',
      'de': 'Erinnerung',
      'es': 'Recordatorio',
    },
    'c0atxtx6': {
      'en': 'Date night',
      'de': 'Date',
      'es': 'Cita',
    },
    'nr04kbos': {
      'en': 'Video call',
      'de': 'Videoanruf',
      'es': 'Videollamada',
    },
    'tykxin42': {
      'en': 'Anniversary',
      'de': 'Jubiläum',
      'es': 'Aniversario',
    },
    '1efc2xdk': {
      'en': 'Other',
      'de': 'Andere',
      'es': 'Otro',
    },
    'n54u4nmt': {
      'en': 'ALL DAY',
      'de': 'DEN GANZEN TAG',
      'es': 'TODO EL DÍA',
    },
    '1az9ltku': {
      'en': 'START',
      'de': 'START',
      'es': 'INICIO',
    },
    '5yjdhncq': {
      'en': 'END',
      'de': 'ENDE',
      'es': 'FIN',
    },
    '4gmxebmd': {
      'en': 'LOCATION',
      'de': 'ORT',
      'es': 'UBICACIÓN',
    },
    'frowm6yg': {
      'en': 'Where will you be?',
      'de': 'Wo wirst du sein?',
      'es': '¿Dónde estarás?',
    },
    '8lrc287z': {
      'en': 'NOTES',
      'de': 'BESCHREIBUNG',
      'es': 'NOTAS',
    },
    'bthrtoeb': {
      'en': 'Add any details...',
      'de': 'Füge alle Details hinzu …',
      'es': 'Agrega cualquier detalle...',
    },
    'sul5m9mj': {
      'en': 'Save Event',
      'de': 'Ereignis speichern',
      'es': 'Guardar evento',
    },
  },
  // CreateAlbumSheet
  {
    '6pj824vd': {
      'en': 'Create Album',
      'de': 'Album erstellen',
      'es': 'Crear álbum',
    },
    'xq0vhcxu': {
      'en': 'Share your memories together.',
      'de': 'Teilt eure Erinnerungen miteinander.',
      'es': 'Compartan sus recuerdos juntos.',
    },
    'xj1p4h8z': {
      'en': 'Album title',
      'de': 'Albumtitel',
      'es': 'Título del álbum',
    },
    'sge0bjwg': {
      'en': 'E.g., Happy Laughs',
      'de': 'z.B. Unsere  Hunde',
      'es': 'Ej.: Risas felices',
    },
    'ru994cl5': {
      'en': 'An album title must be specified',
      'de': 'Es muss ein Albumtitel angegeben werden.',
      'es': 'Se debe especificar un título del álbum',
    },
    '5p4q7duh': {
      'en': 'at least 2 letters',
      'de': 'mindestens 2 Buchstaben',
      'es': 'al menos 2 letras',
    },
    'kjwq95zd': {
      'en': 'maximum 40 letters',
      'de': 'maximal 40 Buchstaben',
      'es': 'máximo 40 letras',
    },
    'fof2fpyx': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Bitte wähle eine Option aus dem Dropdown-Menü',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    '73gfj4k6': {
      'en': 'Cover image',
      'de': 'Titelbild',
      'es': 'Imagen de portada',
    },
    'sfnwbcoq': {
      'en': 'Add cover',
      'de': 'Titelbild  hochladen',
      'es': 'Agregar portada',
    },
    'o1krvt50': {
      'en': 'Choose cover',
      'de': 'Titelbild auswählen',
      'es': 'Elegir portada',
    },
    'xgo6p9jr': {
      'en': 'Cancel',
      'de': 'Abbrechen',
      'es': 'Cancelar',
    },
    'dmzkqz8j': {
      'en': 'Create album',
      'de': 'Album erstellen',
      'es': 'Crear álbum',
    },
  },
  // PhotoActions
  {
    'zoingma2': {
      'en': 'What do you want to do?',
      'de': 'Was möchtest du tun?',
      'es': '¿Qué quieres hacer?',
    },
    '7z7mihi8': {
      'en': 'Download',
      'de': 'Herunterladen',
      'es': 'Descargar',
    },
    'q0inbvx6': {
      'en': 'Delete',
      'de': 'Löschen',
      'es': 'Eliminar',
    },
  },
  // GoalSheet
  {
    'c56upugs': {
      'en': 'New Bucket List Goal ✨',
      'de': 'Neues Ziel auf der Bucket Liste ✨',
      'es': 'Nuevo objetivo de la lista de deseos ✨',
    },
    'qmyxceu8': {
      'en': 'Goal Title',
      'de': 'Zieltitel',
      'es': 'Título del objetivo',
    },
    'z0krompm': {
      'en': 'Enter your dream goal...',
      'de': 'Gib dein Traumziel ein...',
      'es': 'Introduce tu objetivo soñado...',
    },
    'mpcazsrn': {
      'en': 'Enter your dream goal... is required',
      'de': 'Ist erforderlich',
      'es': 'Introducir tu objetivo soñado es obligatorio',
    },
    'r3h82s2v': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    'stxbdbdv': {
      'en': 'Category',
      'de': 'Kategorie',
      'es': 'Categoría',
    },
    '5q4j5pve': {
      'en': 'Select category',
      'de': 'Kategorie auswählen',
      'es': 'Seleccionar categoría',
    },
    'bf5095t4': {
      'en': 'Search...',
      'de': 'Suchen...',
      'es': 'Buscar...',
    },
    'du1cr1kw': {
      'en': 'Travel',
      'de': 'Reisen',
      'es': 'Viajes',
    },
    't427qcw2': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
    },
    '0p5w3gbh': {
      'en': 'Learning',
      'de': 'Lernen',
      'es': 'Aprendizaje',
    },
    '1csb8o5m': {
      'en': 'Health',
      'de': 'Gesundheit',
      'es': 'Salud',
    },
    'jzm7zpuz': {
      'en': 'Finance',
      'de': 'Finanzen',
      'es': 'Finanzas',
    },
    'k0fzzo3n': {
      'en': 'Career',
      'de': 'Karriere',
      'es': 'Carrera profesional',
    },
    'x0mv6400': {
      'en': 'Relationship',
      'de': 'Beziehung',
      'es': 'Relación',
    },
    '2yuwugz4': {
      'en': 'Creativity',
      'de': 'Kreativität',
      'es': 'Creatividad',
    },
    '3qxw2j77': {
      'en': 'Social impact',
      'de': 'Soziales',
      'es': 'Impacto social',
    },
    '75try05k': {
      'en': 'Personal Growth',
      'de': 'Persönliches Wachstum',
      'es': 'Crecimiento personal',
    },
    '181eu1rr': {
      'en': 'Fitness',
      'de': 'Fitness',
      'es': 'Fitness',
    },
    'sr9uyqga': {
      'en': 'Other',
      'de': 'Anderes',
      'es': 'Otros',
    },
    'dt9oztso': {
      'en': 'Emoji',
      'de': 'Emoji',
      'es': 'Emoji',
    },
    '4z8ryphk': {
      'en': 'Choose an emoji 😊',
      'de': 'Wähle ein Emoji 😊',
      'es': 'Elige un emoji 😊',
    },
    '9xqpqx2q': {
      'en': 'Search...',
      'de': 'Suchen...',
      'es': 'Buscar...',
    },
    'bi1tblrx': {
      'en': '😍',
      'de': '😍',
      'es': '😍',
    },
    'cjjdnhf4': {
      'en': '😋',
      'de': '😋',
      'es': '😋',
    },
    'gdq8jnvg': {
      'en': '😮',
      'de': '😮',
      'es': '😮',
    },
    'dhwblylk': {
      'en': '😎',
      'de': '😎',
      'es': '😎',
    },
    'syobbe4i': {
      'en': '💪',
      'de': '💪',
      'es': '💪',
    },
    'kvyia55y': {
      'en': '🫦',
      'de': '🫦',
      'es': '🫦',
    },
    'fmige1pv': {
      'en': '🧠',
      'de': '🧠',
      'es': '🧠',
    },
    'spcoc5n8': {
      'en': '🫂',
      'de': '🫂',
      'es': '🫂',
    },
    'pp7597mf': {
      'en': '💍',
      'de': '💍',
      'es': '💍',
    },
    '632grkyg': {
      'en': '🍳',
      'de': '🍳',
      'es': '🍳',
    },
    'e6lufh8w': {
      'en': '🐕',
      'de': '🐕',
      'es': '🐕',
    },
    'doqxcpqn': {
      'en': '✈️',
      'de': '✈️',
      'es': '✈️',
    },
    'wxpd121r': {
      'en': '🏠',
      'de': '🏠',
      'es': '🏠',
    },
    'xgkep9hg': {
      'en': '🍩',
      'de': '🍩',
      'es': '🍩',
    },
    'adtszq9f': {
      'en': '🍷',
      'de': '🍷',
      'es': '🍷',
    },
    '33t9grny': {
      'en': '🐶',
      'de': '🐶',
      'es': '🐶',
    },
    'pjxyggq4': {
      'en': '💜',
      'de': '💜',
      'es': '💜',
    },
    '152njb3a': {
      'en': '📚',
      'de': '📚',
      'es': '📚',
    },
    'jrm9brp1': {
      'en': '🎉',
      'de': '🎉',
      'es': '🎉',
    },
    '4grlehr4': {
      'en': '🌍',
      'de': '🌍',
      'es': '🌍',
    },
    'slq2c0uf': {
      'en': '🎨',
      'de': '🎨',
      'es': '🎨',
    },
    'o86nfy8h': {
      'en': '💼',
      'de': '💼',
      'es': '💼',
    },
    'llgvsohr': {
      'en': '🌱',
      'de': '🌱',
      'es': '🌱',
    },
    '4m6s0hrs': {
      'en': 'Image',
      'de': 'Bild',
      'es': 'Imagen',
    },
    'h4gvtr6c': {
      'en': 'Tap to add image',
      'de': 'Tippe, um ein Bild hinzuzufügen',
      'es': 'Toca para añadir una imagen',
    },
    'r1t64tvg': {
      'en': 'Note',
      'de': 'Beschreibung',
      'es': 'Nota',
    },
    'dqwhavq1': {
      'en': 'Add details about your goal...',
      'de': 'Beschreibe dein Ziel genauer …',
      'es': 'Añade detalles sobre tu objetivo...',
    },
    'u1hliufh': {
      'en': 'Add details about your goal... is required',
      'de': 'Ist erforderlich',
      'es': 'Añadir detalles sobre tu objetivo es obligatorio',
    },
    'p66m7pzo': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    'tqf3iki6': {
      'en': 'Progress',
      'de': 'Fortschritt',
      'es': 'Progreso',
    },
    '7o38yfrk': {
      'en': 'Choose a status...',
      'de': 'Status auswählen …',
      'es': 'Elige un estado...',
    },
    'gfgbcmkm': {
      'en': 'Search...',
      'de': 'Suchen...',
      'es': 'Buscar...',
    },
    'flc7ovnq': {
      'en': 'Planing',
      'de': 'In Planung',
      'es': 'En planificación',
    },
    '0pglw842': {
      'en': 'In progress',
      'de': 'In Arbeit',
      'es': 'En progreso',
    },
    'rhwchhop': {
      'en': 'Saving up',
      'de': 'Ansparen',
      'es': 'Ahorrando',
    },
    'rglftu74': {
      'en': 'Someday',
      'de': 'Eines Tages...',
      'es': 'Algún día',
    },
    'cn2v86f7': {
      'en': 'Percentage progress',
      'de': 'Prozentualer Fortschritt',
      'es': 'Progreso porcentual',
    },
    'kp1bt3qb': {
      'en': 'Saved, goal and currency',
      'de': 'Gespart, Ziel und Währung',
      'es': 'Ahorros, objetivo y moneda',
    },
    'ym2nhaby': {
      'en': 'Current amount...',
      'de': 'Derzeitiger Betrag …',
      'es': 'Cantidad actual...',
    },
    'g8sg8lgn': {
      'en': 'Amount target...',
      'de': 'Zielbetrag …',
      'es': 'Cantidad objetivo...',
    },
    'g2pu09an': {
      'en': 'Currency',
      'de': 'Währung',
      'es': 'Moneda',
    },
    'dl9a605w': {
      'en': 'Search...',
      'de': 'Suchen...',
      'es': 'Buscar...',
    },
    'nmlt2z1e': {
      'en': 'EUR – €',
      'de': 'EUR – €',
      'es': 'EUR – €',
    },
    '6hgetzk8': {
      'en': 'USD – \$',
      'de': 'USD – \$',
      'es': 'USD – \$',
    },
    'cj9qmu7u': {
      'en': 'GBP – £',
      'de': 'GBP – £',
      'es': 'GBP – £',
    },
    'ea5dwcle': {
      'en': 'JPY – ¥',
      'de': 'JPY – ¥',
      'es': 'JPY – ¥',
    },
    'ku92ilv3': {
      'en': 'CNY – ¥ / 元',
      'de': 'CNY – ¥ / 元',
      'es': 'CNY – ¥ / 元',
    },
    'f83oexar': {
      'en': 'INR – ₹',
      'de': 'INR – ₹',
      'es': 'INR – ₹',
    },
    '1km69tde': {
      'en': 'AUD – A\$',
      'de': 'AUD – A\$',
      'es': 'AUD – A\$',
    },
    'rwyah6dr': {
      'en': 'CAD – C\$',
      'de': 'CAD – C\$',
      'es': 'CAD – C\$',
    },
    'ke9ni4bw': {
      'en': 'CHF – Fr',
      'de': 'CHF – Fr',
      'es': 'CHF – Fr',
    },
    '953h6dnx': {
      'en': 'HKD – HK\$',
      'de': 'HKD – HK\$',
      'es': 'HKD – HK\$',
    },
    'l567mnjg': {
      'en': 'SGD – S\$',
      'de': 'SGD – S\$',
      'es': 'SGD – S\$',
    },
    'vi8olqf5': {
      'en': 'KRW – ₩',
      'de': 'KRW – ₩',
      'es': 'KRW – ₩',
    },
    'psg2y8qu': {
      'en': 'MXN – Mex\$',
      'de': 'MXN – Mex\$',
      'es': 'MXN – Mex\$',
    },
    'hqd7i396': {
      'en': 'BRL – R\$',
      'de': 'BRL – R\$',
      'es': 'BRL – R\$',
    },
    'kj5fsrmg': {
      'en': 'ZAR – R',
      'de': 'ZAR – R',
      'es': 'ZAR – R',
    },
    'h6rmhncd': {
      'en': 'TRY – ₺',
      'de': 'TRY – ₺',
      'es': 'TRY – ₺',
    },
    '7cxj48ni': {
      'en': 'RUB – ₽',
      'de': 'RUB – ₽',
      'es': 'RUB – ₽',
    },
    'syrtr0s1': {
      'en': 'AED – د.إ',
      'de': 'AED – د.إ',
      'es': 'AED – د.إ',
    },
    'g9t2e7ki': {
      'en': 'SEK – kr',
      'de': 'SEK – kr',
      'es': 'SEK – kr',
    },
    'apqh99ye': {
      'en': 'NOK – kr',
      'de': 'NOK – kr',
      'es': 'NOK – kr',
    },
    'kb0b74gt': {
      'en': 'Deadline for this goal (optional)',
      'de': 'Frist für dieses Ziel (optional)',
      'es': 'Fecha límite para este objetivo (opcional)',
    },
    '1zxkag27': {
      'en': 'Cancel',
      'de': 'Abbrechen',
      'es': 'Cancelar',
    },
    'wxe9qsru': {
      'en': 'Save Goal',
      'de': 'Ziel anlegen',
      'es': 'Guardar objetivo',
    },
  },
  // GoalDetails
  {
    'elsdcdn2': {
      'en': 'Date Added',
      'de': 'hinzugefügt am',
      'es': 'Fecha añadida',
    },
    'hqbky2sn': {
      'en': 'Target Date',
      'de': 'Zieldatum',
      'es': 'Fecha objetivo',
    },
    'nz767a10': {
      'en': 'Progress',
      'de': 'Fortschritt',
      'es': 'Progreso',
    },
  },
  // EditGoalSheet
  {
    'gsu5f2ks': {
      'en': 'Edit Goal ✨',
      'de': 'Ziel bearbeiten ✨',
      'es': 'Editar objetivo ✨',
    },
    'epzxuzru': {
      'en': 'Goal Title',
      'de': 'Zieltitel',
      'es': 'Título del objetivo',
    },
    '900ko653': {
      'en': 'Enter your dream goal...',
      'de': 'Gib dein Traumziel ein...',
      'es': 'Introduce tu objetivo soñado...',
    },
    'v56re5zd': {
      'en': 'Enter your dream goal... is required',
      'de': 'Ist erforderlich',
      'es': 'El objetivo soñado es obligatorio',
    },
    'slkj6qrp': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    'p42p9elb': {
      'en': 'Category',
      'de': 'Kategorie',
      'es': 'Categoría',
    },
    'wl64hy54': {
      'en': 'Search...',
      'de': 'Suchen...',
      'es': 'Buscar...',
    },
    'p2euvq9d': {
      'en': 'Travel',
      'de': 'Reisen',
      'es': 'Viajes',
    },
    '37zi87ef': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
    },
    '05vn97js': {
      'en': 'Learning',
      'de': 'Lernen',
      'es': 'Aprendizaje',
    },
    'qzzy75db': {
      'en': 'Health',
      'de': 'Gesundheit',
      'es': 'Salud',
    },
    'rjmhgmmn': {
      'en': 'Finance',
      'de': 'Finanzen',
      'es': 'Finanzas',
    },
    '9m7r5kp4': {
      'en': 'Career',
      'de': 'Karriere',
      'es': 'Carrera',
    },
    '8peo59wg': {
      'en': 'Relationship',
      'de': 'Beziehung',
      'es': 'Relación',
    },
    'rcp9adn8': {
      'en': 'Creativity',
      'de': 'Kreativität',
      'es': 'Creatividad',
    },
    'v6qzq5wr': {
      'en': 'Social impact',
      'de': 'Soziales',
      'es': 'Impacto social',
    },
    'n0fnpz2e': {
      'en': 'Personal Growth',
      'de': 'Persönliches Wachstum',
      'es': 'Crecimiento personal',
    },
    '8kv6rcts': {
      'en': 'Fitness',
      'de': 'Fitness',
      'es': 'Fitness',
    },
    'sm8eujox': {
      'en': 'Other',
      'de': 'Anderes',
      'es': 'Otro',
    },
    'kr2cd6wk': {
      'en': 'Emoji',
      'de': 'Emoji',
      'es': 'Emoji',
    },
    'pfrkrt6c': {
      'en': 'Search...',
      'de': 'Suchen...',
      'es': 'Buscar...',
    },
    '68cuibo9': {
      'en': '😍',
      'de': '😍',
      'es': '😍',
    },
    '73ovi3fq': {
      'en': '😋',
      'de': '😋',
      'es': '😋',
    },
    'i7uzo1vc': {
      'en': '😮',
      'de': '😮',
      'es': '😮',
    },
    '595slmhj': {
      'en': '😎',
      'de': '😎',
      'es': '😎',
    },
    '5ex67b4u': {
      'en': '💪',
      'de': '💪',
      'es': '💪',
    },
    'm93md55w': {
      'en': '🫦',
      'de': '🫦',
      'es': '🫦',
    },
    'iq4izh14': {
      'en': '🧠',
      'de': '🧠',
      'es': '🧠',
    },
    'neo7oi2e': {
      'en': '🫂',
      'de': '🫂',
      'es': '🫂',
    },
    'tcu8lzj9': {
      'en': '💍',
      'de': '💍',
      'es': '💍',
    },
    '5r8bwo4z': {
      'en': '🍳',
      'de': '🍳',
      'es': '🍳',
    },
    '2ye0c3td': {
      'en': '🐕',
      'de': '🐕',
      'es': '🐕',
    },
    'zxbvnmbs': {
      'en': '✈️',
      'de': '✈️',
      'es': '✈️',
    },
    'aod0d33b': {
      'en': '🏠',
      'de': '🏠',
      'es': '🏠',
    },
    'zjqyje32': {
      'en': '🍩',
      'de': '🍩',
      'es': '🍩',
    },
    '6j9nbc47': {
      'en': '🍷',
      'de': '🍷',
      'es': '🍷',
    },
    'k0u033zb': {
      'en': '🐶',
      'de': '🐶',
      'es': '🐶',
    },
    'xu5rc02l': {
      'en': '💜',
      'de': '💜',
      'es': '💜',
    },
    'htjnp5mh': {
      'en': '📚',
      'de': '📚',
      'es': '📚',
    },
    '40j8aji9': {
      'en': '🎉',
      'de': '🎉',
      'es': '🎉',
    },
    'fl6ch3k4': {
      'en': '🌍',
      'de': '🌍',
      'es': '🌍',
    },
    'mgthwk29': {
      'en': '🎨',
      'de': '🎨',
      'es': '🎨',
    },
    '49m8eorn': {
      'en': '💼',
      'de': '💼',
      'es': '💼',
    },
    '8lh5o93c': {
      'en': '🌱',
      'de': '🌱',
      'es': '🌱',
    },
    'm9dow2p9': {
      'en': 'Note',
      'de': 'Beschreibung',
      'es': 'Nota',
    },
    'ho2lkxrx': {
      'en': 'Add details about your goal...',
      'de': 'Beschreibe dein Ziel genauer …',
      'es': 'Añade detalles sobre tu objetivo...',
    },
    'ymndcvum': {
      'en': 'Add details about your goal... is required',
      'de': 'Ist erforderlich',
      'es': 'Los detalles del objetivo son obligatorios',
    },
    'myyrzefh': {
      'en': 'Please choose an option from the dropdown',
      'de': 'Wähle eine Option aus dem Dropdown-Menü.',
      'es': 'Por favor, elige una opción del menú desplegable',
    },
    '1fxnpix7': {
      'en': 'Progress',
      'de': 'Fortschritt',
      'es': 'Progreso',
    },
    'v6jgaado': {
      'en': '',
      'de': '',
      'es': '',
    },
    'w80xd7a8': {
      'en': 'Search...',
      'de': 'Suchen...',
      'es': 'Buscar...',
    },
    '4zn1osq8': {
      'en': 'Planning',
      'de': 'In Planung',
      'es': 'En planificación',
    },
    'ffwuqtat': {
      'en': 'In progress',
      'de': 'In Arbeit',
      'es': 'En progreso',
    },
    'v84bhtwe': {
      'en': 'Saving up',
      'de': 'Ansparen',
      'es': 'Ahorrando',
    },
    'z3rk4bhr': {
      'en': 'Someday',
      'de': 'Eines Tages...',
      'es': 'Algún día',
    },
    'cml4i8m5': {
      'en': 'Percentage progress',
      'de': 'Prozentualer Fortschritt',
      'es': 'Progreso porcentual',
    },
    'ux4234r3': {
      'en': 'Saved, goal and currency',
      'de': 'Gespart, Ziel und Währung',
      'es': 'Ahorros, objetivo y moneda',
    },
    'n3o73w58': {
      'en': '',
      'de': '',
      'es': '',
    },
    '26shv75u': {
      'en': 'Search...',
      'de': 'Suchen...',
      'es': 'Buscar...',
    },
    's63w32r8': {
      'en': 'EUR – €',
      'de': 'EUR – €',
      'es': 'EUR – €',
    },
    'q52vsvsf': {
      'en': 'USD – \$',
      'de': 'USD – \$',
      'es': 'USD – \$',
    },
    'xuvzongq': {
      'en': 'GBP – £',
      'de': 'GBP – £',
      'es': 'GBP – £',
    },
    'qylip5jo': {
      'en': 'JPY – ¥',
      'de': 'JPY – ¥',
      'es': 'JPY – ¥',
    },
    '8xslm7p1': {
      'en': 'CNY – ¥ / 元',
      'de': 'CNY – ¥ / 元',
      'es': 'CNY – ¥ / 元',
    },
    '7kscxxk8': {
      'en': 'INR – ₹',
      'de': 'INR – ₹',
      'es': 'INR – ₹',
    },
    'bc9n0yap': {
      'en': 'AUD – A\$',
      'de': 'AUD – A\$',
      'es': 'AUD – A\$',
    },
    'kvbiie89': {
      'en': 'CAD – C\$',
      'de': 'CAD – C\$',
      'es': 'CAD – C\$',
    },
    '61ywvnrb': {
      'en': 'CHF – Fr',
      'de': 'CHF – Fr',
      'es': 'CHF – Fr',
    },
    'vop9vtvv': {
      'en': 'HKD – HK\$',
      'de': 'HKD – HK\$',
      'es': 'HKD – HK\$',
    },
    'khk98ksj': {
      'en': 'SGD – S\$',
      'de': 'SGD – S\$',
      'es': 'SGD – S\$',
    },
    'zc7skcgf': {
      'en': 'KRW – ₩',
      'de': 'KRW – ₩',
      'es': 'KRW – ₩',
    },
    '54u9svzk': {
      'en': 'MXN – Mex\$',
      'de': 'MXN – Mex\$',
      'es': 'MXN – Mex\$',
    },
    'n2jnyr7u': {
      'en': 'BRL – R\$',
      'de': 'BRL – R\$',
      'es': 'BRL – R\$',
    },
    't82mzc7u': {
      'en': 'ZAR – R',
      'de': 'ZAR – R',
      'es': 'ZAR – R',
    },
    '4se9bema': {
      'en': 'TRY – ₺',
      'de': 'TRY – ₺',
      'es': 'TRY – ₺',
    },
    '9jyn3xr5': {
      'en': 'RUB – ₽',
      'de': 'RUB – ₽',
      'es': 'RUB – ₽',
    },
    'ysfwh4o4': {
      'en': 'AED – د.إ',
      'de': 'AED – د.إ',
      'es': 'AED – د.إ',
    },
    'fl7o50vd': {
      'en': 'SEK – kr',
      'de': 'SEK – kr',
      'es': 'SEK – kr',
    },
    '30d75cdk': {
      'en': 'NOK – kr',
      'de': 'NOK – kr',
      'es': 'NOK – kr',
    },
    '4x1ey4h7': {
      'en': 'Deadline for this goal (optional)',
      'de': 'Frist für dieses Ziel (optional)',
      'es': 'Fecha límite para este objetivo (opcional)',
    },
    '7jyanekb': {
      'en': 'Cancel',
      'de': 'Abbrechen',
      'es': 'Cancelar',
    },
    'jac4fnc5': {
      'en': 'Edit Goal',
      'de': 'Ziel bearbeiten',
      'es': 'Editar objetivo',
    },
  },
  // GoalActions
  {
    'dmkvk31l': {
      'en': 'Delete',
      'de': 'Löschen',
      'es': 'Eliminar',
    },
  },
  // WishCompActions
  {
    'kxtmjz6v': {
      'en': 'Delete',
      'de': 'Löschen',
      'es': 'Eliminar',
    },
  },
  // AddWishSheet
  {
    'xxv7098i': {
      'en': 'Add a wish',
      'de': 'Füge einen Wunsch hinzu',
      'es': 'Añadir un deseo',
    },
    'yjnh6spa': {
      'en': 'Share your wishes \nwith your partner',
      'de': 'Teile deine Wünsche mit deinem Partner',
      'es': 'Comparte tus deseos con tu pareja',
    },
    'ilgigjx2': {
      'en': 'Title',
      'de': 'Titel',
      'es': 'Título',
    },
    'grl8vaax': {
      'en': 'Enter your wish title...',
      'de': 'Wunschtitel eingeben …',
      'es': 'Introduce el título de tu deseo...',
    },
    'fwozmae4': {
      'en': 'Category',
      'de': 'Kategorie',
      'es': 'Categoría',
    },
    '43bxpzmn': {
      'en': '💞 Relationship',
      'de': '💞 Beziehung',
      'es': '💞 Relación',
    },
    'r6wh2thy': {
      'en': '🎁 Gift',
      'de': '🎁 Geschenk',
      'es': '🎁 Regalo',
    },
    'lkig1m22': {
      'en': '✨ Experience',
      'de': '✨ Erleben',
      'es': '✨ Experiencia',
    },
    '1yl4raub': {
      'en': '🌍 Travel',
      'de': '🌍 Reisen',
      'es': '🌍 Viajes',
    },
    'tby65khm': {
      'en': '🧭 Adventure',
      'de': '🧭 Abenteuer',
      'es': '🧭 Aventura',
    },
    'fd7opl9a': {
      'en': '🍽️ Food',
      'de': '🍽️ Essen',
      'es': '🍽 Comida',
    },
    'bys1ema8': {
      'en': '🐾 Pet',
      'de': '🐾 Haustier',
      'es': '🐾 Mascota',
    },
    '97ts9e1y': {
      'en': '🏷️ Clothing',
      'de': '🏷️ Kleidung',
      'es': '🏷️ Ropa',
    },
    'o7h7zgoz': {
      'en': '💍 Jewelry',
      'de': '💍 Schmuck',
      'es': '💍 Joyería',
    },
    '2siyhtvq': {
      'en': '💫 Other',
      'de': '💫 Sonstiges',
      'es': '💫 Otro',
    },
    'kv53sxnu': {
      'en': '',
      'de': '',
      'es': '',
    },
    'xnkxevgc': {
      'en': 'Note',
      'de': 'Beschreibung',
      'es': 'Nota',
    },
    'wn4tl04o': {
      'en': 'Add details about your wish...',
      'de': 'Beschreibe deinen Wunsch genauer …',
      'es': 'Añade detalles sobre tu deseo...',
    },
    'xkw73dqo': {
      'en': 'Link',
      'de': 'Link',
      'es': 'Enlace',
    },
    'hseauo5o': {
      'en': '',
      'de': '',
      'es': '',
    },
    'tfawrbur': {
      'en': 'Direct link to your wish (optional)',
      'de': 'Direkter Link zu deinem Wunsch (optional)',
      'es': 'Enlace directo a tu deseo (opcional)',
    },
    'bkyuv04n': {
      'en': 'Pick image',
      'de': 'Bild auswählen',
      'es': 'Seleccionar imagen',
    },
    'qul44k26': {
      'en': 'Share wish',
      'de': 'Wunsch teilen',
      'es': 'Compartir deseo',
    },
    '6yg3416b': {
      'en': 'Cancel',
      'de': 'Abbrechen',
      'es': 'Cancelar',
    },
  },
  // WishActions
  {
    'mcasegh5': {
      'en': 'What do you want to do?',
      'de': 'Was möchtest du tun?',
      'es': '¿Qué quieres hacer?',
    },
    'sq2xwj97': {
      'en': 'Mark wish as completed',
      'de': 'Wunsch als erledigt markieren',
      'es': 'Marcar deseo como completado',
    },
    'dpgnu8p7': {
      'en': 'Delete wish',
      'de': 'Wunsch löschen',
      'es': 'Eliminar deseo',
    },
  },
  // languagesheet
  {
    'qfkos51f': {
      'en': 'Choose your app language',
      'de': 'Wähle  deine App-Sprache',
      'es': 'Elige el idioma de la app',
    },
    'kgurehvo': {
      'en': 'English',
      'de': 'Englisch',
      'es': 'Inglés',
    },
    'sdoewov9': {
      'en': 'Español',
      'de': 'Spanisch',
      'es': 'Español',
    },
    'fqilca0n': {
      'en': 'Français',
      'de': 'Französisch',
      'es': 'Francés',
    },
    'orc83kzl': {
      'en': 'German',
      'de': 'Deutsch',
      'es': 'Alemán',
    },
    'c1fpskvf': {
      'en': 'Italiano',
      'de': 'Italienisch',
      'es': 'Italiano',
    },
    '0kexj8ox': {
      'en': 'Português',
      'de': 'Portugiesisch',
      'es': 'Portugués',
    },
  },
  // HeaderCouple
  {
    'alb6wlqu': {
      'en': 'Send love',
      'de': 'Sende Liebe',
      'es': 'Enviar amor',
    },
  },
  // sharecard_heartbeat
  {
    'th6wnol7': {
      'en': 'Check your heartbeat together',
      'de': 'Euer gemeinsamer Herzschlag',
      'es': 'Revisen su latido juntos',
    },
    'qni7nzoq': {
      'en': 'TOGLY - Couple App',
      'de': 'TOGLY – Paar App',
      'es': 'TOGLY - App para parejas',
    },
    'srn56162': {
      'en':
          'Our relationship heartbeat today ❤️\n\nHow connected are you and your partner?\nTry it on Togly.',
      'de':
          'Der Herzschlag unserer Beziehung ❤️\n\nWie verbunden seid ihr?\nProbiert es aus, auf Togly.',
      'es':
          'El latido de nuestra relación hoy ❤️\n\n¿Qué tan conectados están tú y tu pareja?\nPruébenlo en Togly.',
    },
    'c73t2mtx': {
      'en': 'Share now',
      'de': 'Jetzt teilen',
      'es': 'Compartir ahora',
    },
    '1e155pgf': {
      'en': 'on Togly',
      'de': 'auf Togly',
      'es': 'en Togly',
    },
  },
  // surprise_sheet
  {
    '7a8we55z': {
      'en': 'Add a Surprise',
      'de': 'Überraschung hinzufügen',
      'es': 'Añadir una sorpresa',
    },
    'feh16ik7': {
      'en': 'Choose something special to hide inside your treasure',
      'de': 'Wähle etwas Besonderes für die Truhe aus',
      'es': 'Elige algo especial para guardar en tu tesoro',
    },
    'p76os17p': {
      'en': 'Voice Notes',
      'de': 'Sprachnachrichten',
      'es': 'Notas de voz',
    },
    'qsctfqno': {
      'en': 'A voice message for your partner 💜',
      'de': 'Eine Sprachnachricht für Partner 💜',
      'es': 'Un mensaje de voz para tu pareja 💜',
    },
    'zi7h0tqi': {
      'en': 'Photos',
      'de': 'Fotos',
      'es': 'Fotos',
    },
    '0hwkohw8': {
      'en': 'Photos captured just for your partner 📸',
      'de': 'Fotos, nur für deinen Partner 📸',
      'es': 'Fotos tomadas solo para tu pareja 📸',
    },
    'drm9b1kb': {
      'en': 'Love Coupons',
      'de': 'Liebesgutscheine',
      'es': 'Cupones de amor',
    },
    'b9upn8zf': {
      'en': 'Use it anytime for something special… 😉',
      'de': 'Jederzeit für etwas Besonderes nutzbar… 😉',
      'es': 'Úsalo en cualquier momento para algo especial… 😉',
    },
    'aek7273a': {
      'en': 'Reason I Love You',
      'de': 'Warum ich dich liebe',
      'es': 'Razón por la que te amo',
    },
    'zk4v75y4': {
      'en': 'Little reminders of why you love your partner✨',
      'de': 'Kleine Erinnerungen, warum du deinen Partner liebst ✨',
      'es': 'Pequeños recordatorios de por qué amas a tu pareja ✨',
    },
    'b2fpjj4s': {
      'en': 'Your partner won\'t see it until the treasure opens',
      'de': 'Dein Partner sieht es erst, wenn das Truhe geöffnet wird',
      'es': 'Tu pareja no lo verá hasta que se abra el tesoro',
    },
  },
  // voice_note_sheet
  {
    '1nh6bd27': {
      'en': 'Voice Note',
      'de': 'Sprachnachricht',
      'es': 'Nota de voz',
    },
    '298iw1t3': {
      'en': 'Record something your partner can keep forever 💜',
      'de': 'Nimm etwas auf, das Partner für immer behalten kann 💜',
      'es': 'Graba algo que tu pareja pueda guardar para siempre 💜',
    },
    'weshdnpr': {
      'en': 'Stop',
      'de': 'Stoppen',
      'es': 'Detener',
    },
    'flbcteqj': {
      'en': 'Preview',
      'de': 'Vorschau',
      'es': 'Vista previa',
    },
    '5hu1alyf': {
      'en': 'Give this voice note a little title...',
      'de': 'Gib dieser Sprachnachricht einen kleinen Titel...',
      'es': 'Dale un pequeño título a esta nota de voz...',
    },
    'du6g8joj': {
      'en': '',
      'de': '',
      'es': '',
    },
    'ww7ts9or': {
      'en': 'Give this voice note a little title... is required',
      'de': '',
      'es': '',
    },
    '1d2432go': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
    },
    'uv5jbbxz': {
      'en': 'Put it in the Treasure',
      'de': 'In die Truhe legen',
      'es': 'Guardarlo en el tesoro',
    },
    '1wqdrw6v': {
      'en': 'Cancel',
      'de': 'Abbrechen',
      'es': 'Cancelar',
    },
  },
  // photo_sheet
  {
    'wc3knxz6': {
      'en': 'Add Photos',
      'de': 'Fotos hinzufügen',
      'es': 'Añadir fotos',
    },
    'jynlfp8w': {
      'en': 'Choose a special photo to hide inside your treasure',
      'de': 'Wähle ein besonderes Foto für deine Truhe aus',
      'es': 'Elige una foto especial para guardar en tu tesoro',
    },
    'bt4uzokv': {
      'en': 'Take Photo',
      'de': 'Aufnehmen',
      'es': 'Tomar foto',
    },
    'f97nq024': {
      'en': 'From Gallery',
      'de': 'Galerie',
      'es': 'Desde la galería',
    },
    'lp7n1trd': {
      'en': 'No photo selected yet',
      'de': 'Noch kein Foto ausgewählt',
      'es': 'Aún no se ha seleccionado ninguna foto',
    },
    'obcsc800': {
      'en': 'Choose or take a photo to preview it here',
      'de': 'Wähle ein Foto aus oder nimm eines auf, um es hier zu sehen',
      'es': 'Elige una foto o toma una para verla aquí',
    },
    'fkae07is': {
      'en': '',
      'de': '',
      'es': '',
    },
    'seij3wbi': {
      'en': 'Title of the image',
      'de': 'Titel des Bildes',
      'es': 'Título de la imagen',
    },
    'm5x3mduw': {
      'en': 'Your partner won\'t see it until the treasure opens',
      'de': 'Dein Partner sieht es erst, wenn die Truhe geöffnet wird',
      'es': 'Tu pareja no lo verá hasta que se abra el tesoro',
    },
    'a26rxixq': {
      'en': 'Title of the image is required',
      'de': '',
      'es': '',
    },
    '0mu4osix': {
      'en': 'Please choose an option from the dropdown',
      'de': '',
      'es': '',
    },
    'nvwyd8yl': {
      'en': 'Cancel',
      'de': 'Abbrechen',
      'es': 'Cancelar',
    },
    'gy3atfo5': {
      'en': 'Put it in the Treasure',
      'de': 'In die Truhe legen',
      'es': 'Guardarlo en el tesoro',
    },
  },
  // empty_state_coupons
  {
    '0l1fjzxy': {
      'en': 'No Love Coupons Yet',
      'de': 'Noch keine Liebesgutscheine',
      'es': 'Aún no hay cupones de amor',
    },
    'lihfns0c': {
      'en':
          'Love Coupons from opened Treasures will appear here. Start exploring to surprise your partner!',
      'de': 'Liebesgutscheine aus geöffneten Truhen werden hier angezeigt.',
      'es':
          'Los cupones de amor de los tesoros abiertos aparecerán aquí. ¡Explora los tesoros y sorprende a tu pareja!',
    },
  },
  // treasure_comp
  {
    'phghi28d': {
      'en': '💎',
      'de': '',
      'es': '',
    },
    'sqdezkgo': {
      'en': 'No treasure yet',
      'de': 'Noch keine Truhe',
      'es': 'Aún no hay ningún tesoro',
    },
    'vtyz92r1': {
      'en': 'Your treasures will appear here',
      'de': 'Deine Truhen werden hier angezeigt',
      'es': 'Tus tesoros aparecerán aquí',
    },
  },
  // empty_treasure_archive
  {
    'tzoeu6d8': {
      'en': 'No Love Treasure yet',
      'de': 'Noch keine Liebestruhen',
      'es': 'Aún no hay tesoros del amor',
    },
    '7rgeh6lf': {
      'en':
          'Love Treasures you create together will appear here. Start a treasure and fill it with special surprises!',
      'de':
          'Liebestruhen, die ihr gemeinsam erstellt, werden hier angezeigt. Erstellt eine Truhe und füllt sie mit besonderen Überraschungen!',
      'es':
          'Los tesoros del amor que creen juntos aparecerán aquí. ¡Crea un tesoro y llénalo de sorpresas especiales!',
    },
  },
  // Post-It-Sheet
  {
    '08byk3vz': {
      'en': 'Add a Reason 💕',
      'de': 'Grund hinzufügen💕',
      'es': 'Añadir una razón💕',
    },
    'egrdsu3c': {
      'en': 'Write one little reason why you love your partner.',
      'de': 'Schreibe einen kleinen Grund, warum du Partner liebst.',
      'es': 'Escribe una pequeña razón por la que amas a tu pareja.',
    },
    '26s134fd': {
      'en': 'I love you because…',
      'de': 'Ich liebe dich, weil…',
      'es': 'Te amo porque…',
    },
    '7z8un93w': {
      'en': 'Your partner will discover this \nwhen the treasure opens',
      'de': 'Dein Partner kann es erst sehen, sobald die Truhe geöffnet wird ',
      'es': 'Tu pareja lo descubrirá cuando se abra el tesoro',
    },
    'wiad4g0w': {
      'en': 'Pin to wall',
      'de': 'Anheften',
      'es': 'Fijar en el muro',
    },
  },
  // empty_note_sticky
  {
    'g9f5opuu': {
      'en': 'No Love Note yet',
      'de': 'Noch keine Liebestruhen',
      'es': 'Aún no hay tesoros del amor',
    },
    '5e8dgiqb': {
      'en':
          'Reasons you add for your partner will appear here. Start filling your wall with little reminders of your love!',
      'de':
          'Gründe, die du für deinen Partner hinzufügst, werden hier angezeigt. Fülle deine Liebeswand mit kleinen Erinnerungen an eure Liebe!',
      'es':
          'Las razones que añadas para tu pareja aparecerán aquí. ¡Llena tu muro de amor con pequeños recordatorios de tu amor!',
    },
  },
  // empty_state_photos
  {
    '9q7duuc2': {
      'en': 'No Photos',
      'de': 'Keine Bilder',
      'es': 'No hay fotos',
    },
    'p8pzzkni': {
      'en': 'Your partner didn\'t add any photos to the treasure this time 😔',
      'de': 'Dein Partner hat dieses Mal keine Fotos in die Truhe gelegt 😔',
      'es': 'Tu pareja no añadió ninguna foto al tesoro esta vez 😔',
    },
  },
  // empty_state_voicenote
  {
    '4gudvrt6': {
      'en': 'No Voice Note',
      'de': 'Keine Sprachnachricht',
      'es': 'No hay ninguna nota de voz',
    },
    '084ui0o4': {
      'en':
          'Your partner didn\'t add any voice note to the treasure this time😔',
      'de':
          'Dein Partner hat dieses Mal keine Sprachnachricht in die Truhe gelegt 😔',
      'es': 'Tu pareja no añadió ninguna nota de voz al tesoro esta vez 😔',
    },
  },
  // empty_note_sticky_view
  {
    'zbtgyy3p': {
      'en': 'No Love Note',
      'de': 'Keine Liebestruhen',
      'es': 'Aún no hay ninguna nota de amor',
    },
    'x2kwl2zp': {
      'en':
          'Your partner didn\'t add any love note to the treasure this time😔',
      'de':
          'Dein Partner hat dieses Mal keine Liebesnachricht in die Truhe gelegt😔',
      'es': 'Tu pareja no añadió ninguna nota de amor al tesoro esta vez😔',
    },
  },
  // HeaderReconnect
  {
    'wro092ca': {
      'en': 'Your story isn\'t over',
      'de': 'Eure Geschichte ist noch nicht zu Ende',
      'es': 'Su historia aún no ha terminado',
    },
    'xrs1mwvm': {
      'en': 'Everything you created together is still waiting for you',
      'de': 'Alles, was ihr gemeinsam geschaffen habt, wartet noch auf euch',
      'es': 'Todo lo que crearon juntos sigue esperándolos',
    },
    '97yckcwt': {
      'en': 'Reconnect now',
      'de': 'Wieder verbinden',
      'es': '¡Reconéctense ahora',
    },
  },
  // HeaderSingle
  {
    '0yqq7r7u': {
      'en': 'Connect and get started! 💜',
      'de': 'Verbinden und loslegen! 💜',
      'es': '¡Conéctense y comiencen! 💜',
    },
    'vegy8hi0': {
      'en':
          'Connect with someone special\nand start building your shared story.',
      'de':
          'Verbinde dich mit jemand Besonderem\nund beginnt gemeinsam eure Geschichte.',
      'es': 'Conéctate con alguien especial \ny comiencen juntos su historia.',
    },
    'rsvjhnda': {
      'en': 'Connect with your Partner 💜',
      'de': 'Mit Partner verbinden 💜',
      'es': 'Conéctate con tu pareja 💜',
    },
  },
  // PetName-Sheet
  {
    'y3xiunxl': {
      'en': 'Change Name',
      'de': '',
      'es': '',
    },
    'ejbmnfhg': {
      'en': 'Choose a new name for your Companion.',
      'de': 'Wähle einen neuen Namen für deinen Begleiter.',
      'es': 'Elige un nuevo nombre para tu compañero.',
    },
    '90d6wzrw': {
      'en': 'Cancel',
      'de': '',
      'es': '',
    },
    'n6r725jk': {
      'en': 'Save',
      'de': '',
      'es': '',
    },
  },
  // GPS_Sheet
  {
    'lu6m90k6': {
      'en': 'Your journey begins soon ✈️',
      'de': 'Die Reise beginnt bald ✈️',
      'es': 'Su viaje comienza muy pronto ✈️',
    },
    'kirxdn4z': {
      'en':
          'Share your journey in real time. Your partner can follow your progress.',
      'de':
          'Teile deine Reise in Echtzeit. Dein Partner kann deinen Fortschritt verfolgen.',
      'es':
          'Comparte tu viaje en tiempo real. Tu pareja podrá seguir tu progreso.',
    },
    'c72ixq83': {
      'en':
          'Your exact location is never shared. Only your travel progress is visible to your partner.\n\nGPS tracking starts automatically when your journey begins and stops once you\'re together.\n\nIf you\'d rather decide later, you can always enable it in your profile settings.',
      'de':
          'Dein genauer Standort wird niemals geteilt. Nur dein Reisefortschritt ist für deinen Partner sichtbar.\n\nDie GPS-Ortung startet automatisch, sobald deine Reise beginnt, und endet, sobald ihr wieder zusammen seid.\n\nWenn du dich jetzt noch nicht entscheiden möchtest, kannst du sie jederzeit in deinen Profileinstellungen aktivieren.',
      'es':
          'Tu ubicación exacta nunca se comparte. Solo el progreso de tu viaje es visible para tu pareja.\n\nEl seguimiento por GPS comienza automáticamente cuando inicia tu viaje y se detiene cuando vuelven a estar juntos.\n\nSi prefieres decidirlo más tarde, siempre puedes activarlo en la configuración de tu perfil.',
    },
    'qkgzqdjs': {
      'en': '📍Enable Live Tracking',
      'de': '📍Live-Tracking aktivieren',
      'es': '📍Activar seguimiento en tiempo real',
    },
    '6o33sy6h': {
      'en': 'Not now',
      'de': 'Jetzt nicht',
      'es': 'Ahora no',
    },
  },
  // StoryCard
  {
    '5vb1ail0': {
      'en': 'Mateo & Elena',
      'de': '',
      'es': '',
    },
    '3qkgdgli': {
      'en': 'Madrid, Spain',
      'de': '',
      'es': '',
    },
    'i8mdklhk': {
      'en': 'Different Cultures',
      'de': '',
      'es': '',
    },
    'a6lebsob': {
      'en':
          'A chance meeting in a rainy bookstore in London led to a lifetime of adventures across borders and languages.',
      'de': '',
      'es': '',
    },
    'qqruli8t': {
      'en': '❤️ Together for 3 years',
      'de': '',
      'es': '',
    },
  },
  // Miscellaneous
  {
    '4mzt2cph': {
      'en':
          'Togly uses your camera so you can take photos for your partner and add them to Love Treasure surprises.',
      'de': '',
      'es': '',
    },
    'aaikdy5i': {
      'en': 'Allow Togetherly to save photos to your library',
      'de': '',
      'es': '',
    },
    'wkp12prd': {
      'en':
          'Togly uses your microphone so you can record voice messages for your partner and add them to Love Treasure surprises.',
      'de': '',
      'es': '',
    },
    'mgmgoh4n': {
      'en':
          'Togly uses your location during your journey so your partner can follow your travel progress. Your exact location is never shared.',
      'de': '',
      'es': '',
    },
    'r1x8bma4': {
      'en': '',
      'de': '',
      'es': '',
    },
    'ps9v3aeh': {
      'en': '',
      'de': '',
      'es': '',
    },
    'a0iv0evh': {
      'en': '',
      'de': '',
      'es': '',
    },
    'b9p53oaz': {
      'en': '',
      'de': '',
      'es': '',
    },
    'na5pqk6a': {
      'en': '',
      'de': '',
      'es': '',
    },
    '5diz56i0': {
      'en': '',
      'de': '',
      'es': '',
    },
    'npvmvzxf': {
      'en': '',
      'de': '',
      'es': '',
    },
    'ezqiofev': {
      'en': '',
      'de': '',
      'es': '',
    },
    'wsp3ykvf': {
      'en': '',
      'de': '',
      'es': '',
    },
    'foruqlix': {
      'en': '',
      'de': '',
      'es': '',
    },
    'hq768j51': {
      'en': '',
      'de': '',
      'es': '',
    },
    'mm91zxin': {
      'en': '',
      'de': '',
      'es': '',
    },
    '8bug8pab': {
      'en': '',
      'de': '',
      'es': '',
    },
    'kosmjktx': {
      'en': '',
      'de': '',
      'es': '',
    },
    'ng4eto65': {
      'en': '',
      'de': '',
      'es': '',
    },
    'y3auiwpw': {
      'en': '',
      'de': '',
      'es': '',
    },
    '8ddkrxao': {
      'en': '',
      'de': '',
      'es': '',
    },
    't20w6lil': {
      'en': '',
      'de': '',
      'es': '',
    },
    'rpmfxg0z': {
      'en': '',
      'de': '',
      'es': '',
    },
    '8m5u3dzl': {
      'en': '',
      'de': '',
      'es': '',
    },
    '2wmnmh42': {
      'en': '',
      'de': '',
      'es': '',
    },
    'n603duwe': {
      'en': '',
      'de': '',
      'es': '',
    },
    'llytpcb9': {
      'en': '',
      'de': '',
      'es': '',
    },
    'gjjt2o4e': {
      'en': '',
      'de': '',
      'es': '',
    },
    'rir8qic0': {
      'en': '',
      'de': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
