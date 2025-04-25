import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Películas App';

  @override
  String get loading => 'Cargando...';

  @override
  String get errorLoading => 'Error al cargar las películas';

  @override
  String get searchHint => 'Buscar película...';

  @override
  String get favorites => 'Favoritos';
}
