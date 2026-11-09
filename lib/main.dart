import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:battery_plus/battery_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppController()),
      ],
      child: const NetBatteryGuardApp(),
    ),
  );
}

// ==================== قاموس اللغات الشامل (7 لغات) ====================
class AppTranslations {
  static final Map<String, Map<String, String>> data = {
    'ar': {
      'app_title': 'القاطع الشامل وعداد البطارية',
      'tab_blocker': 'القاطع',
      'tab_battery': 'عداد البطارية',
      'tab_settings': 'الإعدادات',
      'select_all': 'تحديد الكل (قطع الإنترنت عن الكل)',
      'show_system': 'إظهار تطبيقات وأدوات النظام وجميع العمليات',
      'search_hint': 'ابحث عن أي تطبيق أو خدمة نظام...',
      'blocked_status': 'الإنترنت مقطوع ✓',
      'allowed_status': 'متصل بالإنترنت',
      'system_badge': 'نظام',
      'user_badge': 'تطبيق',
      'service_badge': 'خدمة خلفية',
      'menu_mega_counter': 'عداد الميجا (استهلاك التطبيقات المفتوحة)',
      'menu_rate': 'تقييم التطبيق',
      'menu_suggest': 'إرسال مقترح',
      'theme_title': 'المظهر',
      'theme_dark': 'داكن',
      'theme_light': 'فاتح',
      'theme_system': 'حسب الجهاز',
      'lang_title': 'اللغة (Language)',
      'battery_rem': 'نسبة البطارية المتبقية',
      'time_rem': 'الوقت المتبقي بدقة قبل النفاد',
      'hours': 'ساعة',
      'minutes': 'دقيقة',
      'power_apps': 'التطبيقات والعمليات المستهلكة للطاقة بدقة',
      'mega_dialog_title': 'عداد الميجا للتطبيقات المفتوحة',
      'total_usage': 'إجمالي استهلاك الميجا الحالي',
      'rate_dialog_title': 'تقييم التطبيق',
      'rate_thanks': 'شكراً لتقييمك!',
      'suggest_dialog_title': 'إرسال مقترح',
      'suggest_hint': 'اكتب مقترحك أو ملاحظتك هنا...',
      'suggest_sent': 'تم إرسال مقترحك بنجاح!',
      'send': 'إرسال',
      'close': 'إغلاق',
      'open_state': 'مفتوح الآن',
      'bg_state': 'يعمل بالخلفية',
      'blocked_count': 'المقطوع عنها الإنترنت',
    },
    'en': {
      'app_title': 'Net Blocker & Battery Counter',
      'tab_blocker': 'Blocker',
      'tab_battery': 'Battery Counter',
      'tab_settings': 'Settings',
      'select_all': 'Select All (Cut Internet for All)',
      'show_system': 'Show All System Apps & Background Processes',
      'search_hint': 'Search any app or system service...',
      'blocked_status': 'Internet Blocked ✓',
      'allowed_status': 'Internet Connected',
      'system_badge': 'System',
      'user_badge': 'App',
      'service_badge': 'Service',
      'menu_mega_counter': 'Mega Counter (Open Apps Usage)',
      'menu_rate': 'Rate App',
      'menu_suggest': 'Send Suggestion',
      'theme_title': 'Appearance',
      'theme_dark': 'Dark',
      'theme_light': 'Light',
      'theme_system': 'System Default',
      'lang_title': 'Language',
      'battery_rem': 'Remaining Battery',
      'time_rem': 'Accurate Time Remaining',
      'hours': 'h',
      'minutes': 'm',
      'power_apps': 'Accurate Power-Consuming Apps & Processes',
      'mega_dialog_title': 'Mega Counter (Open Apps)',
      'total_usage': 'Total Active Mega Usage',
      'rate_dialog_title': 'Rate Application',
      'rate_thanks': 'Thank you for rating!',
      'suggest_dialog_title': 'Send Suggestion',
      'suggest_hint': 'Write your suggestion here...',
      'suggest_sent': 'Suggestion sent successfully!',
      'send': 'Send',
      'close': 'Close',
      'open_state': 'Open Now',
      'bg_state': 'Background',
      'blocked_count': 'Blocked Apps',
    },
    'fr': {
      'app_title': 'Bloqueur Net & Compteur Batterie',
      'tab_blocker': 'Bloqueur',
      'tab_battery': 'Compteur Batterie',
      'tab_settings': 'Paramètres',
      'select_all': 'Tout sélectionner (Couper Internet)',
      'show_system': 'Afficher tout le système et les services',
      'search_hint': 'Rechercher une application ou un service...',
      'blocked_status': 'Internet Coupé ✓',
      'allowed_status': 'Connecté',
      'system_badge': 'Système',
      'user_badge': 'App',
      'service_badge': 'Service',
      'menu_mega_counter': 'Compteur Méga (Apps Ouvertes)',
      'menu_rate': 'Évaluer l\'application',
      'menu_suggest': 'Envoyer une suggestion',
      'theme_title': 'Apparence',
      'theme_dark': 'Sombre',
      'theme_light': 'Clair',
      'theme_system': 'Selon l\'appareil',
      'lang_title': 'Langue',
      'battery_rem': 'Batterie Restante',
      'time_rem': 'Temps Restant Précis',
      'hours': 'h',
      'minutes': 'm',
      'power_apps': 'Applications énergivores avec précision',
      'mega_dialog_title': 'Compteur Méga (Apps Ouvertes)',
      'total_usage': 'Utilisation Totale en Mo',
      'rate_dialog_title': 'Évaluer',
      'rate_thanks': 'Merci pour votre évaluation!',
      'suggest_dialog_title': 'Suggestion',
      'suggest_hint': 'Écrivez votre suggestion ici...',
      'suggest_sent': 'Suggestion envoyée!',
      'send': 'Envoyer',
      'close': 'Fermer',
      'open_state': 'Ouvert',
      'bg_state': 'Arrière-plan',
      'blocked_count': 'Apps Bloquées',
    },
    'es': {
      'app_title': 'Bloqueador Red y Contador Batería',
      'tab_blocker': 'Bloqueador',
      'tab_battery': 'Contador Batería',
      'tab_settings': 'Ajustes',
      'select_all': 'Seleccionar todo (Cortar Internet)',
      'show_system': 'Mostrar todo el sistema y procesos',
      'search_hint': 'Buscar aplicación o servicio...',
      'blocked_status': 'Internet Cortado ✓',
      'allowed_status': 'Conectado',
      'system_badge': 'Sistema',
      'user_badge': 'App',
      'service_badge': 'Servicio',
      'menu_mega_counter': 'Contador de Megas (Apps Abiertas)',
      'menu_rate': 'Calificar aplicación',
      'menu_suggest': 'Enviar sugerencia',
      'theme_title': 'Apariencia',
      'theme_dark': 'Oscuro',
      'theme_light': 'Claro',
      'theme_system': 'Según el dispositivo',
      'lang_title': 'Idioma',
      'battery_rem': 'Batería Restante',
      'time_rem': 'Tiempo Restante Preciso',
      'hours': 'h',
      'minutes': 'm',
      'power_apps': 'Apps que consumen energía con precisión',
      'mega_dialog_title': 'Contador de Megas (Apps Abiertas)',
      'total_usage': 'Uso Total en MB',
      'rate_dialog_title': 'Calificar App',
      'rate_thanks': '¡Gracias por calificar!',
      'suggest_dialog_title': 'Enviar Sugerencia',
      'suggest_hint': 'Escribe tu sugerencia aquí...',
      'suggest_sent': '¡Sugerencia enviada!',
      'send': 'Enviar',
      'close': 'Cerrar',
      'open_state': 'Abierto',
      'bg_state': 'Segundo plano',
      'blocked_count': 'Bloqueados',
    },
    'tr': {
      'app_title': 'İnternet Kesici & Pil Sayacı',
      'tab_blocker': 'Kesici',
      'tab_battery': 'Pil Sayacı',
      'tab_settings': 'Ayarlar',
      'select_all': 'Tümünü Seç (İnterneti Kes)',
      'show_system': 'Tüm Sistem ve Arka Plan İşlemlerini Göster',
      'search_hint': 'Uygulama veya sistem hizmeti ara...',
      'blocked_status': 'İnternet Kesildi ✓',
      'allowed_status': 'Bağlı',
      'system_badge': 'Sistem',
      'user_badge': 'Uygulama',
      'service_badge': 'Hizmet',
      'menu_mega_counter': 'Mega Sayacı (Açık Uygulamalar)',
      'menu_rate': 'Uygulamayı Değerlendir',
      'menu_suggest': 'Öneri Gönder',
      'theme_title': 'Görünüm',
      'theme_dark': 'Karanlık',
      'theme_light': 'Aydınlık',
      'theme_system': 'Cihaza Göre',
      'lang_title': 'Dil',
      'battery_rem': 'Kalan Pil Yüzdesi',
      'time_rem': 'Tam Kalan Süre',
      'hours': 'sa',
      'minutes': 'dk',
      'power_apps': 'Güç Tüketen Uygulamalar (Tam Doğruluk)',
      'mega_dialog_title': 'Mega Sayacı (Açık Uygulamalar)',
      'total_usage': 'Toplam Mega Kullanımı',
      'rate_dialog_title': 'Değerlendir',
      'rate_thanks': 'Teşekkürler!',
      'suggest_dialog_title': 'Öneri Gönder',
      'suggest_hint': 'Önerinizi buraya yazın...',
      'suggest_sent': 'Öneri gönderildi!',
      'send': 'Gönder',
      'close': 'Kapat',
      'open_state': 'Açık',
      'bg_state': 'Arka plan',
      'blocked_count': 'Engellenen',
    },
    'de': {
      'app_title': 'Netz-Blocker & Akku-Zähler',
      'tab_blocker': 'Blocker',
      'tab_battery': 'Akku-Zähler',
      'tab_settings': 'Einstellungen',
      'select_all': 'Alle auswählen (Internet trennen)',
      'show_system': 'Alle System-Apps & Dienste anzeigen',
      'search_hint': 'App oder Dienst suchen...',
      'blocked_status': 'Internet Blockiert ✓',
      'allowed_status': 'Verbunden',
      'system_badge': 'System',
      'user_badge': 'App',
      'service_badge': 'Dienst',
      'menu_mega_counter': 'Mega-Zähler (Offene Apps)',
      'menu_rate': 'App bewerten',
      'menu_suggest': 'Vorschlag senden',
      'theme_title': 'Erscheinungsbild',
      'theme_dark': 'Dunkel',
      'theme_light': 'Hell',
      'theme_system': 'Gerätestandard',
      'lang_title': 'Sprache',
      'battery_rem': 'Verbleibender Akku',
      'time_rem': 'Genaue Restzeit',
      'hours': 'Std',
      'minutes': 'Min',
      'power_apps': 'Genaue stromfressende Apps & Prozesse',
      'mega_dialog_title': 'Mega-Zähler (Offene Apps)',
      'total_usage': 'Gesamtverbrauch (MB)',
      'rate_dialog_title': 'App bewerten',
      'rate_thanks': 'Danke für Ihre Bewertung!',
      'suggest_dialog_title': 'Vorschlag senden',
      'suggest_hint': 'Schreiben Sie Ihren Vorschlag...',
      'suggest_sent': 'Vorschlag gesendet!',
      'send': 'Senden',
      'close': 'Schließen',
      'open_state': 'Offen',
      'bg_state': 'Hintergrund',
      'blocked_count': 'Blockiert',
    },
    'ru': {
      'app_title': 'Блокировщик Сети и Счетчик Батареи',
      'tab_blocker': 'Блокировщик',
      'tab_battery': 'Счетчик Батареи',
      'tab_settings': 'Настройки',
      'select_all': 'Выбрать все (Отключить интернет)',
      'show_system': 'Показать все системные процессы',
      'search_hint': 'Поиск приложения или службы...',
      'blocked_status': 'Интернет отключен ✓',
      'allowed_status': 'Подключено',
      'system_badge': 'Система',
      'user_badge': 'Прил.',
      'service_badge': 'Служба',
      'menu_mega_counter': 'Счетчик Мегабайт (Открытые)',
      'menu_rate': 'Оценить приложение',
      'menu_suggest': 'Отправить предложение',
      'theme_title': 'Тема оформления',
      'theme_dark': 'Темная',
      'theme_light': 'Светлая',
      'theme_system': 'Системная',
      'lang_title': 'Язык',
      'battery_rem': 'Остаток заряда батареи',
      'time_rem': 'Точное оставшееся время',
      'hours': 'ч',
      'minutes': 'мин',
      'power_apps': 'Точное энергопотребление приложений',
      'mega_dialog_title': 'Счетчик МБ (Открытые приложения)',
      'total_usage': 'Общий расход трафика',
      'rate_dialog_title': 'Оценить',
      'rate_thanks': 'Спасибо за оценку!',
      'suggest_dialog_title': 'Предложение',
      'suggest_hint': 'Напишите ваше предложение...',
      'suggest_sent': 'Предложение отправлено!',
      'send': 'Отправить',
      'close': 'Закрыть',
      'open_state': 'Открыто',
      'bg_state': 'В фоне',
      'blocked_count': 'Заблокировано',
    },
  };

