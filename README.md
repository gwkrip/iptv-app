# MyIPTV - Flutter IPTV Player App

Aplikasi IPTV lengkap dengan tampilan modern dan gelap, dibangun dengan Flutter.

## 📱 Fitur

- **Player Video**: Memutar stream HLS/M3U8 menggunakan `video_player` + `chewie`
- **Channel List**: Daftar lengkap channel TV Indonesia & Internasional
- **Kategori Filter**: Filter channel berdasarkan grup (Indonesia, Internasional, Olahraga, dll)
- **Favorit**: Tandai channel favorit yang tersimpan secara lokal
- **Pencarian**: Cari channel dengan mudah
- **Splash Screen**: Animasi splash screen yang elegan
- **Featured Banner**: Banner channel populer di halaman utama
- **Dark UI**: Tema gelap modern dengan aksen ungu

## 📦 Dependensi

```yaml
video_player: ^2.8.3
chewie: ^1.7.5
cached_network_image: ^3.3.1
http: ^1.2.0
provider: ^6.1.2
shared_preferences: ^2.2.2
shimmer: ^3.0.0
```

## 🚀 Cara Menjalankan

1. **Pastikan Flutter terinstall** (Flutter 3.x atau lebih baru)

2. **Clone / Extract project ini**

3. **Install dependensi:**
   ```bash
   flutter pub get
   ```

4. **Buat folder assets:**
   ```bash
   mkdir -p assets/images
   ```

5. **Jalankan di emulator/device:**
   ```bash
   flutter run
   ```

## 📁 Struktur Project

```
lib/
├── main.dart               # Entry point + Splash Screen
├── models/
│   └── channel.dart        # Model data Channel
├── data/
│   ├── playlist.dart       # Data playlist channel
│   └── channel_provider.dart # State management
├── screens/
│   ├── home_screen.dart    # Halaman utama (3 tab)
│   └── player_screen.dart  # Halaman player video
├── widgets/
│   ├── channel_card.dart   # Card item channel
│   └── group_filter_chips.dart # Filter kategori
└── utils/
    └── app_theme.dart      # Konfigurasi tema
```

## ➕ Menambah Channel

Edit file `lib/data/playlist.dart` dan tambahkan channel baru:

```dart
Channel(
  name: 'NAMA CHANNEL',
  url: 'https://url-stream.m3u8',
  logoUrl: 'https://url-logo.png',
  group: 'NAMA GRUP',
),
```

## 📺 Channel yang Tersedia

### 🇮🇩 Indonesia
- TVRI Sport HD, TVRI Nasional, TVRI World
- Metro TV, CNN Indonesia, Kompas TV, iNews TV
- SCTV, RCTI, GTV, MNC TV
- Trans TV, Trans7, TV One, Indosiar, ANTV, RTV

### 🌍 Internasional
- CNN International, BBC World News, Al Jazeera English
- DW English, France 24, NHK World, RT English, Euronews

### ⚽ Olahraga
- beIN Sports 1, TVRI Sport HD

### 👶 Anak-anak
- Boomerang, Nickelodeon

### 🕌 Religi
- TV9 Nusantara, Rodja TV

## ⚠️ Catatan

- Beberapa stream mungkin tidak aktif karena URL berubah-ubah
- Pastikan perangkat terhubung ke internet
- Untuk Android, `usesCleartextTraffic="true"` sudah diaktifkan di AndroidManifest
- Untuk iOS, tambahkan `NSAppTransportSecurity` di Info.plist jika diperlukan

## 🎨 Tema

Aplikasi menggunakan tema gelap elegan dengan:
- Background: `#0A0A0F`
- Primary (Ungu): `#6C63FF`
- Accent (Pink): `#FF6B9D`
- Live Badge: `#FF4757`
