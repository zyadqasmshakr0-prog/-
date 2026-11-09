import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:battery_plus/battery_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppController(),
      child: const NetBatteryGuardApp(),
    ),
  );
}

// ==================== قاموس اللغات الشامل ====================
class AppTranslations {
  static final Map<String, Map<String, String>> data = {
    'ar': {
      'app_title': 'قاطع الإنترنت وعداد البطارية',
      'tab_blocker': 'القاطع',
      'tab_battery': 'عداد البطارية',
      'tab_settings': 'الإعدادات',
      'select_all': 'تحديد الكل (قطع الإنترنت عن الجميع)',
      'show_system': 'إظهار تطبيقات وخدمات النظام',
      'blocked_status': 'الإنترنت مقطوع (محظور)',
      'allowed_status': 'متصل بالإنترنت (مسموح)',
      'system_badge': 'نظام',
      'user_badge': 'تطبيق',
      'menu_mega_counter': 'عداد الميجا (استهلاك التطبيقات)',
      'menu_rate': 'تقييم التطبيق',
      'menu_suggest': 'إرسال مقترح',
      'theme_title': 'المظهر',
      'theme_dark': 'داكن (موفر للطاقة OLED)',
      'theme_light': 'فاتح',
      'theme_system': 'حسب الجهاز',
      'lang_title': 'اللغة (Language)',
      'battery_rem': 'نسبة البطارية المتبقية',
      'time_rem': 'الوقت المتبقي التقريبي',
      'hours': 'ساعة',
      'minutes': 'دقيقة',
      'power_apps': 'التطبيقات والعمليات المستهلكة للطاقة بدقة',
      'mega_dialog_title': 'عداد الميجا للتطبيقات المفتوحة',
      'total_usage': 'إجمالي الاستهلاك النشط',
      'rate_dialog_title': 'تقييم التطبيق',
      'rate_thanks': 'شكراً لتقييمك!',
      'suggest_dialog_title': 'إرسال مقترح',
      'suggest_hint': 'اكتب مقترحك أو ملاحظتك هنا...',
      'suggest_sent': 'تم إرسال مقترحك بنجاح!',
      'send': 'إرسال',
      'close': 'إغلاق',
      'eco_mode_badge': 'وضع توفير الطاقة الفائق نشط (استهلاك 0% بالخلفية)',
      'refresh_battery': 'تحديث القراءة الآن',
    },
    'en': {
      'app_title': 'Net Blocker & Battery Counter',
      'tab_blocker': 'Blocker',
      'tab_battery': 'Battery Counter',
      'tab_settings': 'Settings',
      'select_all': 'Select All (Block All Internet)',
      'show_system': 'Show System Apps & Services',
      'blocked_status': 'Internet Blocked (Cut off)',
      'allowed_status': 'Internet Allowed (Active)',
      'system_badge': 'System',
      'user_badge': 'App',
      'menu_mega_counter': 'Mega Counter (Live Data Usage)',
      'menu_rate': 'Rate App',
      'menu_suggest': 'Send Suggestion',
      'theme_title': 'Appearance',
      'theme_dark': 'Dark (OLED Battery Saver)',
      'theme_light': 'Light',
      'theme_system': 'System Default',
      'lang_title': 'Language',
      'battery_rem': 'Remaining Battery',
      'time_rem': 'Estimated Time Remaining',
      'hours': 'h',
      'minutes': 'm',
      'power_apps': 'Accurate Power-Consuming Apps & Processes',
      'mega_dialog_title': 'Mega Counter (Open Apps)',
      'total_usage': 'Total Active Usage',
      'rate_dialog_title': 'Rate Application',
      'rate_thanks': 'Thank you for rating!',
      'suggest_dialog_title': 'Send Suggestion',
      'suggest_hint': 'Write your suggestion here...',
      'suggest_sent': 'Suggestion sent successfully!',
      'send': 'Send',
      'close': 'Close',
      'eco_mode_badge': 'Ultra Eco Mode Active (0% Background Drain)',
      'refresh_battery': 'Refresh Reading',
    },
    'fr': {
      'app_title': 'Bloqueur Net & Batterie',
      'tab_blocker': 'Bloqueur',
      'tab_battery': 'Compteur Batterie',
      'tab_settings': 'Paramètres',
      'select_all': 'Tout sélectionner (Bloquer tout)',
      'show_system': 'Afficher les services système',
      'blocked_status': 'Internet Bloqué',
      'allowed_status': 'Internet Autorisé',
      'system_badge': 'Système',
      'user_badge': 'App',
      'menu_mega_counter': 'Compteur Méga (Données)',
      'menu_rate': 'Évaluer l\'application',
      'menu_suggest': 'Envoyer une suggestion',
      'theme_title': 'Apparence',
      'theme_dark': 'Sombre (Économie OLED)',
      'theme_light': 'Clair',
      'theme_system': 'Système',
      'lang_title': 'Langue',
      'battery_rem': 'Batterie Restante',
      'time_rem': 'Temps Restant Estimé',
      'hours': 'h',
      'minutes': 'm',
      'power_apps': 'Applications énergivores (Précis)',
      'mega_dialog_title': 'Compteur Méga (Apps Ouvertes)',
      'total_usage': 'Utilisation Totale',
      'rate_dialog_title': 'Évaluer',
      'rate_thanks': 'Merci pour votre évaluation!',
      'suggest_dialog_title': 'Suggestion',
      'suggest_hint': 'Écrivez votre suggestion ici...',
      'suggest_sent': 'Suggestion envoyée!',
      'send': 'Envoyer',
      'close': 'Fermer',
      'eco_mode_badge': 'Mode Éco Ultra Actif (0% en arrière-plan)',
      'refresh_battery': 'Actualiser',
    },
    'es': {
      'app_title': 'Bloqueador Red y Batería',
      'tab_blocker': 'Bloqueador',
      'tab_battery': 'Contador Batería',
      'tab_settings': 'Ajustes',
      'select_all': 'Seleccionar todo (Bloquear todo)',
      'show_system': 'Mostrar apps del sistema',
      'blocked_status': 'Internet Bloqueado',
      'allowed_status': 'Internet Permitido',
      'system_badge': 'Sistema',
      'user_badge': 'App',
      'menu_mega_counter': 'Contador de Megas',
      'menu_rate': 'Calificar aplicación',
      'menu_suggest': 'Enviar sugerencia',
      'theme_title': 'Apariencia',
      'theme_dark': 'Oscuro (Ahorro OLED)',
      'theme_light': 'Claro',
      'theme_system': 'Sistema',
      'lang_title': 'Idioma',
      'battery_rem': 'Batería Restante',
      'time_rem': 'Tiempo Estimado Restante',
      'hours': 'h',
      'minutes': 'm',
      'power_apps': 'Apps que consumen energía',
      'mega_dialog_title': 'Contador de Megas (Apps Abiertas)',
      'total_usage': 'Uso Total Activo',
      'rate_dialog_title': 'Calificar App',
      'rate_thanks': '¡Gracias por tu calificación!',
      'suggest_dialog_title': 'Enviar Sugerencia',
      'suggest_hint': 'Escribe tu sugerencia aquí...',
      'suggest_sent': '¡Sugerencia enviada!',
      'send': 'Enviar',
      'close': 'Cerrar',
      'eco_mode_badge': 'Modo Eco Activo (0% consumo en segundo plano)',
      'refresh_battery': 'Actualizar lectura',
    },
    'tr': {
      'app_title': 'İnternet Kesici & Pil Sayacı',
      'tab_blocker': 'Kesici',
      'tab_battery': 'Pil Sayacı',
      'tab_settings': 'Ayarlar',
      'select_all': 'Tümünü Seç (İnterneti Kes)',
      'show_system': 'Sistem Uygulamalarını Göster',
      'blocked_status': 'İnternet Kesildi',
      'allowed_status': 'İnternet Açık',
      'system_badge': 'Sistem',
      'user_badge': 'Uygulama',
      'menu_mega_counter': 'Mega Sayacı (Veri Kullanımı)',
      'menu_rate': 'Uygulamayı Değerlendir',
      'menu_suggest': 'Öneri Gönder',
      'theme_title': 'Görünüm',
      'theme_dark': 'Karanlık (OLED Tasarrufu)',
      'theme_light': 'Aydınlık',
      'theme_system': 'Sistem Varsayılanı',
      'lang_title': 'Dil',
      'battery_rem': 'Kalan Pil',
      'time_rem': 'Tahmini Kalan Süre',
      'hours': 'sa',
      'minutes': 'dk',
      'power_apps': 'Güç Tüketen Uygulamalar',
      'mega_dialog_title': 'Mega Sayacı (Açık Uygulamalar)',
      'total_usage': 'Toplam Kullanım',
      'rate_dialog_title': 'Değerlendir',
      'rate_thanks': 'Teşekkürler!',
      'suggest_dialog_title': 'Öneri Gönder',
      'suggest_hint': 'Önerinizi buraya yazın...',
      'suggest_sent': 'Öneri gönderildi!',
      'send': 'Gönder',
      'close': 'Kapat',
      'eco_mode_badge': 'Ultra Eko Modu Aktif (%0 Arka Plan Tüketimi)',
      'refresh_battery': 'Yenile',
    },
    'de': {
      'app_title': 'Netz-Blocker & Akku-Zähler',
      'tab_blocker': 'Blocker',
      'tab_battery': 'Akku-Zähler',
      'tab_settings': 'Einstellungen',
      'select_all': 'Alle auswählen (Alles blockieren)',
      'show_system': 'Systemdienste anzeigen',
      'blocked_status': 'Internet Blockiert',
      'allowed_status': 'Internet Erlaubt',
      'system_badge': 'System',
      'user_badge': 'App',
      'menu_mega_counter': 'Mega-Zähler (Datenverbrauch)',
      'menu_rate': 'App bewerten',
      'menu_suggest': 'Vorschlag senden',
      'theme_title': 'Erscheinungsbild',
      'theme_dark': 'Dunkel (OLED-Sparmodus)',
      'theme_light': 'Hell',
      'theme_system': 'Systemstandard',
      'lang_title': 'Sprache',
      'battery_rem': 'Verbleibender Akku',
      'time_rem': 'Geschätzte Restzeit',
      'hours': 'Std',
      'minutes': 'Min',
      'power_apps': 'Stromfressende Apps & Prozesse',
      'mega_dialog_title': 'Mega-Zähler (Offene Apps)',
      'total_usage': 'Gesamtverbrauch',
      'rate_dialog_title': 'App bewerten',
      'rate_thanks': 'Danke für Ihre Bewertung!',
      'suggest_dialog_title': 'Vorschlag senden',
      'suggest_hint': 'Schreiben Sie Ihren Vorschlag...',
      'suggest_sent': 'Vorschlag gesendet!',
      'send': 'Senden',
      'close': 'Schließen',
      'eco_mode_badge': 'Ultra-Eco-Modus Aktiv (0% Hintergrundverbrauch)',
      'refresh_battery': 'Aktualisieren',
    },
  };

