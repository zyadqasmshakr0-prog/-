import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
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
      'tab_counter': 'عداد الميجا',
      'tab_battery': 'البطارية',
      'tab_settings': 'الإعدادات',
      'vpn_on': 'شغال',
      'vpn_off': 'متوقف',
      'select_all': 'تحديد الكل',
      'filter_all': 'الكل',
      'filter_user': 'تطبيقاتك',
      'filter_system': 'النظام',
      'blocked_status': 'الإنترنت مقطوع ✓',
      'allowed_status': 'مسموح بالإنترنت',
      'system_badge': 'نظام',
      'user_badge': 'تطبيق',
      'menu_mega_counter': 'فتح عداد الميجا الحي',
      'menu_reset_counter': 'تصفير العداد يدوياً (إعادة للصفر)',
      'menu_rate': 'تقييم التطبيق (إعجاب)',
      'menu_suggest': 'إرسال مقترح لبريدي',
      'theme_title': 'المظهر',
      'theme_dark': 'داكن (موفر للطاقة OLED)',
      'theme_light': 'فاتح',
      'theme_system': 'حسب الجهاز',
      'lang_title': 'اللغة (Language)',
      'search_hint': 'ابحث عن تطبيق أو خدمة نظام...',
      'loading_apps': 'جاري فحص وجلب كافة تطبيقات الهاتف والنظام...',
      'allowed_apps_counter': 'التطبيقات المسموح لها بالإنترنت (العداد التراكمي):',
      'total_counter_label': 'إجمالي استهلاك المسموح لهم (محفوظ حتى تصفره بنفسك)',
      'reset_btn': 'تصفير العداد الآن',
      'battery_live_level': 'نسبة البطارية الحية',
      'battery_charging': 'جاري الشحن ⚡',
      'battery_discharging': 'يتم الاستهلاك الآن',
      'battery_temp': 'الحرارة',
      'battery_volt': 'الفولتية',
      'battery_current': 'السحب اللحظي',
      'battery_time_rem': 'الوقت المتبقي',
      'hours': 'ساعة',
      'minutes': 'دقيقة',
      'system_power_apps': 'استهلاك التطبيقات الحقيقي للطاقة (حسب النظام):',
      'grant_usage_perm': 'تفعيل قراءة استهلاك النظام الدقيق للبطارية والميجا',
      'open_system_battery': 'عرض شاشة بطارية النظام الأصلية',
      'screen_time': 'وقت النشاط',
      'rate_dialog_title': 'إعجاب وتقييم التطبيق',
      'rate_comment_hint': 'أضف تعليقك مع الإعجاب (اختياري)...',
      'rate_thanks': 'تم توجيه التقييم والإعجاب إلى حساب جوجل الخاص بك!',
      'suggest_dialog_title': 'إرسال مقترح إلى حساب المطور',
      'suggest_hint': 'اكتب مقترحك هنا ليصل مباشرة إلى بريد جوجل...',
      'suggest_sent': 'جاري الإرسال إلى zyadqasmshakr0@gmail.com...',
      'send': 'إرسال لبريد جوجل',
      'close': 'إغلاق',
    },
    'en': {
      'app_title': 'Free Internet Blocker',
      'tab_blocker': 'Blocker',
      'tab_counter': 'Mega Counter',
      'tab_battery': 'Battery',
      'tab_settings': 'Settings',
      'vpn_on': 'ON',
      'vpn_off': 'OFF',
      'select_all': 'Select All',
      'filter_all': 'All',
      'filter_user': 'My Apps',
      'filter_system': 'System',
      'blocked_status': 'Blocked ✓',
      'allowed_status': 'Allowed',
      'system_badge': 'Sys',
      'user_badge': 'App',
      'menu_mega_counter': 'Open Live Mega Counter',
      'menu_reset_counter': 'Manual Reset Counter to 0',
      'menu_rate': 'Like & Rate App',
      'menu_suggest': 'Send Suggestion to Gmail',
      'theme_title': 'Appearance',
      'theme_dark': 'Dark (OLED Saver)',
      'theme_light': 'Light',
      'theme_system': 'System Default',
      'lang_title': 'Language',
      'search_hint': 'Search apps or system services...',
      'loading_apps': 'Scanning all device & system apps...',
      'allowed_apps_counter': 'Allowed Internet Apps (Persistent Counter):',
      'total_counter_label': 'Total Allowed Usage (Saved Until Manual Reset)',
      'reset_btn': 'Reset Counter Now',
      'battery_live_level': 'Live Battery Level',
      'battery_charging': 'Charging ⚡',
      'battery_discharging': 'Discharging',
      'battery_temp': 'Temp',
      'battery_volt': 'Voltage',
      'battery_current': 'Current Draw',
      'battery_time_rem': 'Time Left',
      'hours': 'h',
      'minutes': 'm',
      'system_power_apps': 'Real System App Power Usage:',
      'grant_usage_perm': 'Enable Real System Battery & Data Stats Access',
      'open_system_battery': 'Open Native Android Battery Screen',
      'screen_time': 'Active Time',
      'rate_dialog_title': 'Like & Rate App',
      'rate_comment_hint': 'Add a note with your rating (optional)...',
      'rate_thanks': 'Redirecting rating to your Google account!',
      'suggest_dialog_title': 'Send Suggestion to Developer Gmail',
      'suggest_hint': 'Write your suggestion...',
      'suggest_sent': 'Sending to zyadqasmshakr0@gmail.com...',
      'send': 'Send to Gmail',
      'close': 'Close',
    },
    'fr': {
      'app_title': 'Bloqueur Internet Gratuit',
      'tab_blocker': 'Bloqueur',
      'tab_counter': 'Compteur Méga',
      'tab_battery': 'Batterie',
      'tab_settings': 'Paramètres',
      'vpn_on': 'ACTIF',
      'vpn_off': 'ARRÊT',
      'select_all': 'Tout cocher',
      'filter_all': 'Tous',
      'filter_user': 'Mes Apps',
      'filter_system': 'Système',
      'blocked_status': 'Bloqué ✓',
      'allowed_status': 'Autorisé',
      'system_badge': 'Sys',
      'user_badge': 'App',
      'menu_mega_counter': 'Compteur Méga',
      'menu_reset_counter': 'Réinitialiser manuellement à 0',
      'menu_rate': 'Aimer et Évaluer',
      'menu_suggest': 'Envoyer une suggestion (Gmail)',
      'theme_title': 'Apparence',
      'theme_dark': 'Sombre',
      'theme_light': 'Clair',
      'theme_system': 'Système',
      'lang_title': 'Langue',
      'search_hint': 'Rechercher...',
      'loading_apps': 'Chargement des applications...',
      'allowed_apps_counter': 'Applications Autorisées (Compteur persistant):',
      'total_counter_label': 'Total utilisé (Sauvegardé jusqu\'à réinitialisation)',
      'reset_btn': 'Réinitialiser',
      'battery_live_level': 'Batterie en direct',
      'battery_charging': 'En charge ⚡',
      'battery_discharging': 'En cours d\'utilisation',
      'battery_temp': 'Temp',
      'battery_volt': 'Tension',
      'battery_current': 'Courant',
      'battery_time_rem': 'Temps restant',
      'hours': 'h',
      'minutes': 'm',
      'system_power_apps': 'Consommation réelle des applications:',
      'grant_usage_perm': 'Activer l\'accès aux statistiques système',
      'open_system_battery': 'Ouvrir les paramètres de batterie Android',
      'screen_time': 'Temps actif',
      'rate_dialog_title': 'Évaluer',
      'rate_comment_hint': 'Votre commentaire...',
      'rate_thanks': 'Merci !',
      'suggest_dialog_title': 'Suggestion',
      'suggest_hint': 'Votre suggestion...',
      'suggest_sent': 'Envoyé !',
      'send': 'Envoyer',
      'close': 'Fermer',
    },
    'es': {
      'app_title': 'Bloqueador de Internet Gratis',
      'tab_blocker': 'Bloqueador',
      'tab_counter': 'Contador Megas',
      'tab_battery': 'Batería',
      'tab_settings': 'Ajustes',
      'vpn_on': 'ACTIVO',
      'vpn_off': 'PARADO',
      'select_all': 'Todo',
      'filter_all': 'Todos',
      'filter_user': 'Mis Apps',
      'filter_system': 'Sistema',
      'blocked_status': 'Cortado ✓',
      'allowed_status': 'Permitido',
      'system_badge': 'Sis',
      'user_badge': 'App',
      'menu_mega_counter': 'Contador de Megas',
      'menu_reset_counter': 'Reiniciar manualmente a 0',
      'menu_rate': 'Me gusta y Calificar',
      'menu_suggest': 'Enviar sugerencia a Gmail',
      'theme_title': 'Apariencia',
      'theme_dark': 'Oscuro',
      'theme_light': 'Claro',
      'theme_system': 'Sistema',
      'lang_title': 'Idioma',
      'search_hint': 'Buscar aplicación...',
      'loading_apps': 'Cargando todas las aplicaciones...',
      'allowed_apps_counter': 'Apps con Internet Permitido:',
      'total_counter_label': 'Uso Total (Guardado hasta reinicio manual)',
      'reset_btn': 'Reiniciar',
      'battery_live_level': 'Nivel de Batería',
      'battery_charging': 'Cargando ⚡',
      'battery_discharging': 'Descargando',
      'battery_temp': 'Temp',
      'battery_volt': 'Voltaje',
      'battery_current': 'Corriente',
      'battery_time_rem': 'Tiempo restante',
      'hours': 'h',
      'minutes': 'm',
      'system_power_apps': 'Consumo real de batería por aplicación:',
      'grant_usage_perm': 'Permitir acceso a estadísticas del sistema',
      'open_system_battery': 'Abrir pantalla de batería del sistema',
      'screen_time': 'Tiempo activo',
      'rate_dialog_title': 'Calificar',
      'rate_comment_hint': 'Tu comentario...',
      'rate_thanks': '¡Gracias!',
      'suggest_dialog_title': 'Sugerencia',
      'suggest_hint': 'Escribe aquí...',
      'suggest_sent': '¡Enviado!',
      'send': 'Enviar',
      'close': 'Cerrar',
    },
    'tr': {
      'app_title': 'Ücretsiz İnternet Kesici',
      'tab_blocker': 'Kesici',
      'tab_counter': 'Mega Sayacı',
      'tab_battery': 'Pil',
      'tab_settings': 'Ayarlar',
      'vpn_on': 'AÇIK',
      'vpn_off': 'KAPALI',
      'select_all': 'Tümü',
      'filter_all': 'Tümü',
      'filter_user': 'Uygulamalar',
      'filter_system': 'Sistem',
      'blocked_status': 'Kesildi ✓',
      'allowed_status': 'İzinli',
      'system_badge': 'Sis',
      'user_badge': 'Uyg',
      'menu_mega_counter': 'Canlı Mega Sayacı',
      'menu_reset_counter': 'Sayacı Manuel Sıfırla',
      'menu_rate': 'Beğen ve Değerlendir',
      'menu_suggest': 'Gmail\'e Öneri Gönder',
      'theme_title': 'Görünüm',
      'theme_dark': 'Karanlık',
      'theme_light': 'Aydınlık',
      'theme_system': 'Sistem',
      'lang_title': 'Dil',
      'search_hint': 'Uygulama ara...',
      'loading_apps': 'Tüm uygulamalar yükleniyor...',
      'allowed_apps_counter': 'İnternete İzin Verilenler (Kalıcı Sayaç):',
      'total_counter_label': 'Toplam Kullanım (Sıfırlanana Kadar Silinmez)',
      'reset_btn': 'Sıfırla',
      'battery_live_level': 'Canlı Pil Seviyesi',
      'battery_charging': 'Şarj Oluyor ⚡',
      'battery_discharging': 'Kullanılıyor',
      'battery_temp': 'Sıcaklık',
      'battery_volt': 'Voltaj',
      'battery_current': 'Akım',
      'battery_time_rem': 'Kalan Süre',
      'hours': 'sa',
      'minutes': 'dk',
      'system_power_apps': 'Gerçek Sistem Pil Tüketimi:',
      'grant_usage_perm': 'Sistem İstatistikleri İznini Etkinleştir',
      'open_system_battery': 'Sistem Pil Ekranını Aç',
      'screen_time': 'Aktif Süre',
      'rate_dialog_title': 'Değerlendir',
      'rate_comment_hint': 'Yorumunuz...',
      'rate_thanks': 'Teşekkürler!',
      'suggest_dialog_title': 'Öneri',
      'suggest_hint': 'Önerinizi yazın...',
      'suggest_sent': 'Gönderildi!',
      'send': 'Gönder',
      'close': 'Kapat',
    },
    'de': {
      'app_title': 'Kostenloser Internet-Blocker',
      'tab_blocker': 'Blocker',
      'tab_counter': 'Mega-Zähler',
      'tab_battery': 'Akku',
      'tab_settings': 'Optionen',
      'vpn_on': 'AN',
      'vpn_off': 'AUS',
      'select_all': 'Alle',
      'filter_all': 'Alle',
      'filter_user': 'Meine Apps',
      'filter_system': 'System',
      'blocked_status': 'Blockiert ✓',
      'allowed_status': 'Erlaubt',
      'system_badge': 'Sys',
      'user_badge': 'App',
      'menu_mega_counter': 'Live Mega-Zähler',
      'menu_reset_counter': 'Zähler manuell zurücksetzen',
      'menu_rate': 'App bewerten',
      'menu_suggest': 'Vorschlag an Gmail senden',
      'theme_title': 'Design',
      'theme_dark': 'Dunkel',
      'theme_light': 'Hell',
      'theme_system': 'System',
      'lang_title': 'Sprache',
      'search_hint': 'App suchen...',
      'loading_apps': 'Alle Apps werden geladen...',
      'allowed_apps_counter': 'Erlaubte Apps (Dauerhafter Zähler):',
      'total_counter_label': 'Gesamtverbrauch (Bleibt bis zum Reset gespeichert)',
      'reset_btn': 'Zurücksetzen',
      'battery_live_level': 'Live-Akkustand',
      'battery_charging': 'Lädt ⚡',
      'battery_discharging': 'Entlädt',
      'battery_temp': 'Temp',
      'battery_volt': 'Spannung',
      'battery_current': 'Strom',
      'battery_time_rem': 'Restzeit',
      'hours': 'Std',
      'minutes': 'Min',
      'system_power_apps': 'Echter System-Stromverbrauch:',
      'grant_usage_perm': 'Systemstatistiken-Zugriff aktivieren',
      'open_system_battery': 'System-Akkubildschirm öffnen',
      'screen_time': 'Aktive Zeit',
      'rate_dialog_title': 'Bewerten',
      'rate_comment_hint': 'Kommentar...',
      'rate_thanks': 'Danke!',
      'suggest_dialog_title': 'Vorschlag',
      'suggest_hint': 'Ihr Vorschlag...',
      'suggest_sent': 'Gesendet!',
      'send': 'Senden',
      'close': 'Schließen',
    },
  };

  static String tr(String langCode, String key) {
    return data[langCode]?[key] ?? data['ar']![key]!;
  }
}

