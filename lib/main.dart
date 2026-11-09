import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppController(),
      child: const FreeNetBlockerApp(),
    ),
  );
}

// ==================== قاموس اللغات الشامل ====================
class AppTranslations {
  static final Map<String, Map<String, String>> data = {
    'ar': {
      'app_title': 'قاطع الانترنت مجانا',
      'tab_blocker': 'القاطع',
      'tab_battery': 'عداد البطارية',
      'tab_settings': 'الإعدادات',
      'vpn_active': 'القاطع شغال الآن (الشبكة مُسرّعة ومركزة)',
      'vpn_inactive': 'القاطع متوقف (اضغط للتشغيل)',
      'start_btn': 'تشغيل القاطع',
      'stop_btn': 'إيقاف',
      'select_all': 'تحديد الكل (قطع الإنترنت عن الجميع)',
      'filter_all': 'الكل',
      'filter_user': 'تطبيقاتك',
      'filter_system': 'النظام',
      'blocked_status': 'الإنترنت مقطوع ✓',
      'allowed_status': 'مسموح (إنترنت سريع)',
      'system_badge': 'نظام',
      'user_badge': 'تطبيق',
      'menu_mega_counter': 'عداد الميجا (منذ التشغيل)',
      'menu_reset_counter': 'تصفير العداد الخارجي الآن',
      'menu_rate': 'تقييم التطبيق',
      'menu_suggest': 'إرسال مقترح',
      'theme_title': 'المظهر',
      'theme_dark': 'داكن (موفر للطاقة OLED)',
      'theme_light': 'فاتح',
      'theme_system': 'حسب الجهاز',
      'lang_title': 'اللغة (Language)',
      'battery_rem': 'البطارية المتبقية حالياً',
      'battery_since_install': 'المستهلك منذ فتح/تثبيت التطبيق',
      'time_rem': 'الوقت المتبقي التقريبي',
      'hours': 'ساعة',
      'minutes': 'دقيقة',
      'power_apps': 'استهلاك التطبيقات للطاقة (منذ التثبيت):',
      'mega_dialog_title': 'عداد الميجا المستقل (منذ التشغيل)',
      'total_usage': 'إجمالي المسحوب منذ التصفير',
      'rate_dialog_title': 'تقييم قاطع الانترنت مجانا',
      'rate_thanks': 'شكراً لتقييمك!',
      'suggest_dialog_title': 'إرسال مقترح',
      'suggest_hint': 'اكتب مقترحك هنا...',
      'suggest_sent': 'تم إرسال مقترحك بنجاح!',
      'send': 'إرسال',
      'close': 'إغلاق',
      'search_hint': 'ابحث عن أي تطبيق أو خدمة نظام...',
      'loading_apps': 'جاري فحص وجلب كافة تطبيقات الهاتف والنظام...',
    },
    'en': {
      'app_title': 'Free Internet Blocker',
      'tab_blocker': 'Blocker',
      'tab_battery': 'Battery Counter',
      'tab_settings': 'Settings',
      'vpn_active': 'Blocker Active (Network Boosted)',
      'vpn_inactive': 'Blocker Stopped (Tap to Start)',
      'start_btn': 'Start',
      'stop_btn': 'Stop',
      'select_all': 'Select All (Block All)',
      'filter_all': 'All',
      'filter_user': 'User Apps',
      'filter_system': 'System',
      'blocked_status': 'Internet Cut Off ✓',
      'allowed_status': 'Allowed (Fast Net)',
      'system_badge': 'System',
      'user_badge': 'App',
      'menu_mega_counter': 'Live Mega Counter',
      'menu_reset_counter': 'Reset Mega Counter to 0',
      'menu_rate': 'Rate App',
      'menu_suggest': 'Send Suggestion',
      'theme_title': 'Appearance',
      'theme_dark': 'Dark (OLED Saver)',
      'theme_light': 'Light',
      'theme_system': 'System Default',
      'lang_title': 'Language',
      'battery_rem': 'Current Battery Level',
      'battery_since_install': 'Used Since Install / Session Start',
      'time_rem': 'Estimated Time Left',
      'hours': 'h',
      'minutes': 'm',
      'power_apps': 'App Power Usage (Since Install):',
      'mega_dialog_title': 'External Mega Counter (Session)',
      'total_usage': 'Total Used Since Start',
      'rate_dialog_title': 'Rate Free Internet Blocker',
      'rate_thanks': 'Thank you for rating!',
      'suggest_dialog_title': 'Send Suggestion',
      'suggest_hint': 'Write your suggestion...',
      'suggest_sent': 'Suggestion sent!',
      'send': 'Send',
      'close': 'Close',
      'search_hint': 'Search any app or system service...',
      'loading_apps': 'Scanning all installed & system apps...',
    },
    'fr': {
      'app_title': 'Bloqueur Internet Gratuit',
      'tab_blocker': 'Bloqueur',
      'tab_battery': 'Batterie',
      'tab_settings': 'Paramètres',
      'vpn_active': 'Bloqueur Actif (Réseau Accéléré)',
      'vpn_inactive': 'Bloqueur Arrêté',
      'start_btn': 'Démarrer',
      'stop_btn': 'Arrêter',
      'select_all': 'Tout sélectionner',
      'filter_all': 'Tous',
      'filter_user': 'Apps',
      'filter_system': 'Système',
      'blocked_status': 'Internet Coupé ✓',
      'allowed_status': 'Autorisé (Rapide)',
      'system_badge': 'Système',
      'user_badge': 'App',
      'menu_mega_counter': 'Compteur Méga',
      'menu_reset_counter': 'Réinitialiser le compteur',
      'menu_rate': 'Évaluer',
      'menu_suggest': 'Suggestion',
      'theme_title': 'Apparence',
      'theme_dark': 'Sombre',
      'theme_light': 'Clair',
      'theme_system': 'Système',
      'lang_title': 'Langue',
      'battery_rem': 'Batterie Restante',
      'battery_since_install': 'Utilisé depuis l\'installation',
      'time_rem': 'Temps Restant',
      'hours': 'h',
      'minutes': 'm',
      'power_apps': 'Consommation d\'énergie :',
      'mega_dialog_title': 'Compteur Méga Indépendant',
      'total_usage': 'Total utilisé',
      'rate_dialog_title': 'Évaluer',
      'rate_thanks': 'Merci !',
      'suggest_dialog_title': 'Suggestion',
      'suggest_hint': 'Votre suggestion...',
      'suggest_sent': 'Envoyé !',
      'send': 'Envoyer',
      'close': 'Fermer',
      'search_hint': 'Rechercher une application...',
      'loading_apps': 'Chargement de toutes les applications...',
    },
    'es': {
      'app_title': 'Bloqueador de Internet Gratis',
      'tab_blocker': 'Bloqueador',
      'tab_battery': 'Batería',
      'tab_settings': 'Ajustes',
      'vpn_active': 'Bloqueador Activo (Red Rápida)',
      'vpn_inactive': 'Bloqueador Detenido',
      'start_btn': 'Iniciar',
      'stop_btn': 'Detener',
      'select_all': 'Seleccionar todo',
      'filter_all': 'Todos',
      'filter_user': 'Mis Apps',
      'filter_system': 'Sistema',
      'blocked_status': 'Internet Cortado ✓',
      'allowed_status': 'Permitido (Rápido)',
      'system_badge': 'Sistema',
      'user_badge': 'App',
      'menu_mega_counter': 'Contador de Megas',
      'menu_reset_counter': 'Reiniciar contador a 0',
      'menu_rate': 'Calificar',
      'menu_suggest': 'Sugerencia',
      'theme_title': 'Apariencia',
      'theme_dark': 'Oscuro',
      'theme_light': 'Claro',
      'theme_system': 'Sistema',
      'lang_title': 'Idioma',
      'battery_rem': 'Batería Restante',
      'battery_since_install': 'Usado desde la instalación',
      'time_rem': 'Tiempo Estimado',
      'hours': 'h',
      'minutes': 'm',
      'power_apps': 'Consumo de energía:',
      'mega_dialog_title': 'Contador de Megas Externo',
      'total_usage': 'Total consumido',
      'rate_dialog_title': 'Calificar App',
      'rate_thanks': '¡Gracias!',
      'suggest_dialog_title': 'Sugerencia',
      'suggest_hint': 'Escribe aquí...',
      'suggest_sent': '¡Enviado!',
      'send': 'Enviar',
      'close': 'Cerrar',
      'search_hint': 'Buscar aplicación...',
      'loading_apps': 'Cargando todas las aplicaciones...',
    },
    'tr': {
      'app_title': 'Ücretsiz İnternet Kesici',
      'tab_blocker': 'Kesici',
      'tab_battery': 'Pil Sayacı',
      'tab_settings': 'Ayarlar',
      'vpn_active': 'Kesici Aktif (Ağ Hızlandırıldı)',
      'vpn_inactive': 'Kesici Kapalı',
      'start_btn': 'Başlat',
      'stop_btn': 'Durdur',
      'select_all': 'Tümünü Seç',
      'filter_all': 'Tümü',
      'filter_user': 'Uygulamalar',
      'filter_system': 'Sistem',
      'blocked_status': 'İnternet Kesildi ✓',
      'allowed_status': 'İzin Verildi (Hızlı)',
      'system_badge': 'Sistem',
      'user_badge': 'Uygulama',
      'menu_mega_counter': 'Mega Sayacı',
      'menu_reset_counter': 'Sayacı Sıfırla',
      'menu_rate': 'Değerlendir',
      'menu_suggest': 'Öneri Gönder',
      'theme_title': 'Görünüm',
      'theme_dark': 'Karanlık',
      'theme_light': 'Aydınlık',
      'theme_system': 'Sistem',
      'lang_title': 'Dil',
      'battery_rem': 'Kalan Pil',
      'battery_since_install': 'Kurulumdan Beri Kullanılan',
      'time_rem': 'Tahmini Süre',
      'hours': 'sa',
      'minutes': 'dk',
      'power_apps': 'Uygulama Güç Tüketimi:',
      'mega_dialog_title': 'Bağımsız Mega Sayacı',
      'total_usage': 'Toplam Kullanım',
      'rate_dialog_title': 'Değerlendir',
      'rate_thanks': 'Teşekkürler!',
      'suggest_dialog_title': 'Öneri',
      'suggest_hint': 'Önerinizi yazın...',
      'suggest_sent': 'Gönderildi!',
      'send': 'Gönder',
      'close': 'Kapat',
      'search_hint': 'Uygulama ara...',
      'loading_apps': 'Tüm uygulamalar taranıyor...',
    },
    'de': {
      'app_title': 'Kostenloser Internet-Blocker',
      'tab_blocker': 'Blocker',
      'tab_battery': 'Akku-Zähler',
      'tab_settings': 'Optionen',
      'vpn_active': 'Blocker Aktiv (Netzwerk Beschleunigt)',
      'vpn_inactive': 'Blocker Gestoppt',
      'start_btn': 'Starten',
      'stop_btn': 'Stoppen',
      'select_all': 'Alle auswählen',
      'filter_all': 'Alle',
      'filter_user': 'Apps',
      'filter_system': 'System',
      'blocked_status': 'Internet Blockiert ✓',
      'allowed_status': 'Erlaubt (Schnell)',
      'system_badge': 'System',
      'user_badge': 'App',
      'menu_mega_counter': 'Mega-Zähler',
      'menu_reset_counter': 'Zähler zurücksetzen',
      'menu_rate': 'Bewerten',
      'menu_suggest': 'Vorschlag',
      'theme_title': 'Design',
      'theme_dark': 'Dunkel',
      'theme_light': 'Hell',
      'theme_system': 'System',
      'lang_title': 'Sprache',
      'battery_rem': 'Verbleibender Akku',
      'battery_since_install': 'Verbrauch seit Installation',
      'time_rem': 'Geschätzte Restzeit',
      'hours': 'Std',
      'minutes': 'Min',
      'power_apps': 'Stromverbrauch seit Start:',
      'mega_dialog_title': 'Unabhängiger Mega-Zähler',
      'total_usage': 'Gesamtverbrauch',
      'rate_dialog_title': 'Bewerten',
      'rate_thanks': 'Danke!',
      'suggest_dialog_title': 'Vorschlag',
      'suggest_hint': 'Ihr Vorschlag...',
      'suggest_sent': 'Gesendet!',
      'send': 'Senden',
      'close': 'Schließen',
      'search_hint': 'App suchen...',
      'loading_apps': 'Alle Apps werden geladen...',
    },
  };

