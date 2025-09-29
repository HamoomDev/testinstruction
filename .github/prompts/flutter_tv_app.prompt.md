# 📺 Flutter TV App Development Prompt

## 🎯 Project Overview
สร้างแอปพลิเคชัน Flutter สำหรับ Android TV ที่ทำหน้าที่เป็นตัวรับและแสดงผลเนื้อหาจากระบบเว็บ โดยมีคุณสมบัติดังนี้:

### ✨ Core Features
- **เชื่อมต่อกับระบบกลาง**: ผ่านอินเทอร์เน็ตหรือ Wi-Fi
- **ดาวน์โหลดเนื้อหาอัตโนมัติ**: เพื่อแสดงแม้ไม่มีอินเทอร์เน็ต (Offline Mode)
- **แสดงผลแบบ Fullscreen**: โดยไม่มี UI รบกวน
- **รองรับการตั้งค่าอัตโนมัติ**: เปิดเครื่องแล้วเริ่มแสดงทันที
- **ตรวจสอบการ Login**: เมื่อเปิดแอปครั้งแรก เพื่อดึง config และ Presentation
- **WebSocket Communication**: สื่อสารกับระบบหลังบ้านเพื่อรับการอัปเดตเนื้อหาแบบเรียลไทม์
- **OTA Updates**: การอัปเดตแอปผ่าน Over-the-Air เพื่อเพิ่มฟีเจอร์หรือแก้ไขบั๊ก
### TV-Specific Constraints
- **Remote-First Design**: All interactions must work with TV remote controls
- **Fullscreen Priority**: Content should always be displayed in fullscreen mode
- **Auto-Operation**: System should work without user intervention once configured
- **Offline Capability**: Core functionality must work without internet connection
### 🏗️ Tech Stack
- **Framework**: Flutter + Dart
- **Platform**: Android TV
- **Architecture**: Clean Architecture + GetX
- **Communication**: REST API + WebSocket
- **Storage**: Local caching สำหรับ offline support

---

## 🛠️ Development Guidelines

### 1. 📱 Fullscreen Display
```dart
// ใช้ SystemChrome เพื่อซ่อน UI ทั้งหมด
SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

// ปรับ layout ให้รองรับความละเอียด 1080p/4K
```

### 2. 🌐 การเชื่อมต่อระบบกลาง
- **HTTP Client**: ใช้ `dio` สำหรับ REST API calls
- **Local Storage**: ใช้ `hive` หรือ `shared_preferences` สำหรับเก็บ config และเนื้อหาแบบ offline
- **Caching Strategy**: Implement cache-first approach สำหรับ offline support

### 3. 🔐 การตรวจสอบ Login
- เมื่อเปิดแอปครั้งแรก ให้เรียก API ตรวจสอบ token หรือแสดงหน้าจอ login
- หลัง login สำเร็จ ดึง config และ presentation มาเก็บไว้ใน local storage
- Auto-refresh token mechanism

### 4. 🔌 WebSocket Implementation
```dart
// ใช้ web_socket_channel หรือ socket_io_client
dependencies:
  web_socket_channel: ^2.4.0
  # หรือ
  socket_io_client: ^2.0.0
```
- เมื่อมีการอัปเดตเนื้อหา ให้ trigger การโหลดใหม่ทันที
- Handle connection errors และ reconnection logic

### 5. 📦 OTA Updates
**Option 1**: Google Play หรือ Firebase App Distribution
**Option 2**: Custom content update จาก backend
- โหลดเนื้อหาใหม่จาก server แล้วแสดงผลโดยไม่ต้องอัปเดตแอป
- Version checking และ automatic download

### 6. 🚀 Auto-Start Configuration
```xml
<!-- AndroidManifest.xml -->
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTop"
    android:theme="@style/LaunchTheme">
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
        <category android:name="android.intent.category.LEANBACK_LAUNCHER" />
    </intent-filter>
</activity>

<!-- Boot receiver -->
<receiver android:name=".BootReceiver" android:enabled="true" android:exported="true">
    <intent-filter android:priority="1000">
        <action android:name="android.intent.action.BOOT_COMPLETED" />
    </intent-filter>
</receiver>
```

---

## 🏛️ Project Architecture