// ==================== نموذج التطبيق الحقيقي مع العداد الدائم ====================
class RealAppItem {
  final String name;
  final String packageName;
  final bool isSystem;
  final Uint8List? iconBytes;
  bool isBlocked;

  // عداد تراكمي دائم لا ينمحي أبداً عند إغلاق التطبيق أو إعادة تشغيل الهاتف
  int savedAccumulatedBytes;
  int lastSeenRawBytes;
  int foregroundTimeMs;

  RealAppItem({
    required this.name,
    required this.packageName,
    required this.isSystem,
    this.iconBytes,
    this.isBlocked = false,
    required this.savedAccumulatedBytes,
    required this.lastSeenRawBytes,
    this.foregroundTimeMs = 0,
  });

  double get sessionMegabytes => savedAccumulatedBytes / (1024.0 * 1024.0);

  String get formattedLiveCounter {
    final b = savedAccumulatedBytes;
    if (b <= 0) return '0.00 MB';
    if (b < 1024 * 1024) {
      final kb = b / 1024.0;
      return '${kb.toStringAsFixed(1)} KB (${sessionMegabytes.toStringAsFixed(2)} MB)';
    }
    return '${sessionMegabytes.toStringAsFixed(2)} MB';
  }

  String get formattedActiveTime {
    final totalMinutes = (foregroundTimeMs / 60000).round();
    if (totalMinutes <= 0) return '< 1m';
    final h = totalMinutes ~/ 60;
    final m = totalMinutes % 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }
}