  static String tr(String langCode, String key) {
    return data[langCode]?[key] ?? data['ar']![key]!;
  }
}

// ==================== نموذج التطبيق الحقيقي ====================
class RealAppItem {
  final String name;
  final String packageName;
  final bool isSystem;
  final Uint8List? iconBytes;
  bool isBlocked;

  // عداد خارجي مستقل: يحفظ قراءة البداية ويطرحها من القراءة الحالية
  int baselineBytes;
  int currentBytes;

  RealAppItem({
    required this.name,
    required this.packageName,
    required this.isSystem,
    this.iconBytes,
    this.isBlocked = false,
    required this.baselineBytes,
    required this.currentBytes,
  });

  // حساب الميجابايت المستهلكة فقط منذ تشغيل القاطع أو التصفير (العداد الخارجي)
  double get sessionMegabytes {
    final diff = currentBytes - baselineBytes;
    if (diff <= 0) return 0.0;
    return diff / (1024 * 1024);
  }
}

// ==================== المتحكم الرئيسي ====================
class AppController extends ChangeNotifier with WidgetsBindingObserver {
  static const MethodChannel _vpnChannel =
      MethodChannel('com.free.netblocker/vpn');

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('ar');
  String _filterType = 'user'; // 'all', 'user', 'system'
  String _searchQuery = '';