### 📁 Folder Structure
```
lib/
├── app/
│   ├── env/                    # Environment configs
│   ├── routes/                 # App routes
│   └── injection.dart          # DI setup
├── core/
│   ├── network/                # Dio + interceptors
│   ├── storage/                # Hive/SharedPrefs
│   ├── services/               # WebSocket, Auth, Content services
│   └── constants/              # TV-specific constants
├── features/
│   ├── auth/                   # Login/Authentication
│   ├── content/                # Content management
│   ├── display/                # Fullscreen display
│   └── settings/               # App settings
└── shared/
    └── widgets/                # Reusable TV widgets
```

### 🔧 Core Services Structure
```dart
// core/services/
├── auth_service.dart           # Authentication & token management
├── content_service.dart        # Content download & caching
├── websocket_service.dart      # Real-time communication
├── display_service.dart        # Fullscreen & TV display
└── update_service.dart         # OTA updates
```

### 📋 Feature Implementation Priority
1. **Auth Feature**: Login, token management, device registration
2. **Content Feature**: Download, cache, offline storage
3. **Display Feature**: Fullscreen presentation, TV-optimized UI
4. **WebSocket Feature**: Real-time content updates
5. **Settings Feature**: Configuration, auto-start, updates

---

## 📦 Required Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management & DI
  get: ^4.6.5
  get_it: ^7.6.0
  
  # Network & Communication
  dio: ^5.4.0
  web_socket_channel: ^2.4.0
  
  # Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  shared_preferences: ^2.2.2
  
  # System Integration
  android_intent_plus: ^4.0.3
  device_info_plus: ^9.1.0
  
  # Utilities
  path_provider: ^2.1.1
  connectivity_plus: ^5.0.2

dev_dependencies:
  build_runner: ^2.4.7
  hive_generator: ^2.0.1
```

---

## 🎮 Android TV Specific Considerations

### 📺 TV Layout Guidelines
- **Safe Area**: รองรับ overscan ของทีวี
- **Focus Management**: ใช้ `FocusNode` สำหรับการนำทางด้วยรีโมท
- **Large Screen Layout**: ปรับ UI ให้เหมาะกับหน้าจอใหญ่
- **Remote Control**: รองรับการควบคุมด้วยรีโมท Android TV

### 🔧 Performance Optimization
- **Memory Management**: จัดการหน่วยความจำให้เหมาะสม
- **Image Optimization**: ใช้ cached images สำหรับเนื้อหาที่ใช้บ่อย
- **Background Processing**: ดาวน์โหลดเนื้อหาในพื้นหลัง

### 📱 Platform Integration
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-feature
    android:name="android.software.leanback"
    android:required="true" />
<uses-feature
    android:name="android.hardware.touchscreen"
    android:required="false" />
```

---

## ✅ Development Checklist

### Phase 1: Foundation
- [ ] Setup Flutter project with TV support
- [ ] Implement Clean Architecture structure
- [ ] Setup GetX state management
- [ ] Configure environment settings

### Phase 2: Core Features
- [ ] Implement authentication system
- [ ] Setup API integration with Dio
- [ ] Create content caching system
- [ ] Implement fullscreen display

### Phase 3: Advanced Features
- [ ] WebSocket real-time communication
- [ ] Offline content management
- [ ] Auto-start configuration
- [ ] OTA update mechanism

### Phase 4: TV Optimization
- [ ] Remote control navigation
- [ ] TV-specific UI/UX
- [ ] Performance optimization
- [ ] Testing on Android TV device

---

## 🚀 Getting Started

1. **Create Flutter TV Project**
```bash
flutter create --org com.yourcompany flutter_tv_app
cd flutter_tv_app
```

2. **Setup Android TV Support**
```bash
# แก้ไข android/app/src/main/AndroidManifest.xml
# เพิ่ม LEANBACK_LAUNCHER category
```

3. **Install Dependencies**
```bash
flutter pub add get dio hive hive_flutter web_socket_channel
flutter pub add --dev build_runner hive_generator
```

4. **Run on Android TV**
```bash
# เชื่อมต่อ Android TV device หรือ emulator
flutter devices
flutter run -d "Android TV"
```

---

## 📚 Additional Resources

- [Android TV Developer Guide](https://developer.android.com/tv)
- [Flutter TV Development](https://docs.flutter.dev/development/platform-integration/android)
- [WebSocket Implementation](https://pub.dev/packages/web_socket_channel)
- [Hive Database](https://pub.dev/packages/hive)

---

**Note**: ตรวจสอบให้แน่ใจว่า Android TV device หรือ emulator รองรับการติดตั้งแอป Flutter และมี Google Play Services พร้อมใช้งาน