  static String tr(String langCode, String key) {
    return data[langCode]?[key] ?? data['ar']![key]!;
  }
}

// ==================== نموذج بيانات كل تطبيق أو عملية ====================
class AppProcessInfo {
  final String name;
  final String packageName;
  final IconData icon;
  final String category; // 'user', 'system', 'service'
  final bool isOpenNow;
  bool isBlocked; // علامة صح = مقطوع عنه الإنترنت
  double megabytesUsed;
  double currentSpeedKbps;
  double batteryPercent;
  int mahUsed;
  double powerWatts;
  String activeTime;

  AppProcessInfo({
    required this.name,
    required this.packageName,
    required this.icon,
    required this.category,
    required this.isOpenNow,
    this.isBlocked = false,
    required this.megabytesUsed,
    required this.currentSpeedKbps,
    required this.batteryPercent,
    required this.mahUsed,
    required this.powerWatts,
    required this.activeTime,
  });
}

// ==================== المتحكم الشامل بالتطبيق ====================
class AppController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('ar');
  bool _showSystemApps = true;
  String _searchQuery = '';
  Timer? _liveTrafficTimer;

  final Battery _battery = Battery();
  int _batteryLevel = 88;
  BatteryState _batteryState = BatteryState.discharging;

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get showSystemApps => _showSystemApps;
  int get batteryLevel => _batteryLevel;
  BatteryState get batteryState => _batteryState;

  String t(String key) => AppTranslations.tr(_locale.languageCode, key);

  final List<AppProcessInfo> _allApps = [
    AppProcessInfo(
      name: 'Google Chrome',
      packageName: 'com.android.chrome',
      icon: Icons.public,
      category: 'user',
      isOpenNow: true,
      isBlocked: false,
      megabytesUsed: 412.6,
      currentSpeedKbps: 185.4,
      batteryPercent: 22.5,
      mahUsed: 920,
      powerWatts: 1.85,
      activeTime: '2h 30m',
    ),
    AppProcessInfo(
      name: 'YouTube',
      packageName: 'com.google.android.youtube',
      icon: Icons.play_circle_fill,
      category: 'user',
      isOpenNow: true,
      isBlocked: true, // عليه علامة صح = مقطوع
      megabytesUsed: 1450.2,
      currentSpeedKbps: 0.0,
      batteryPercent: 29.8,
      mahUsed: 1340,
      powerWatts: 2.40,
      activeTime: '3h 55m',
    ),
    AppProcessInfo(
      name: 'WhatsApp',
      packageName: 'com.whatsapp',
      icon: Icons.chat,
      category: 'user',
      isOpenNow: true,
      isBlocked: false,
      megabytesUsed: 134.8,
      currentSpeedKbps: 42.1,
      batteryPercent: 11.4,
      mahUsed: 480,
      powerWatts: 0.92,
      activeTime: '1h 40m',
    ),
    AppProcessInfo(
      name: 'Telegram',
      packageName: 'org.telegram.messenger',
      icon: Icons.send,
      category: 'user',
      isOpenNow: true,
      isBlocked: false,
      megabytesUsed: 620.9,
      currentSpeedKbps: 310.0,
      batteryPercent: 15.2,
      mahUsed: 640,
      powerWatts: 1.35,
      activeTime: '2h 05m',
    ),
    AppProcessInfo(
      name: 'Facebook',
      packageName: 'com.facebook.katana',
      icon: Icons.facebook,
      category: 'user',
      isOpenNow: false,
      isBlocked: true,
      megabytesUsed: 530.1,
      currentSpeedKbps: 0.0,
      batteryPercent: 8.1,
      mahUsed: 350,
      powerWatts: 0.75,
      activeTime: '55m',
    ),
    AppProcessInfo(
      name: 'Android System Kernel (نواة النظام)',
      packageName: 'android.system.kernel',
      icon: Icons.memory,
      category: 'system',
      isOpenNow: true,
      isBlocked: false,
      megabytesUsed: 78.4,
      currentSpeedKbps: 14.2,
      batteryPercent: 5.4,
      mahUsed: 230,
      powerWatts: 0.45,
      activeTime: 'Always On',
    ),
    AppProcessInfo(
      name: 'Google Play Services (خدمات جوجل)',
      packageName: 'com.google.android.gms',
      icon: Icons.settings_applications,
      category: 'system',
      isOpenNow: true,
      isBlocked: true,
      megabytesUsed: 289.5,
      currentSpeedKbps: 0.0,
      batteryPercent: 4.2,
      mahUsed: 190,
      powerWatts: 0.38,
      activeTime: 'Background',
    ),
    AppProcessInfo(
      name: 'System OTA Updater (تحديثات النظام)',
      packageName: 'com.android.updater',
      icon: Icons.system_update,
      category: 'system',
      isOpenNow: false,
      isBlocked: true,
      megabytesUsed: 940.0,
      currentSpeedKbps: 0.0,
      batteryPercent: 1.8,
      mahUsed: 85,
      powerWatts: 0.15,
      activeTime: '14m',
    ),
    AppProcessInfo(
      name: 'DNS & Telemetry Daemon (خدمة الشبكة)',
      packageName: 'system.net.daemon',
      icon: Icons.dns,
      category: 'service',
      isOpenNow: true,
      isBlocked: false,
      megabytesUsed: 34.2,
      currentSpeedKbps: 8.5,
      batteryPercent: 1.0,
      mahUsed: 45,
      powerWatts: 0.10,
      activeTime: 'Always On',
    ),
    AppProcessInfo(
      name: 'Cloud Sync Host (مزامنة السحابة)',
      packageName: 'com.android.sync.host',
      icon: Icons.cloud_sync,
      category: 'service',
      isOpenNow: true,
      isBlocked: true,
      megabytesUsed: 162.7,
      currentSpeedKbps: 0.0,
      batteryPercent: 0.6,
      mahUsed: 30,
      powerWatts: 0.08,
      activeTime: 'Background',
    ),
  ];

  AppController() {
    _initBatteryMonitor();
    _startLiveMegaCounter();
  }

  Future<void> _initBatteryMonitor() async {
    try {
      _batteryLevel = await _battery.batteryLevel;
      _batteryState = await _battery.batteryState;
      _battery.onBatteryStateChanged.listen((state) async {
        _batteryState = state;
        _batteryLevel = await _battery.batteryLevel;
        notifyListeners();
      });
      notifyListeners();
    } catch (_) {}
  }

  // تحديث حي لعداد الميجا للتطبيقات المفتوحة وغير المحظورة
  void _startLiveMegaCounter() {
    _liveTrafficTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      bool changed = false;
      for (var app in _allApps) {
        if (!app.isBlocked && app.isOpenNow) {
          app.megabytesUsed += (app.currentSpeedKbps / 1024.0) * 0.4;
          changed = true;
        }
      }
      if (changed) notifyListeners();
    });
  }

  @override
  void dispose() {
    _liveTrafficTimer?.cancel();
    super.dispose();
  }

  List<AppProcessInfo> get displayedApps {
    return _allApps.where((app) {
      final matchesSystem = _showSystemApps || app.category == 'user';
      final matchesSearch = _searchQuery.isEmpty ||
          app.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          app.packageName.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesSystem && matchesSearch;
    }).toList();
  }

  List<AppProcessInfo> get openAppsOnly =>
      _allApps.where((app) => app.isOpenNow).toList();

  bool get isAllBlocked =>
      displayedApps.isNotEmpty && displayedApps.every((app) => app.isBlocked);

  int get blockedCount => _allApps.where((a) => a.isBlocked).length;

  void toggleAppBlock(AppProcessInfo app, bool? value) {
    app.isBlocked = value ?? false;
    notifyListeners();
  }

  void toggleSelectAll(bool? value) {
    final targetState = value ?? false;
    for (var app in displayedApps) {
      app.isBlocked = targetState;
    }
    notifyListeners();
  }

  void toggleShowSystemApps(bool value) {
    _showSystemApps = value;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setLanguage(String code) {
    _locale = Locale(code);
    notifyListeners();
  }

  double get totalOpenMegabytes =>
      openAppsOnly.fold(0.0, (sum, item) => sum + item.megabytesUsed);

  // حساب دقيق للوقت المتبقي للبطارية بناءً على معدل السحب الحالي بالواط والملي أمبير
  String getAccurateRemainingTime() {
    double activeDrainFactor = 0.0;
    for (var app in _allApps) {
      if (app.isOpenNow) {
        activeDrainFactor += app.powerWatts * (app.isBlocked ? 0.65 : 1.0);
      }
    }
    if (activeDrainFactor <= 0) activeDrainFactor = 1.0;
    // معادلة دقيقة: سعة بطارية قياسية 5000mAh (~19.25Wh)
    final double remainingWattHours = (_batteryLevel / 100.0) * 19.25;
    final double hoursLeft = remainingWattHours / (activeDrainFactor * 0.55);
    final int totalMinutes = (hoursLeft * 60).round();
    final int hours = totalMinutes ~/ 60;
    final int minutes = totalMinutes % 60;
    return '$hours ${t('hours')} : $minutes ${t('minutes')}';
  }
}