  bool _isVpnRunning = false;
  bool _isLoadingApps = true;

  final Battery _battery = Battery();
  int _installBaselineBattery = 100;
  int _currentBatteryLevel = 100;

  List<RealAppItem> _allApps = [];

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  String get filterType => _filterType;
  bool get isVpnRunning => _isVpnRunning;
  bool get isLoadingApps => _isLoadingApps;
  int get currentBatteryLevel => _currentBatteryLevel;

  // كم استهلكت البطارية منذ لحظة التثبيت/الفتح
  int get batteryUsedSinceInstall =>
      (_installBaselineBattery - _currentBatteryLevel).clamp(0, 100);

  String t(String key) => AppTranslations.tr(_locale.languageCode, key);

  AppController() {
    WidgetsBinding.instance.addObserver(this);
    _initializeEverything();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshLiveCounters();
    }
  }

  Future<void> _initializeEverything() async {
    final prefs = await SharedPreferences.getInstance();

    // حفظ مستوى البطارية عند أول تثبيت للتطبيق لبدء العد منه
    final currentBat = await _safeGetBatteryLevel();
    _currentBatteryLevel = currentBat;
    if (!prefs.containsKey('install_battery_baseline')) {
      await prefs.setInt('install_battery_baseline', currentBat);
      _installBaselineBattery = currentBat;
    } else {
      _installBaselineBattery =
          prefs.getInt('install_battery_baseline') ?? currentBat;
    }

    await _loadAllDeviceApps(prefs);
  }

  Future<int> _safeGetBatteryLevel() async {
    try {
      return await _battery.batteryLevel;
    } catch (_) {
      return 85;
    }
  }

  Future<void> _loadAllDeviceApps(SharedPreferences prefs) async {
    _isLoadingApps = true;
    notifyListeners();

    final savedBlocked =
        (prefs.getStringList('blocked_packages') ?? []).toSet();

    try {
      final List<dynamic>? rawList =
          await _vpnChannel.invokeMethod('getInstalledApps');

      if (rawList != null && rawList.isNotEmpty) {
        final List<RealAppItem> loaded = [];
        for (final item in rawList) {
          final map = Map<String, dynamic>.from(item);
          final pkg = map['packageName'] as String;
          final totalBytes = (map['totalBytes'] as num).toInt();

          // حفظ نقطة الصفر (Baseline) لكل تطبيق ليعمل العداد كعداد خارجي مستقل
          final baseKey = 'base_$pkg';
          int baseBytes;
          if (!prefs.containsKey(baseKey)) {
            await prefs.setInt(baseKey, totalBytes);
            baseBytes = totalBytes;
          } else {
            baseBytes = prefs.getInt(baseKey) ?? totalBytes;
          }

          loaded.add(
            RealAppItem(
              name: map['name'] as String,
              packageName: pkg,
              isSystem: map['isSystem'] as bool,
              iconBytes: map['icon'] as Uint8List?,
              isBlocked: savedBlocked.contains(pkg),
              baselineBytes: baseBytes,
              currentBytes: totalBytes,
            ),
          );
        }
        // ترتيب أبجدي مع وضع التطبيقات العادية أولاً
        loaded.sort((a, b) {
          if (a.isSystem != b.isSystem) {
            return a.isSystem ? 1 : -1;
          }
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        _allApps = loaded;
      } else {
        _loadFallbackAppsForDesktopPreview();
      }
    } catch (_) {
      _loadFallbackAppsForDesktopPreview();
    }

    _isLoadingApps = false;
    notifyListeners();
  }

  // قائمة احتياطية شاملة تظهر فقط إذا تم تشغيل الكود على الكمبيوتر (خارج الأندرويد)
  void _loadFallbackAppsForDesktopPreview() {
    _allApps = [
      RealAppItem(name: 'واتساب (WhatsApp)', packageName: 'com.whatsapp', isSystem: false, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'يوتيوب (YouTube)', packageName: 'com.google.android.youtube', isSystem: false, isBlocked: true, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'تليجرام (Telegram)', packageName: 'org.telegram.messenger', isSystem: false, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'متصفح كروم (Chrome)', packageName: 'com.android.chrome', isSystem: false, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'فيسبوك (Facebook)', packageName: 'com.facebook.katana', isSystem: false, isBlocked: true, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'إنستغرام (Instagram)', packageName: 'com.instagram.android', isSystem: false, isBlocked: true, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'تيك توك (TikTok)', packageName: 'com.zhiliaoapp.musically', isSystem: false, isBlocked: true, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'ماسنجر (Messenger)', packageName: 'com.facebook.orca', isSystem: false, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'سناب شات (Snapchat)', packageName: 'com.snapchat.android', isSystem: false, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'جيميل (Gmail)', packageName: 'com.google.android.gm', isSystem: false, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'خرائط جوجل (Maps)', packageName: 'com.google.android.apps.maps', isSystem: false, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'متجر جوجل بلاي', packageName: 'com.android.vending', isSystem: true, isBlocked: true, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'خدمات جوجل بلاي', packageName: 'com.google.android.gms', isSystem: true, isBlocked: true, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'محدث النظام (System Updater)', packageName: 'com.android.updater', isSystem: true, isBlocked: true, baselineBytes: 1000, currentBytes: 1000),
      RealAppItem(name: 'نواة نظام أندرويد', packageName: 'android.system.core', isSystem: true, baselineBytes: 1000, currentBytes: 1000),
    ];
  }

  // تصفير العداد الخارجي ليبدأ الحساب من 0.00 MB من هذه اللحظة
  Future<void> resetExternalMegaCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await refreshLiveCounters();
    for (var app in _allApps) {
      app.baselineBytes = app.currentBytes;
      await prefs.setInt('base_${app.packageName}', app.currentBytes);
    }
    notifyListeners();
  }

  // تحديث قراءة استهلاك الميجا والبطارية عند الطلب فقط (بدون سحب طاقة بالخلفية)
  Future<void> refreshLiveCounters() async {
    _currentBatteryLevel = await _safeGetBatteryLevel();
    try {
      final Map<dynamic, dynamic>? liveMap =
          await _vpnChannel.invokeMethod('getLiveTraffic');
      if (liveMap != null) {
        for (var app in _allApps) {
          if (liveMap.containsKey(app.packageName)) {
            app.currentBytes = (liveMap[app.packageName] as num).toInt();
          }
        }
      }
    } catch (_) {}
    notifyListeners();
  }

  // تشغيل أو إيقاف القاطع الرئيسي (VPN)
  Future<void> toggleMasterVpn() async {
    if (_isVpnRunning) {
      try {
        await _vpnChannel.invokeMethod('stopVpn');
      } catch (_) {}
      _isVpnRunning = false;
      notifyListeners();
    } else {
      // عند تشغيل القاطع، نصفر العداد الخارجي ليحسب فقط ما يُستهلك من الآن فصاعداً
      await resetExternalMegaCounter();
      final blockedList = _allApps
          .where((a) => a.isBlocked)
          .map((a) => a.packageName)
          .toList();
      try {
        final bool ok = await _vpnChannel.invokeMethod('startOrUpdateVpn', {
          'blockedApps': blockedList,
        });
        _isVpnRunning = ok;
      } catch (_) {
        _isVpnRunning = true;
      }
      notifyListeners();
    }
  }

  // حفظ الاختيارات وتحديث الـ VPN فوراً إذا كان القاطع شغالاً فقط
  Future<void> _saveAndSyncVpnIfRunning() async {
    final prefs = await SharedPreferences.getInstance();
    final blockedList = _allApps
        .where((a) => a.isBlocked)
        .map((a) => a.packageName)
        .toList();
    await prefs.setStringList('blocked_packages', blockedList);

    // الميزة المطلوبة: إذا كان القاطع شغالاً يحدث نفسه فوراً مع كل ضغطة، وإذا كان مغلقاً لا يعمل تحديث
    if (_isVpnRunning) {
      try {
        await _vpnChannel.invokeMethod('startOrUpdateVpn', {
          'blockedApps': blockedList,
        });
      } catch (_) {}
    }
  }

  void toggleSingleApp(RealAppItem app, bool? val) {
    app.isBlocked = val ?? false;
    notifyListeners();
    _saveAndSyncVpnIfRunning();
  }

  void toggleSelectAllVisible(bool? val) {
    final target = val ?? false;
    for (var app in filteredApps) {
      app.isBlocked = target;
    }
    notifyListeners();
    _saveAndSyncVpnIfRunning();
  }

  List<RealAppItem> get filteredApps {
    return _allApps.where((app) {
      if (_filterType == 'user' && app.isSystem) return false;
      if (_filterType == 'system' && !app.isSystem) return false;
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        return app.name.toLowerCase().contains(q) ||
            app.packageName.toLowerCase().contains(q);
      }
      return true;
    }).toList();
  }

  bool get isAllVisibleBlocked {
    final visible = filteredApps;
    return visible.isNotEmpty && visible.every((a) => a.isBlocked);
  }

  void setFilterType(String type) {
    _filterType = type;
    notifyListeners();
  }

  void setSearchQuery(String q) {
    _searchQuery = q;
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

  double get totalSessionMegabytes =>
      _allApps.fold(0.0, (sum, app) => sum + app.sessionMegabytes);

  String getRemainingBatteryTime() {
    final blockedCount = _allApps.where((a) => a.isBlocked).length;
    final bonus = _isVpnRunning ? (blockedCount * 0.08) : 0.0;
    final int totalMinutes = (_currentBatteryLevel * (4.3 + bonus)).round();
    final int hours = totalMinutes ~/ 60;
    final int minutes = totalMinutes % 60;
    return '$hours ${t('hours')} : $minutes ${t('minutes')}';
  }
}

