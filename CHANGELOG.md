# Changelog

## [0.1.2] - 2026-04-16

### Added
- Menu bar status panel showing signal, network type, and band via MenuBarExtra scene
- Remember Me toggle on login screen to persist credentials across launches

### Changed
- GitHub Actions workflow for build and test on macos-15
- Refresh README with menu bar, remember me, CI section, and Turkish market name (Vodafone Redbox 5G) for H153-381

### Fixed
- Route month statistics through DeviceService to satisfy Swift 6 sendability on CI

## [0.1.1] - 2026-04-16

### Added
- Initial implementation of HuManager application
- WebUI version detection and dual auth support (SHA256 + SCRAM)
- Dashboard with signal monitoring and data models
- Band locking with LTE/NR selection grid
- SMS inbox, compose, and management
- Traffic stats, WiFi settings, and device info views
- Toolbar status indicator and shared error components
- Localization infrastructure with 15 languages (TR, EN, DE, FR, IT, PT, NL, ES, RU, PL, SV, CS, RO, HU, EL)
- Language picker on login screen and toolbar
- System language auto-detection on first launch
- MIT license

### Changed
- Split translations into per-language files
- Standardize all log messages and error strings to English
- Update bundle identifier to com.KilimcininKorOglu
- Update README with localization, corrected band counts, and improved structure

### Fixed
- Session cookie capture and login flow
- Send cookies in SCRAM login and use rotated token
- Portuguese gerund forms (pt-BR to pt-PT) and Dutch casing