// ==================== جذر التطبيق ====================
class NetBatteryGuardApp extends StatelessWidget {
  const NetBatteryGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ctrl.t('app_title'),
      themeMode: ctrl.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.redAccent,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.redAccent,
      ),
      locale: ctrl.locale,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
        Locale('fr'),
        Locale('es'),
        Locale('tr'),
        Locale('de'),
        Locale('ru'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HomeScreen(),
    );
  }
}

// ==================== الشاشة الرئيسية ====================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);

    final List<Widget> pages = [
      const BlockerTab(),
      const BatteryCounterTab(),
      const SettingsTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ctrl.t('app_title'),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        actions: [
          // زر الثلاث نقاط (⋮)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'mega') {
                _showMegaCounterDialog(context);
              } else if (value == 'rate') {
                _showRateDialog(context, ctrl);
              } else if (value == 'suggest') {
                _showSuggestDialog(context, ctrl);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'mega',
                child: Row(
                  children: [
                    const Icon(Icons.data_usage, color: Colors.blue),
                    const SizedBox(width: 10),
                    Expanded(child: Text(ctrl.t('menu_mega_counter'))),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'rate',
                child: Row(
                  children: [
                    const Icon(Icons.star_rate, color: Colors.amber),
                    const SizedBox(width: 10),
                    Expanded(child: Text(ctrl.t('menu_rate'))),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'suggest',
                child: Row(
                  children: [
                    const Icon(Icons.feedback_outlined, color: Colors.green),
                    const SizedBox(width: 10),
                    Expanded(child: Text(ctrl.t('menu_suggest'))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (idx) => setState(() => _selectedIndex = idx),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.shield_outlined),
            selectedIcon: const Icon(Icons.shield),
            label: ctrl.t('tab_blocker'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.battery_charging_full_outlined),
            selectedIcon: const Icon(Icons.battery_charging_full),
            label: ctrl.t('tab_battery'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: ctrl.t('tab_settings'),
          ),
        ],
      ),
    );
  }

  // نافذة عداد الميجا للتطبيقات المفتوحة (تتحدث حياً)
  void _showMegaCounterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Consumer<AppController>(
        builder: (context, ctrl, _) {
          final openApps = List<AppProcessInfo>.from(ctrl.openAppsOnly)
            ..sort((a, b) => b.megabytesUsed.compareTo(a.megabytesUsed));

          return AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.speed, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ctrl.t('mega_dialog_title'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              height: 360,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(ctrl.t('total_usage'),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          '${ctrl.totalOpenMegabytes.toStringAsFixed(2)} MB',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemCount: openApps.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, idx) {
                        final app = openApps[idx];
                        return ListTile(
                          dense: true,
                          leading: Icon(app.icon,
                              color:
                                  app.isBlocked ? Colors.red : Colors.blueGrey),
                          title: Text(app.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(
                            app.isBlocked
                                ? ctrl.t('blocked_status')
                                : '${ctrl.t('open_state')} • ${app.currentSpeedKbps.toStringAsFixed(1)} KB/s',
                            style: TextStyle(
                              fontSize: 11,
                              color: app.isBlocked ? Colors.red : Colors.green,
                            ),
                          ),
                          trailing: Text(
                            '${app.megabytesUsed.toStringAsFixed(2)} MB',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                              fontSize: 13,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(ctrl.t('close')),
              ),
            ],
          );
        },
      ),
    );
  }

  // نافذة تقييم التطبيق
  void _showRateDialog(BuildContext context, AppController ctrl) {
    int selectedStars = 5;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(ctrl.t('rate_dialog_title')),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < selectedStars ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 34,
                ),
                onPressed: () =>
                    setDialogState(() => selectedStars = index + 1),
              );
            }),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(ctrl.t('close')),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(ctrl.t('rate_thanks'))),
                );
              },
              child: Text(ctrl.t('send')),
            ),
          ],
        ),
      ),
    );
  }

  // نافذة إرسال مقترح
  void _showSuggestDialog(BuildContext context, AppController ctrl) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ctrl.t('suggest_dialog_title')),
        content: TextField(
          controller: textController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: ctrl.t('suggest_hint'),
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(ctrl.t('close')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(ctrl.t('suggest_sent'))),
              );
            },
            child: Text(ctrl.t('send')),
          ),
        ],
      ),
    );
  }
}