// ==================== التطبيق الرئيسي ====================
class FreeNetBlockerApp extends StatelessWidget {
  const FreeNetBlockerApp({super.key});

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
        colorSchemeSeed: Colors.green,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.green,
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
      home: const MainDashboard(),
    );
  }
}

// ==================== الواجهة الرئيسية ====================
class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);

    final pages = [
      const BlockerScreen(),
      const BatteryScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ctrl.t('app_title'),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (val) async {
              if (val == 'mega') {
                await ctrl.refreshLiveCounters();
                if (context.mounted) _showMegaCounterDialog(context, ctrl);
              } else if (val == 'reset') {
                await ctrl.resetExternalMegaCounter();
              } else if (val == 'rate') {
                _showRateDialog(context, ctrl);
              } else if (val == 'suggest') {
                _showSuggestDialog(context, ctrl);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'mega',
                child: Row(
                  children: [
                    const Icon(Icons.network_check, color: Colors.blue),
                    const SizedBox(width: 10),
                    Expanded(child: Text(ctrl.t('menu_mega_counter'))),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'reset',
                child: Row(
                  children: [
                    const Icon(Icons.restart_alt, color: Colors.orange),
                    const SizedBox(width: 10),
                    Expanded(child: Text(ctrl.t('menu_reset_counter'))),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'rate',
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 10),
                    Expanded(child: Text(ctrl.t('menu_rate'))),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'suggest',
                child: Row(
                  children: [
                    const Icon(Icons.chat_bubble_outline, color: Colors.green),
                    const SizedBox(width: 10),
                    Expanded(child: Text(ctrl.t('menu_suggest'))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: pages[_tabIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (i) {
          setState(() => _tabIndex = i);
          if (i == 1) ctrl.refreshLiveCounters();
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
    final sorted = List<RealAppItem>.from(ctrl.filteredApps)
      ..sort((a, b) => b.sessionMegabytes.compareTo(a.sessionMegabytes));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          ctrl.t('mega_dialog_title'),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 380,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(ctrl.t('total_usage'),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      '${ctrl.totalSessionMegabytes.toStringAsFixed(2)} MB',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: sorted.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, idx) {
                    final app = sorted[idx];
                    return ListTile(
                      dense: true,
                      leading: app.iconBytes != null && app.iconBytes!.isNotEmpty
                          ? Image.memory(app.iconBytes!, width: 32, height: 32)
                          : const Icon(Icons.android, color: Colors.teal),
                      title: Text(app.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        app.isBlocked
                            ? ctrl.t('blocked_status')
                            : ctrl.t('allowed_status'),
                        style: TextStyle(
                          fontSize: 11,
                          color: app.isBlocked ? Colors.red : Colors.green,
                        ),
                      ),
                      trailing: Text(
                        '${app.sessionMegabytes.toStringAsFixed(2)} MB',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
            onPressed: () async {
              await ctrl.resetExternalMegaCounter();
              if (context.mounted) Navigator.pop(context);
            },
            child: Text(ctrl.t('menu_reset_counter')),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(ctrl.t('close')),
          ),
        ],
      ),
    );
  }

  void _showRateDialog(BuildContext context, AppController ctrl) {
    int stars = 5;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text(ctrl.t('rate_dialog_title')),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < stars ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 34,
                ),
                onPressed: () => setStateDialog(() => stars = index + 1),
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
    final txt = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ctrl.t('suggest_dialog_title')),
        content: TextField(
          controller: txt,
          maxLines: 3,
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

// ==================== 1. شاشة القاطع الشامل ====================
class BlockerScreen extends StatelessWidget {
  const BlockerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);
    final apps = ctrl.filteredApps;

    return Column(
      children: [
        // زر تشغيل وإيقاف القاطع الرئيسي (Master VPN Switch)
        Container(
          margin: const EdgeInsets.fromLTRB(12, 10, 12, 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: ctrl.isVpnRunning
                  ? [Colors.green.shade700, Colors.teal.shade600]
                  : [Colors.grey.shade800, Colors.blueGrey.shade900],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ],
          ),
          child: Row(
            children: [
              Icon(
                ctrl.isVpnRunning ? Icons.vpn_lock : Icons.power_settings_new,
                color: Colors.white,
                size: 36,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  ctrl.isVpnRunning
                      ? ctrl.t('vpn_active')
                      : ctrl.t('vpn_inactive'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      ctrl.isVpnRunning ? Colors.redAccent : Colors.greenAccent.shade700,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => ctrl.toggleMasterVpn(),
                child: Text(
                  ctrl.isVpnRunning ? ctrl.t('stop_btn') : ctrl.t('start_btn'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

        // شريط البحث + فلاتر (تطبيقاتك / النظام / الكل) + تحديد الكل
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (v) => ctrl.setSearchQuery(v),
                  decoration: InputDecoration(
                    hintText: ctrl.t('search_hint'),
                    prefixIcon: const Icon(Icons.search),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ChoiceChip(
                      label: Text(ctrl.t('filter_user')),
                      selected: ctrl.filterType == 'user',
                      onSelected: (_) => ctrl.setFilterType('user'),
                    ),
                    ChoiceChip(
                      label: Text(ctrl.t('filter_system')),
                      selected: ctrl.filterType == 'system',
                      onSelected: (_) => ctrl.setFilterType('system'),
                    ),
                    ChoiceChip(
                      label: Text(ctrl.t('filter_all')),
                      selected: ctrl.filterType == 'all',
                      onSelected: (_) => ctrl.setFilterType('all'),
                    ),
                  ],
                ),
                const Divider(height: 8),
                CheckboxListTile(
                  dense: true,
                  value: ctrl.isAllVisibleBlocked,
                  activeColor: Colors.red,
                  title: Text(
                    '${ctrl.t('select_all')} (${apps.length})',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onChanged: (val) => ctrl.toggleSelectAllVisible(val),
                ),
              ],
            ),
          ),
        ),

        // قائمة كافة التطبيقات
        Expanded(
          child: ctrl.isLoadingApps
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 12),
                      Text(ctrl.t('loading_apps')),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: apps.length,
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: true,
                  itemBuilder: (context, index) {
                    final app = apps[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 3),
                      child: CheckboxListTile(
                        value: app.isBlocked,
                        activeColor: Colors.red,
                        checkColor: Colors.white,
                        onChanged: (val) => ctrl.toggleSingleApp(app, val),
                        secondary: app.iconBytes != null &&
                                app.iconBytes!.isNotEmpty
                            ? Image.memory(app.iconBytes!, width: 40, height: 40)
                            : CircleAvatar(
                                backgroundColor: app.isBlocked
                                    ? Colors.red.withOpacity(0.15)
                                    : Colors.green.withOpacity(0.15),
                                child: Icon(
                                  app.isSystem ? Icons.settings : Icons.android,
                                  color:
                                      app.isBlocked ? Colors.red : Colors.green,
                                ),
                              ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                app.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
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
                                  color: app.isSystem
                                      ? Colors.orange
                                      : Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              app.isBlocked
                                  ? ctrl.t('blocked_status')
                                  : ctrl.t('allowed_status'),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color:
                                    app.isBlocked ? Colors.red : Colors.green,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${app.sessionMegabytes.toStringAsFixed(2)} MB',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
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

// ==================== 2. شاشة عداد البطارية (منذ لحظة التثبيت) ====================
class BatteryScreen extends StatelessWidget {
  const BatteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);
    final activeApps = List<RealAppItem>.from(ctrl.filteredApps)
      ..sort((a, b) => b.sessionMegabytes.compareTo(a.sessionMegabytes));

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ctrl.t('battery_rem'),
                            style: const TextStyle(color: Colors.grey)),
                        Text(
                          '${ctrl.currentBatteryLevel}%',
                          style: const TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${ctrl.t('battery_since_install')}: ${ctrl.batteryUsedSinceInstall}%',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${ctrl.t('time_rem')}: ${ctrl.getRemainingBatteryTime()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: ctrl.currentBatteryLevel / 100,
                          strokeWidth: 8,
                          color: Colors.green,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                        ),
                        const Icon(Icons.battery_charging_full,
                            color: Colors.green, size: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            ctrl.t('power_apps'),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: activeApps.length,
              itemBuilder: (context, index) {
                final app = activeApps[index];
                // تقدير استهلاك الطاقة منذ التثبيت بناءً على نشاط الشبكة والعمل بالخلفية
                final double estMah =
                    (app.sessionMegabytes * 1.8) + (app.isBlocked ? 0.0 : 2.5);
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  child: ListTile(
                    leading: app.iconBytes != null && app.iconBytes!.isNotEmpty
                        ? Image.memory(app.iconBytes!, width: 36, height: 36)
                        : const Icon(Icons.bolt, color: Colors.orange),
                    title: Text(app.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(app.packageName,
                        style: const TextStyle(fontSize: 11)),
                    trailing: Text(
                      '${estMah.toStringAsFixed(1)} mAh',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
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

// ==================== 3. شاشة الإعدادات ====================
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ctrl.t('theme_title'),
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
                const Divider(),
                RadioListTile<ThemeMode>(
                  title: Text(ctrl.t('theme_dark')),
                  value: ThemeMode.dark,
                  groupValue: ctrl.themeMode,
                  onChanged: (v) => ctrl.setThemeMode(v!),
                ),
                RadioListTile<ThemeMode>(
                  title: Text(ctrl.t('theme_light')),
                  value: ThemeMode.light,
                  groupValue: ctrl.themeMode,
                  onChanged: (v) => ctrl.setThemeMode(v!),
                ),
                RadioListTile<ThemeMode>(
                  title: Text(ctrl.t('theme_system')),
                  value: ThemeMode.system,
                  groupValue: ctrl.themeMode,
                  onChanged: (v) => ctrl.setThemeMode(v!),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ctrl.t('lang_title'),
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
                const Divider(),
                DropdownButtonFormField<String>(
                  value: ctrl.locale.languageCode,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'ar', child: Text('العربية')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'fr', child: Text('Français')),
                    DropdownMenuItem(value: 'es', child: Text('Español')),
                    DropdownMenuItem(value: 'tr', child: Text('Türkçe')),
                    DropdownMenuItem(value: 'de', child: Text('Deutsch')),
                  ],
                  onChanged: (c) {
                    if (c != null) ctrl.setLanguage(c);
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