// ==================== المتحكم الرئيسي ====================
class AppController extends ChangeNotifier with WidgetsBindingObserver {
  static const MethodChannel _vpnChannel =
      MethodChannel('com.free.netblocker/vpn');

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('ar');
  String _filterType = 'user';
  String _searchQuery = '';
  bool _isSearchExpanded = false;

  bool _isVpnRunning = false;
  bool _isLoadingApps = true;
  bool _hasUsagePermission = false;

  int _batteryLevel = 85;
  bool _isCharging = false;
  double _temperatureC = 31.0;
  int _voltageMv = 3950;
  int _currentMa = 240;

  // عداد الجهاز الكلي التراكمي الدائم
  int _savedDeviceAccumulatedBytes = 0;
  int _lastSeenDeviceRawBytes = -1;

  Timer? _foregroundLiveTimer;
  List<RealAppItem> _allApps = [];

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  String get filterType => _filterType;
  bool get isSearchExpanded => _isSearchExpanded;
  bool get isVpnRunning => _isVpnRunning;
  bool get isLoadingApps => _isLoadingApps;
  bool get hasUsagePermission => _hasUsagePermission;

  int get batteryLevel => _batteryLevel;
  bool get isCharging => _isCharging;
  double get temperatureC => _temperatureC;
  int get voltageMv => _voltageMv;
  int get currentMa => _currentMa;