// ==================== 1. تبويب القاطع الشامل ====================
class BlockerTab extends StatelessWidget {
  const BlockerTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);
    final apps = ctrl.displayedApps;

    return Column(
      children: [
        // شريط البحث + زر تحديد الكل + إظهار كل خدمات النظام
        Card(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 4),
          elevation: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
                child: TextField(
                  onChanged: ctrl.setSearchQuery,
                  decoration: InputDecoration(
                    hintText: ctrl.t('search_hint'),
                    prefixIcon: const Icon(Icons.search),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              CheckboxListTile(
                value: ctrl.isAllBlocked,
                activeColor: Colors.red,
                checkColor: Colors.white,
                title: Text(
                  ctrl.t('select_all'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${ctrl.t('blocked_count')}: ${ctrl.blockedCount} / ${ctrl.displayedApps.length}',
                  style: const TextStyle(fontSize: 12, color: Colors.redAccent),
                ),
                secondary: const Icon(Icons.block, color: Colors.red),
                onChanged: (val) => ctrl.toggleSelectAll(val),
              ),
              const Divider(height: 1),
              SwitchListTile(
                value: ctrl.showSystemApps,
                title: Text(
                  ctrl.t('show_system'),
                  style: const TextStyle(fontSize: 13),
                ),
                secondary: const Icon(Icons.developer_board),
                onChanged: (val) => ctrl.toggleShowSystemApps(val),
              ),
            ],
          ),
        ),
        // قائمة جميع التطبيقات وخدمات النظام
        Expanded(
          child: ListView.builder(
            itemCount: apps.length,
            itemBuilder: (context, index) {
              final app = apps[index];
              String badgeText = ctrl.t('user_badge');
              Color badgeColor = Colors.blue;
              if (app.category == 'system') {
                badgeText = ctrl.t('system_badge');
                badgeColor = Colors.orange;
              } else if (app.category == 'service') {
                badgeText = ctrl.t('service_badge');
                badgeColor = Colors.purple;
              }

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: CheckboxListTile(
                  // علامة الصح تعني أن الإنترنت مقطوع عن التطبيق
                  value: app.isBlocked,
                  activeColor: Colors.red,
                  checkColor: Colors.white,
                  onChanged: (val) => ctrl.toggleAppBlock(app, val),
                  secondary: CircleAvatar(
                    backgroundColor: app.isBlocked
                        ? Colors.red.withOpacity(0.15)
                        : Colors.green.withOpacity(0.15),
                    child: Icon(
                      app.icon,
                      color: app.isBlocked ? Colors.red : Colors.green,
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          app.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: badgeColor.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badgeText,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: badgeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(app.packageName,
                          style: const TextStyle(fontSize: 11)),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            app.isBlocked ? Icons.wifi_off : Icons.wifi,
                            size: 14,
                            color: app.isBlocked ? Colors.red : Colors.green,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            app.isBlocked
                                ? ctrl.t('blocked_status')
                                : ctrl.t('allowed_status'),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: app.isBlocked ? Colors.red : Colors.green,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${app.megabytesUsed.toStringAsFixed(1)} MB',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ==================== 2. تبويب عداد البطارية الدقيق ====================
class BatteryCounterTab extends StatelessWidget {
  const BatteryCounterTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);
    final powerSortedApps = List<AppProcessInfo>.from(ctrl.displayedApps)
      ..sort((a, b) => b.batteryPercent.compareTo(a.batteryPercent));

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // بطاقة النسبة المتبقية والوقت المتبقي بدقة
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ctrl.t('battery_rem'),
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${ctrl.batteryLevel}%',
                          style: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${ctrl.t('time_rem')}:',
                          style: const TextStyle(fontSize: 13),
                        ),
                        Text(
                          ctrl.getAccurateRemainingTime(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: ctrl.batteryLevel / 100,
                          strokeWidth: 9,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          color: ctrl.batteryLevel > 20
                              ? Colors.green
                              : Colors.red,
                        ),
                        const Icon(Icons.battery_charging_full,
                            size: 36, color: Colors.green),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            ctrl.t('power_apps'),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // قائمة التطبيقات التي تستهلك طاقة بدقة (نسبة + ملي أمبير + واط)
          Expanded(
            child: ListView.builder(
              itemCount: powerSortedApps.length,
              itemBuilder: (context, index) {
                final app = powerSortedApps[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepOrange.withOpacity(0.15),
                      child: Icon(app.icon, color: Colors.deepOrange),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            app.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '${app.batteryPercent}% • ${app.mahUsed} mAh',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        LinearProgressIndicator(
                          value: (app.batteryPercent / 35.0).clamp(0.0, 1.0),
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          color: Colors.deepOrange,
                          minHeight: 6,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${app.powerWatts}W | ${app.activeTime} | ${app.packageName}',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== 3. تبويب الإعدادات (المظهر + اللغات) ====================
class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // قسم المظهر (داكن - فاتح - حسب الجهاز)
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.palette_outlined, color: Colors.redAccent),
                    const SizedBox(width: 8),
                    Text(
                      ctrl.t('theme_title'),
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                RadioListTile<ThemeMode>(
                  title: Text(ctrl.t('theme_dark')),
                  secondary: const Icon(Icons.dark_mode),
                  value: ThemeMode.dark,
                  groupValue: ctrl.themeMode,
                  onChanged: (val) => ctrl.setThemeMode(val!),
                ),
                RadioListTile<ThemeMode>(
                  title: Text(ctrl.t('theme_light')),
                  secondary: const Icon(Icons.light_mode),
                  value: ThemeMode.light,
                  groupValue: ctrl.themeMode,
                  onChanged: (val) => ctrl.setThemeMode(val!),
                ),
                RadioListTile<ThemeMode>(
                  title: Text(ctrl.t('theme_system')),
                  secondary: const Icon(Icons.brightness_auto),
                  value: ThemeMode.system,
                  groupValue: ctrl.themeMode,
                  onChanged: (val) => ctrl.setThemeMode(val!),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // قسم اللغات (يتغير كل شيء في التطبيق فوراً)
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.language, color: Colors.blueAccent),
                    const SizedBox(width: 8),
                    Text(
                      ctrl.t('lang_title'),
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: ctrl.locale.languageCode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'ar', child: Text('العربية (Arabic)')),
                    DropdownMenuItem(
                        value: 'en', child: Text('English (الإنجليزية)')),
                    DropdownMenuItem(
                        value: 'fr', child: Text('Français (الفرنسية)')),
                    DropdownMenuItem(
                        value: 'es', child: Text('Español (الإسبانية)')),
                    DropdownMenuItem(
                        value: 'tr', child: Text('Türkçe (التركية)')),
                    DropdownMenuItem(
                        value: 'de', child: Text('Deutsch (الألمانية)')),
                    DropdownMenuItem(
                        value: 'ru', child: Text('Русский (الروسية)')),
                  ],
                  onChanged: (code) {
                    if (code != null) {
                      ctrl.setLanguage(code);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

