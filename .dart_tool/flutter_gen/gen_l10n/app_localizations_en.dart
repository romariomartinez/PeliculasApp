import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Movies App';

  @override
  String get loading => 'Loading...';

  @override
  String get errorLoading => 'Error loading movies';

  @override
  String get searchHint => 'Search movie...';

  @override
  String get favorites => 'Favorites';
}
