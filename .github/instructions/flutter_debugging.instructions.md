---
applyTo: '**'
---
# 🐛 Flutter Debugging & Platform Issues

## Flutter Web Debug Issues

### ❌ ปัญหาที่พบบ่อย:
1. **DebugService Null Errors**: Flutter Web ใน development mode มักมีปัญหา debug service
2. **Dart Compiler Crashes**: Web compiler exit unexpectedly ใน debug mode
3. **Hot Reload ไม่ทำงาน**: Debug output ไม่แสดงใน web platform
4. **Performance Issues**: Web debug mode ช้ากว่า mobile significantly

### ✅ วิธีแก้ปัญหา Flutter Web:

**1. ใช้ Release Mode สำหรับ Web:**
```bash
flutter run -d chrome --release
flutter build web --release
```

**2. ใช้ HTML Renderer:**
```bash
flutter run -d chrome --web-renderer html
flutter build web --web-renderer html
```

**3. ใช้ Alternative Platform:**
```bash
# ทดสอบบน iOS Simulator
flutter run -d "iPhone 16 Pro Max"

# ทดสอบบน Android Emulator  
flutter run -d "Android"

# ทดสอบบน Desktop
flutter run -d macos
```

**4. Debug Splash Navigation:**
```dart
// ใส่ debug logging ใน SplashController
class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      debugPrint('🚀 SplashController: onInit called');
    }
    _navigateToMainApp();
  }
  
  Future<void> _navigateToMainApp() async {
    try {
      if (kDebugMode) {
        debugPrint('🚀 SplashController: Starting navigation');
      }
      
      await Future.delayed(const Duration(seconds: 2));
      
      if (kDebugMode) {
        debugPrint('🚀 SplashController: Navigating to ${AppRoutes.mainNav}');
      }
      
      Get.offAllNamed(AppRoutes.mainNav);
      
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ SplashController: Error: $e');
      }
      Get.offAllNamed(AppRoutes.mainNav); // Fallback
    }
  }
}
```

## Platform Testing Strategy

### 🎯 Development Order:
1. **Mobile First** (iOS/Android) - เสถียรที่สุด
2. **Desktop** (macOS/Windows/Linux) - เสถียรปานกลาง  
3. **Web** (Chrome/Safari/Firefox) - ใช้ release mode

### 📱 Platform Commands:
```bash
# iOS (แนะนำสำหรับ debug)
flutter run -d "iPhone 16 Pro Max"

# Android
flutter run -d "android"

# macOS Desktop
flutter run -d "macos"

# Web Release (สำหรับ production testing)
flutter run -d chrome --release --web-renderer html
```

## Splash Navigation Best Practices

### ✅ Do:
- ใช้ `debugPrint()` wrapper ด้วย `kDebugMode`
- ใช้ `Future.delayed()` แทน complex async operations
- มี fallback navigation ใน try-catch
- Test บน mobile ก่อน web
- ใช้ `Get.offAllNamed()` แทน `Get.toNamed()` สำหรับ splash

### ❌ Don't:
- อย่าพึ่งพา Flutter Web debug mode เป็นหลัก
- อย่าใช้ complex service initialization ใน splash
- อย่าใช้ `Get.to()` สำหรับ main navigation (memory leak)
- อย่า assume web debug จะทำงานเหมือน mobile

## Instructions Improvements

### setupFlutterWithNavProject.prompt.md ต้องเพิ่ม:

```markdown
## ⚠️ Platform Testing Priority

**Testing Order:**
1. **iOS Simulator First**: `flutter run -d "iPhone Simulator"`
2. **Android Second**: `flutter run -d "android"`  
3. **Web Last (Release)**: `flutter run -d chrome --release`

**Debug Issues:**
- Flutter Web debug mode มีปัญหา DebugService ให้ใช้ release mode
- ถ้า splash ค้าง ให้ test บน mobile ก่อน
- Web debug อาจไม่แสดง debugPrint() ให้ใช้ DevTools

## 🔧 Troubleshooting Splash Navigation

**ถ้าค้างที่ splash:**
1. ✅ Test บน iOS: `flutter run -d "iPhone Simulator"`  
2. ✅ ตรวจสอบ routes ใน `app_routes.dart`
3. ✅ ตรวจสอบ bindings registration
4. ✅ เพิ่ม debug logging ใน controller
5. ❌ อย่าพึ่งพา web debug mode
```

### flutter_default.instructions.md ต้องเพิ่ม:

```markdown
## 🐛 Platform-Specific Considerations

**Flutter Web Limitations:**
- Debug service มี instability ใช้ `--release` สำหรับ testing
- DebugService "Cannot send Null" errors ให้เพิกเฉย
- Hot reload อาจไม่ทำงานให้ใช้ hot restart

**Testing Strategy:**
- Mobile-first development (iOS/Android)
- Desktop secondary testing  
- Web release mode only

**Navigation Debugging:**
- ใช้ `kDebugMode` guard สำหรับ debugPrint
- Test navigation บน mobile ก่อน web
- ใช้ try-catch ใน splash navigation
```