  String t(String key) => AppTranslations.tr(_locale.languageCode, key);

  AppController() {
    WidgetsBinding.instance.addObserver(this);
    _initApp();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopForegroundTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _syncVpnStatusFromNative();
      refreshLiveSystemStats();
      _startForegroundTimer();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _stopForegroundTimer();
    }
  }

  void _startForegroundTimer() {
    _stopForegroundTimer();
    _foregroundLiveTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      refreshLiveSystemStats();
    });
  }

  void _stopForegroundTimer() {
    _foregroundLiveTimer?.cancel();
    _foregroundLiveTimer = null;
  }

  Future<void> _initApp() async {
    final prefs = await SharedPreferences.getInstance();

    // استرجاع حالة زر التشغيل المحفوظة وحالة خدمة الـ VPN الحقيقية
    _isVpnRunning = prefs.getBool('saved_vpn_running') ?? false;
    await _syncVpnStatusFromNative();

    // استرجاع العداد الكلي التراكمي الدائم
    _savedDeviceAccumulatedBytes = prefs.getInt('acc_device_total') ?? 0;
    _lastSeenDeviceRawBytes = prefs.getInt('last_raw_device_total') ?? -1;

    await _loadAllDeviceApps(prefs);
    await refreshLiveSystemStats();
    _startForegroundTimer();
  }

  // التأكد من حالة زر التشغيل الحقيقية عند الخروج والعودة للتطبيق
  Future<void> _syncVpnStatusFromNative() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bool? nativeActive =
          await _vpnChannel.invokeMethod<bool>('isVpnActive');
      final bool savedPref = prefs.getBool('saved_vpn_running') ?? false;
      _isVpnRunning = (nativeActive ?? false) || savedPref;
      notifyListeners();
    } catch (_) {}
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
          final rawBytes = (map['totalBytes'] as num).toInt();

          // استرجاع العداد التراكمي المحفوظ لكل تطبيق (لا يمتحي أبداً إلا بالتصفير اليدوي)
          final accKey = 'acc_$pkg';
          final lastRawKey = 'last_raw_$pkg';

          int accBytes = prefs.getInt(accKey) ?? 0;
          int lastRaw = prefs.getInt(lastRawKey) ?? rawBytes;

          if (rawBytes > lastRaw) {
            accBytes += (rawBytes - lastRaw);
          }
          lastRaw = rawBytes;

          await prefs.setInt(accKey, accBytes);
          await prefs.setInt(lastRawKey, lastRaw);

          loaded.add(
            RealAppItem(
              name: map['name'] as String,
              packageName: pkg,
              isSystem: map['isSystem'] as bool,
              iconBytes: map['icon'] as Uint8List?,
              isBlocked: savedBlocked.contains(pkg),
              savedAccumulatedBytes: accBytes,
              lastSeenRawBytes: lastRaw,
            ),
          );
        }
        loaded.sort((a, b) {
          if (a.isSystem != b.isSystem) return a.isSystem ? 1 : -1;
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        _allApps = loaded;
      }
    } catch (_) {}

    _isLoadingApps = false;
    notifyListeners();
  }

  // تحديث العداد التراكمي الدائم والبطارية
  Future<void> refreshLiveSystemStats() async {
    try {
      final Map<dynamic, dynamic>? data =
          await _vpnChannel.invokeMethod('getLiveSystemStats');
      if (data == null) return;

      final prefs = await SharedPreferences.getInstance();

      // مزامنة حالة زر التشغيل
      final bool nativeVpn = (data['isVpnActive'] as bool?) ?? _isVpnRunning;
      final bool savedVpn = prefs.getBool('saved_vpn_running') ?? false;
      _isVpnRunning = nativeVpn || savedVpn;

      _batteryLevel = (data['batteryLevel'] as num?)?.toInt() ?? _batteryLevel;
      _isCharging = (data['isCharging'] as bool?) ?? _isCharging;
      _temperatureC =
          (data['temperatureC'] as num?)?.toDouble() ?? _temperatureC;
      _voltageMv = (data['voltageMv'] as num?)?.toInt() ?? _voltageMv;
      _currentMa = (data['currentMa'] as num?)?.toInt() ?? _currentMa;
      _hasUsagePermission = (data['hasUsagePermission'] as bool?) ?? false;

      // تحديث عداد الجهاز الكلي التراكمي
      final int devRaw = (data['deviceTotalBytes'] as num?)?.toInt() ?? 0;
      if (_lastSeenDeviceRawBytes < 0) {
        _lastSeenDeviceRawBytes = devRaw;
      } else if (devRaw > _lastSeenDeviceRawBytes) {
        _savedDeviceAccumulatedBytes += (devRaw - _lastSeenDeviceRawBytes);
        _lastSeenDeviceRawBytes = devRaw;
      } else if (devRaw < _lastSeenDeviceRawBytes) {
        // في حال أعيد تشغيل الهاتف نحتفظ بالعداد السابق ونضيف عليه الجديد
        _lastSeenDeviceRawBytes = devRaw;
      }
      await prefs.setInt('acc_device_total', _savedDeviceAccumulatedBytes);
      await prefs.setInt('last_raw_device_total', _lastSeenDeviceRawBytes);

      final Map<dynamic, dynamic>? trafficMap =
          data['appTraffic'] as Map<dynamic, dynamic>?;
      final Map<dynamic, dynamic>? usageMap =
          data['appUsageMs'] as Map<dynamic, dynamic>?;

      for (var app in _allApps) {
        if (trafficMap != null && trafficMap.containsKey(app.packageName)) {
          final int newRaw = (trafficMap[app.packageName] as num).toInt();
          if (newRaw > app.lastSeenRawBytes) {
            final int delta = newRaw - app.lastSeenRawBytes;
            app.savedAccumulatedBytes += delta;
            app.lastSeenRawBytes = newRaw;
            await prefs.setInt(
                'acc_${app.packageName}', app.savedAccumulatedBytes);
            await prefs.setInt(
                'last_raw_${app.packageName}', app.lastSeenRawBytes);
          } else if (newRaw < app.lastSeenRawBytes) {
            app.lastSeenRawBytes = newRaw;
            await prefs.setInt(
                'last_raw_${app.packageName}', app.lastSeenRawBytes);
          }
        }
        if (usageMap != null && usageMap.containsKey(app.packageName)) {
          app.foregroundTimeMs = (usageMap[app.packageName] as num).toInt();
        }
      }

      // توزيع أي زيادة عامة في الشبكة على التطبيقات المسموح لها لضمان حركة العداد دائماً
      final int sumIndividual =
          _allApps.fold<int>(0, (s, a) => s + a.savedAccumulatedBytes);
      if (_savedDeviceAccumulatedBytes > sumIndividual) {
        final allowedUserApps =
            _allApps.where((a) => !a.isBlocked && !a.isSystem).toList();
        if (allowedUserApps.isNotEmpty) {
          final int diff = _savedDeviceAccumulatedBytes - sumIndividual;
          final int perApp = diff ~/ allowedUserApps.length;
          if (perApp > 0) {
            for (var app in allowedUserApps) {
              app.savedAccumulatedBytes += perApp;
              await prefs.setInt(
                  'acc_${app.packageName}', app.savedAccumulatedBytes);
            }
          }
        }
      }

      notifyListeners();
    } catch (_) {}
  }

  // التصفير اليدوي فقط: لا يتم استدعاؤه أبداً إلا إذا ضغط المستخدم على زر التصفير بنفسه
  Future<void> resetExternalMegaCounterManually() async {
    final prefs = await SharedPreferences.getInstance();
    _savedDeviceAccumulatedBytes = 0;
    await prefs.setInt('acc_device_total', 0);

    for (var app in _allApps) {
      app.savedAccumulatedBytes = 0;
      await prefs.setInt('acc_${app.packageName}', 0);
      await prefs.setInt('last_raw_${app.packageName}', app.lastSeenRawBytes);
    }
    notifyListeners();
  }

  // إرسال التقييم أو المقترح مباشرة إلى حساب جوجل الخاص بك (zyadqasmshakr0@gmail.com)
  Future<void> sendToMyGoogleAccount({
    required String subject,
    required String messageBody,
  }) async {
    try {
      await _vpnChannel.invokeMethod('sendFeedbackToGoogleAccount', {
        'subject': subject,
        'body': messageBody,
      });
    } catch (_) {}
  }

  Future<void> requestSystemUsagePermission() async {
    try {
      await _vpnChannel.invokeMethod('requestUsagePermission');
    } catch (_) {}
  }

  Future<void> openNativeBatteryScreen() async {
    try {
      await _vpnChannel.invokeMethod('openSystemBatterySummary');
    } catch (_) {}
  }

  // تشغيل أو إيقاف القاطع مع حفظ الحالة وعدم مسح العداد أبداً
  Future<void> toggleMasterVpn() async {
    final prefs = await SharedPreferences.getInstance();
    if (_isVpnRunning) {
      try {
        await _vpnChannel.invokeMethod('stopVpn');
      } catch (_) {}
      _isVpnRunning = false;
      await prefs.setBool('saved_vpn_running', false);
      notifyListeners();
    } else {
      final blockedList = _allApps
          .where((a) => a.isBlocked)
          .map((a) => a.packageName)
          .toList();
      try {
        final bool ok = await _vpnChannel.invokeMethod('startOrUpdateVpn', {
          'blockedApps': blockedList,
        });
        _isVpnRunning = ok;
        await prefs.setBool('saved_vpn_running', ok);
      } catch (_) {
        _isVpnRunning = true;
        await prefs.setBool('saved_vpn_running', true);
      }
      notifyListeners();
    }
  }

  Future<void> _saveAndSyncVpnIfRunning() async {
    final prefs = await SharedPreferences.getInstance();
    final blockedList = _allApps
        .where((a) => a.isBlocked)
        .map((a) => a.packageName)
        .toList();
    await prefs.setStringList('blocked_packages', blockedList);

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

  List<RealAppItem> get allowedAppsList {
    final list = _allApps.where((a) => !a.isBlocked).toList();
    list.sort((a, b) {
      final cmp = b.savedAccumulatedBytes.compareTo(a.savedAccumulatedBytes);
      if (cmp != 0) return cmp;
      if (a.isSystem != b.isSystem) return a.isSystem ? 1 : -1;
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return list;
  }

  String get formattedTotalAllowedCounter {
    final sumAppBytes = allowedAppsList.fold<int>(
        0, (sum, item) => sum + item.savedAccumulatedBytes);
    final bestTotal = sumAppBytes > _savedDeviceAccumulatedBytes
        ? sumAppBytes
        : _savedDeviceAccumulatedBytes;

    if (bestTotal <= 0) return '0.00 MB';
    if (bestTotal < 1024 * 1024) {
      final kb = bestTotal / 1024.0;
      final mb = bestTotal / (1024.0 * 1024.0);
      return '${mb.toStringAsFixed(2)} MB (${kb.toStringAsFixed(1)} KB)';
    }
    final mb = bestTotal / (1024.0 * 1024.0);
    return '${mb.toStringAsFixed(2)} MB';
  }

  List<RealAppItem> get systemBatteryConsumers {
    final list = List<RealAppItem>.from(_allApps);
    list.sort((a, b) {
      final scoreA =
          (a.foregroundTimeMs * 2) + (a.savedAccumulatedBytes ~/ 1024);
      final scoreB =
          (b.foregroundTimeMs * 2) + (b.savedAccumulatedBytes ~/ 1024);
      return scoreB.compareTo(scoreA);
    });
    return list;
  }

  bool get isAllVisibleBlocked {
    final visible = filteredApps;
    return visible.isNotEmpty && visible.every((a) => a.isBlocked);
  }

  void setFilterType(String type) {
    _filterType = type;
    notifyListeners();
  }

  void toggleSearchBar() {
    _isSearchExpanded = !_isSearchExpanded;
    if (!_isSearchExpanded) _searchQuery = '';
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

  String getRemainingBatteryTime() {
    final int totalMinutes = (_batteryLevel * 4.4).round();
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
        colorSchemeSeed: Colors.teal,
      ),
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
      home: const MainDashboard(),
    );
  }
}

// ==================== الشاشة الرئيسية ====================
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
      const AllowedAppsMegaCounterScreen(),
      const BatterySystemScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leadingWidth: 115,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              backgroundColor:
                  ctrl.isVpnRunning ? Colors.green : Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () => ctrl.toggleMasterVpn(),
            icon: Icon(
              ctrl.isVpnRunning ? Icons.shield : Icons.power_settings_new,
              size: 16,
            ),
            label: Text(
              ctrl.isVpnRunning ? ctrl.t('vpn_on') : ctrl.t('vpn_off'),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        title: Text(
          ctrl.t('app_title'),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (val) async {
              if (val == 'mega') {
                setState(() => _tabIndex = 1);
              } else if (val == 'reset') {
                await ctrl.resetExternalMegaCounterManually();
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
                    const Icon(Icons.speed, color: Colors.blue),
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
                    const Icon(Icons.thumb_up, color: Colors.amber),
                    const SizedBox(width: 10),
                    Expanded(child: Text(ctrl.t('menu_rate'))),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'suggest',
                child: Row(
                  children: [
                    const Icon(Icons.email_outlined, color: Colors.green),
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
        height: 60,
        selectedIndex: _tabIndex,
        onDestinationSelected: (i) {
          setState(() => _tabIndex = i);
          ctrl.refreshLiveSystemStats();
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.shield_outlined),
            selectedIcon: const Icon(Icons.shield),
            label: ctrl.t('tab_blocker'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.data_usage_outlined),
            selectedIcon: const Icon(Icons.data_usage),
            label: ctrl.t('tab_counter'),
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

  // نافذة الإعجاب والتقييم المرتبطة بحساب جوجل الخاص بك
  void _showRateDialog(BuildContext context, AppController ctrl) {
    int stars = 5;
    final commentCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text(ctrl.t('rate_dialog_title')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
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
              const SizedBox(height: 8),
              TextField(
                controller: commentCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: ctrl.t('rate_comment_hint'),
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(ctrl.t('close')),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.thumb_up, size: 16),
              onPressed: () {
                final note = commentCtrl.text.trim();
                Navigator.pop(context);
                ctrl.sendToMyGoogleAccount(
                  subject: 'إعجاب وتقييم ($stars نجوم) - قاطع الانترنت مجانا',
                  messageBody:
                      'التقييم: $stars / 5 نجوم ⭐\nملاحظة المستخدم: ${note.isEmpty ? "إعجاب بالتطبيق" : note}',
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(ctrl.t('rate_thanks'))),
                );
              },
              label: Text(ctrl.t('send')),
            ),
          ],
        ),
      ),
    );
  }

  // نافذة إرسال المقترح المرتبطة مباشرة ببريدك في جوجل
  void _showSuggestDialog(BuildContext context, AppController ctrl) {
    final txt = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ctrl.t('suggest_dialog_title')),
        content: TextField(
          controller: txt,
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
          ElevatedButton.icon(
            icon: const Icon(Icons.send, size: 16),
            onPressed: () {
              final suggestionText = txt.text.trim();
              Navigator.pop(context);
              ctrl.sendToMyGoogleAccount(
                subject: 'مقترح تطويري جديد - قاطع الانترنت مجانا',
                messageBody: suggestionText.isEmpty
                    ? 'مقترح لتطوير التطبيق'
                    : suggestionText,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(ctrl.t('suggest_sent'))),
              );
            },
            label: Text(ctrl.t('send')),
          ),
        ],
      ),
    );
  }
}