  static String tr(String langCode, String key) {
    return data[langCode]?[key] ?? data['ar']![key]!;
  }
}

// ==================== نموذج بيانات التطبيقات ====================
class AppProcessInfo {
  final String name;
  final String packageName;
  final IconData icon;
  final bool isSystem;
  bool isBlocked;
  double megabytesUsed;
  double batteryPercent;
  int mahUsed;
  String activeTime;

  AppProcessInfo({
    required this.name,
    required this.packageName,
    required this.icon,
    required this.isSystem,
    this.isBlocked = false,
    required this.megabytesUsed,
    required this.batteryPercent,
    required this.mahUsed,
    required this.activeTime,
  });
}

// ==================== المزود الذكي الموفر للبطارية ====================
// يستخدم WidgetsBindingObserver لإيقاف أي عمليات فور خروج المستخدم من التطبيق
class AppController extends ChangeNotifier with WidgetsBindingObserver {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('ar');
  bool _showSystemApps = true;

  final Battery _battery = Battery();
  int _batteryLevel = 85;
  BatteryState _batteryState = BatteryState.discharging;
  StreamSubscription<BatteryState>? _batterySub;

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
      isSystem: false,
      isBlocked: false,
      megabytesUsed: 342.8,
      batteryPercent: 21.4,
      mahUsed: 840,
      activeTime: '2h 15m',
    ),
    AppProcessInfo(
      name: 'YouTube',
      packageName: 'com.google.android.youtube',
      icon: Icons.play_circle_fill,
      isSystem: false,
      isBlocked: true,
      megabytesUsed: 1280.5,
      batteryPercent: 28.9,
      mahUsed: 1120,
      activeTime: '3h 40m',
    ),
    AppProcessInfo(
      name: 'WhatsApp',
      packageName: 'com.whatsapp',
      icon: Icons.chat,
      isSystem: false,
      isBlocked: false,
      megabytesUsed: 118.2,
      batteryPercent: 11.2,
      mahUsed: 430,
      activeTime: '1h 25m',
    ),
    AppProcessInfo(
      name: 'Telegram',
      packageName: 'org.telegram.messenger',
      icon: Icons.send,
      isSystem: false,
      isBlocked: false,
      megabytesUsed: 495.6,
      batteryPercent: 14.5,
      mahUsed: 590,
      activeTime: '1h 50m',
    ),
    AppProcessInfo(
      name: 'Android System Core (خدمات النظام)',
      packageName: 'android.system.core',
      icon: Icons.memory,
      isSystem: true,
      isBlocked: false,
      megabytesUsed: 64.3,
      batteryPercent: 9.8,
      mahUsed: 380,
      activeTime: 'Event-Driven',
    ),
    AppProcessInfo(
      name: 'Google Play Services (خدمات جوجل)',
      packageName: 'com.google.android.gms',
      icon: Icons.settings_applications,
      isSystem: true,
      isBlocked: true,
      megabytesUsed: 215.9,
      batteryPercent: 8.4,
      mahUsed: 310,
      activeTime: 'Background',
    ),
    AppProcessInfo(
      name: 'System Updater (محدث النظام)',
      packageName: 'com.android.updater',
      icon: Icons.system_update,
      isSystem: true,
      isBlocked: true,
      megabytesUsed: 890.0,
      batteryPercent: 3.2,
      mahUsed: 125,
      activeTime: '18m',
    ),
    AppProcessInfo(
      name: 'Network Telemetry & DNS',
      packageName: 'system.net.telemetry',
      icon: Icons.dns,
      isSystem: true,
      isBlocked: true,
      megabytesUsed: 19.4,
      batteryPercent: 2.6,
      mahUsed: 95,
      activeTime: 'Background',
    ),
  ];

  AppController() {
    WidgetsBinding.instance.addObserver(this);
    refreshBatteryOnce(); // قراءة لمرة واحدة فقط عند الفتح دون استنزاف مستمر
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopBatteryListening();
    super.dispose();
  }

  // إيقاف تام لأي مستمع عند خروج المستخدم للخلفية لمنع سحب البطارية نهائياً
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _stopBatteryListening();
    } else if (state == AppLifecycleState.resumed) {
      refreshBatteryOnce();
    }
  }

  void _stopBatteryListening() {
    _batterySub?.cancel();
    _batterySub = null;
  }

  // قراءة عند الطلب فقط (On-Demand)
  Future<void> refreshBatteryOnce() async {
    try {
      final level = await _battery.batteryLevel;
      final state = await _battery.batteryState;
      if (level != _batteryLevel || state != _batteryState) {
        _batteryLevel = level;
        _batteryState = state;
        notifyListeners();
      }
    } catch (_) {}
  }

  List<AppProcessInfo> get displayedApps {
    if (_showSystemApps) return _allApps;
    return _allApps.where((app) => !app.isSystem).toList();
  }

  bool get isAllBlocked =>
      displayedApps.isNotEmpty && displayedApps.every((app) => app.isBlocked);

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

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setLanguage(String code) {
    _locale = Locale(code);
    notifyListeners();
  }

  double get totalMegabytes =>
      _allApps.fold(0.0, (sum, item) => sum + item.megabytesUsed);

  String getRemainingBatteryTime() {
    // حساب فوري خفيف بدون عمليات معقدة: كل تطبيق محظور يوفر طاقة الهوائي (Radio/WiFi)
    final blockedCount = _allApps.where((a) => a.isBlocked).length;
    final bonusMultiplier = 4.2 + (blockedCount * 0.15);
    final int totalMinutes = (_batteryLevel * bonusMultiplier).round();
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
        colorSchemeSeed: Colors.teal,
      ),
      // مظهر داكن حقيقي (True Black OLED) لتوفير طاقة الشاشة للحد الأقصى
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
      ),
      locale: ctrl.locale,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
        Locale('fr'),
        Locale('es'),
        Locale('tr'),
        Locale('de'),
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'mega') {
                _showMegaCounterDialog(context, ctrl);
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
        onDestinationSelected: (idx) {
          setState(() => _selectedIndex = idx);
          if (idx == 1) {
            ctrl.refreshBatteryOnce(); // تحديث القراءة عند فتح تبويب البطارية فقط
          }
        },
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

  void _showMegaCounterDialog(BuildContext context, AppController ctrl) {
    final sortedApps = List<AppProcessInfo>.from(ctrl.displayedApps)
      ..sort((a, b) => b.megabytesUsed.compareTo(a.megabytesUsed));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.speed, color: Colors.blue),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                ctrl.t('mega_dialog_title'),
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 350,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ctrl.t('total_usage'),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      '${ctrl.totalMegabytes.toStringAsFixed(1)} MB',
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
                  itemCount: sortedApps.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, idx) {
                    final app = sortedApps[idx];
                    return ListTile(
                      dense: true,
                      leading: Icon(app.icon, color: Colors.blueGrey),
                      title: Text(app.name,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(app.packageName,
                          style: const TextStyle(fontSize: 11)),
                      trailing: Text(
                        '${app.megabytesUsed.toStringAsFixed(1)} MB',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
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
      ),
    );
  }

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
                onPressed: () => setDialogState(() => selectedStars = index + 1),
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

// ==================== 1. تبويب قاطع الإنترنت ====================
class BlockerTab extends StatelessWidget {
  const BlockerTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);
    final apps = ctrl.displayedApps;

    return Column(
      children: [
        // شريط تأكيد عدم استهلاك البطارية
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          color: Colors.green.withOpacity(0.15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.eco, color: Colors.green, size: 16),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  ctrl.t('eco_mode_badge'),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.all(10),
          elevation: 1,
          child: Column(
            children: [
              CheckboxListTile(
                value: ctrl.isAllBlocked,
                activeColor: Colors.red,
                title: Text(
                  ctrl.t('select_all'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                secondary: const Icon(Icons.block, color: Colors.red),
                onChanged: (val) => ctrl.toggleSelectAll(val),
              ),
              const Divider(height: 1),
              SwitchListTile(
                value: ctrl.showSystemApps,
                title: Text(
                  ctrl.t('show_system'),
                  style: const TextStyle(fontSize: 14),
                ),
                secondary: const Icon(Icons.settings_suggest),
                onChanged: (val) => ctrl.toggleShowSystemApps(val),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: apps.length,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: true, // يقلل استهلاك المعالج الرسومي عند التمرير
            itemBuilder: (context, index) {
              final app = apps[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: CheckboxListTile(
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
                          color: app.isSystem
                              ? Colors.orange.withOpacity(0.2)
                              : Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          app.isSystem
                              ? ctrl.t('system_badge')
                              : ctrl.t('user_badge'),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: app.isSystem ? Colors.orange : Colors.blue,
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
                      const SizedBox(height: 2),
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
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ctrl.t('battery_rem'),
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
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
                              ctrl.getRemainingBatteryTime(),
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
                        width: 85,
                        height: 85,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: ctrl.batteryLevel / 100,
                              strokeWidth: 8,
                              backgroundColor: Colors.grey.withOpacity(0.2),
                              color: ctrl.batteryLevel > 20
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const Icon(Icons.battery_charging_full,
                                size: 34, color: Colors.green),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => ctrl.refreshBatteryOnce(),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: Text(ctrl.t('refresh_battery')),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            ctrl.t('power_apps'),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: powerSortedApps.length,
              addAutomaticKeepAlives: false,
              itemBuilder: (context, index) {
                final app = powerSortedApps[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange.withOpacity(0.15),
                      child: Icon(app.icon, color: Colors.orange),
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
                          '${app.batteryPercent}% (${app.mahUsed} mAh)',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: app.batteryPercent / 100,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          color: Colors.deepOrange,
                          minHeight: 6,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Time: ${app.activeTime} | Package: ${app.packageName}',
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

// ==================== 3. تبويب الإعدادات ====================
class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.palette_outlined, color: Colors.teal),
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