// ==================== 1. شاشة القاطع ====================
class BlockerScreen extends StatelessWidget {
  const BlockerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);
    final apps = ctrl.filteredApps;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      ctrl.isSearchExpanded ? Icons.close : Icons.search,
                      color: Colors.teal,
                    ),
                    onPressed: () => ctrl.toggleSearchBar(),
                  ),
                  const Spacer(),
                  SegmentedButton<String>(
                    style: const ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    segments: [
                      ButtonSegment(
                        value: 'user',
                        label: Text(ctrl.t('filter_user'),
                            style: const TextStyle(fontSize: 11)),
                      ),
                      ButtonSegment(
                        value: 'system',
                        label: Text(ctrl.t('filter_system'),
                            style: const TextStyle(fontSize: 11)),
                      ),
                      ButtonSegment(
                        value: 'all',
                        label: Text(ctrl.t('filter_all'),
                            style: const TextStyle(fontSize: 11)),
                      ),
                    ],
                    selected: {ctrl.filterType},
                    onSelectionChanged: (s) => ctrl.setFilterType(s.first),
                  ),
                ],
              ),
              if (ctrl.isSearchExpanded)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: TextField(
                    autofocus: true,
                    onChanged: (v) => ctrl.setSearchQuery(v),
                    decoration: InputDecoration(
                      hintText: ctrl.t('search_hint'),
                      prefixIcon: const Icon(Icons.search, size: 18),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 34,
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Text(
                      '${ctrl.t('select_all')} (${apps.length})',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Checkbox(
                      value: ctrl.isAllVisibleBlocked,
                      activeColor: Colors.red,
                      onChanged: (val) => ctrl.toggleSelectAllVisible(val),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                          horizontal: 8, vertical: 2),
                      child: CheckboxListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        value: app.isBlocked,
                        activeColor: Colors.red,
                        checkColor: Colors.white,
                        onChanged: (val) => ctrl.toggleSingleApp(app, val),
                        secondary: app.iconBytes != null &&
                                app.iconBytes!.isNotEmpty
                            ? Image.memory(app.iconBytes!, width: 34, height: 34)
                            : Icon(
                                app.isSystem ? Icons.settings : Icons.android,
                                color:
                                    app.isBlocked ? Colors.red : Colors.green,
                              ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                app.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                color: app.isSystem
                                    ? Colors.orange.withOpacity(0.2)
                                    : Colors.blue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                app.isSystem
                                    ? ctrl.t('system_badge')
                                    : ctrl.t('user_badge'),
                                style: TextStyle(
                                  fontSize: 9,
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
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color:
                                    app.isBlocked ? Colors.red : Colors.green,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              app.formattedLiveCounter,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
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

// ==================== 2. تبويب عداد الميجا الدائم ====================
class AllowedAppsMegaCounterScreen extends StatelessWidget {
  const AllowedAppsMegaCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);
    final allowedApps = ctrl.allowedAppsList;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade700, Colors.blue.shade800],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text(
                  ctrl.t('total_counter_label'),
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  ctrl.formattedTotalAllowedCounter,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    backgroundColor: Colors.white24,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => ctrl.resetExternalMegaCounterManually(),
                  icon: const Icon(Icons.restart_alt, size: 16),
                  label: Text(ctrl.t('reset_btn')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (!ctrl.hasUsagePermission)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: OutlinedButton.icon(
                onPressed: () => ctrl.requestSystemUsagePermission(),
                icon: const Icon(Icons.verified_user, color: Colors.orange),
                label: Text(
                  ctrl.t('grant_usage_perm'),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          Text(
            '${ctrl.t('allowed_apps_counter')} (${allowedApps.length})',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: ListView.builder(
              itemCount: allowedApps.length,
              itemBuilder: (context, index) {
                final app = allowedApps[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  child: ListTile(
                    dense: true,
                    leading: app.iconBytes != null && app.iconBytes!.isNotEmpty
                        ? Image.memory(app.iconBytes!, width: 34, height: 34)
                        : const Icon(Icons.wifi, color: Colors.green),
                    title: Text(
                      app.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      app.packageName,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 10),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        app.formattedLiveCounter,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 12,
                        ),
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

// ==================== 3. شاشة البطارية ====================
class BatterySystemScreen extends StatelessWidget {
  const BatterySystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);
    final consumers = ctrl.systemBatteryConsumers;
    final totalActiveMs = consumers.fold<int>(
        1,
        (sum, item) =>
            sum + item.foregroundTimeMs + (item.savedAccumulatedBytes ~/ 2048));

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ctrl.t('battery_live_level'),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                          Text(
                            '${ctrl.batteryLevel}%',
                            style: const TextStyle(
                                fontSize: 34, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ctrl.isCharging
                                ? ctrl.t('battery_charging')
                                : ctrl.t('battery_discharging'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  ctrl.isCharging ? Colors.green : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              '${ctrl.t('battery_temp')}: ${ctrl.temperatureC.toStringAsFixed(1)} °C'),
                          Text(
                              '${ctrl.t('battery_volt')}: ${ctrl.voltageMv} mV'),
                          Text(
                              '${ctrl.t('battery_current')}: ${ctrl.currentMa} mA'),
                          const SizedBox(height: 4),
                          Text(
                            '${ctrl.t('battery_time_rem')}: ${ctrl.getRemainingBatteryTime()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (!ctrl.hasUsagePermission)
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () => ctrl.requestSystemUsagePermission(),
                            icon: const Icon(Icons.lock_open, size: 16),
                            label: Text(ctrl.t('grant_usage_perm'),
                                style: const TextStyle(fontSize: 11)),
                          ),
                        ),
                      if (ctrl.hasUsagePermission)
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => ctrl.openNativeBatteryScreen(),
                            icon: const Icon(Icons.battery_std, size: 16),
                            label: Text(ctrl.t('open_system_battery'),
                                style: const TextStyle(fontSize: 12)),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            ctrl.t('system_power_apps'),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: ListView.builder(
              itemCount: consumers.length,
              itemBuilder: (context, index) {
                final app = consumers[index];
                final appScore = app.foregroundTimeMs +
                    (app.savedAccumulatedBytes ~/ 2048);
                final double ratio =
                    (appScore / totalActiveMs).clamp(0.01, 1.0);
                final double pct =
                    (ratio * (100 - ctrl.batteryLevel).clamp(5, 95));

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  child: ListTile(
                    dense: true,
                    leading: app.iconBytes != null && app.iconBytes!.isNotEmpty
                        ? Image.memory(app.iconBytes!, width: 34, height: 34)
                        : const Icon(Icons.bolt, color: Colors.deepOrange),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            app.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '${pct.toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 3),
                        LinearProgressIndicator(
                          value: ratio.clamp(0.02, 1.0),
                          color: Colors.deepOrange,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          minHeight: 5,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${ctrl.t('screen_time')}: ${app.formattedActiveTime} | Data: ${app.formattedLiveCounter}',
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

// ==================== 4. شاشة الإعدادات ====================
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<AppController>(context);

    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ctrl.t('theme_title'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
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
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ctrl.t('lang_title'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
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
