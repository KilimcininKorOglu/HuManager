# HuManager

Native macOS application for managing Huawei HiLink mobile modems. Built with SwiftUI, targeting macOS 14+ (Sonoma).

## Features

- **Dashboard** -- Overview cards showing signal quality, network info, traffic stats, and device status
- **Signal Monitoring** -- Live RSRP/RSRQ/SINR/RSSI polling with Swift Charts history graphs, 5G NR metrics support
- **Band Locking** -- Toggle-grid interface for 33 LTE and 13 NR bands with bitmask calculation, preset support
- **SMS Management** -- Inbox with unread indicators, compose form, delete, and mark-as-read
- **Traffic Statistics** -- Session/total/monthly data usage with live rate polling
- **WiFi Settings** -- SSID, security config, and connected devices table
- **Device Control** -- IMEI/serial/firmware display, reboot control

## Supported Devices

Compatible with all Huawei HiLink modems (4G and 5G):

| Type       | Example Models          | Auth Method           |
|------------|-------------------------|-----------------------|
| 5G CPE     | H153-381, H155-381      | SCRAM (WebUI v10)     |
| 4G CPE     | B535, B618              | SHA256 (WebUI v17/21) |
| MiFi       | E5787, E5885            | SCRAM (WebUI v10)     |
| Wingle     | E8372                   | SHA256 (WebUI v17)    |

WebUI version is detected automatically at connection time.

## Requirements

- macOS 14.0 (Sonoma) or later
- Xcode 16.0 or later
- [xcodegen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`)

No third-party Swift dependencies.

## Build

```bash
git clone <repo-url>
cd huawei

# Generate Xcode project (project.yml is at repo root)
xcodegen generate

# Build from command line
xcodebuild -scheme HuManager -destination 'platform=macOS' build

# Or open in Xcode
open HuManager.xcodeproj
```

## Usage

1. Launch HuManager
2. Enter modem IP address (default: `192.168.8.1`), username (`admin`), and password
3. Click Connect -- the app auto-detects WebUI version and authenticates
4. Navigate features via the sidebar

## Architecture

```
HuManager/
  Core/
    Auth/         Authentication (SHA256 + SCRAM), WebUI version detection
    Models/       Data models parsed from modem XML responses
    Networking/   HTTP client, session/token management, XML parser
    Utilities/    Band mask calculation, signal quality mapping, formatters
  Services/       Domain API wrappers (Device, Band, SMS, WiFi, Polling)
  ViewModels/     @Observable state management per feature
  Views/          SwiftUI interface organized by feature
```

### Modem API

The application communicates with the modem via its local HTTP XML API:

- All requests/responses use XML format
- CSRF protection via `__RequestVerificationToken` header
- Session maintained via `SessionID` cookie
- Token rotation: modem returns new tokens in response headers after each request

### Authentication Flow

```
GET /                          Establish SessionID cookie
GET /api/webserver/token       Detect WebUI version, extract CSRF token
GET /api/user/state-login      Get password_type
POST /api/user/login           SHA256 auth (v17/v21)
  -- or --
POST /api/user/challenge_login   SCRAM step 1 (v10)
POST /api/user/authentication_login  SCRAM step 2 (v10)
GET /api/webserver/SesTokInfo   Refresh session tokens
```

## Tests

```bash
xcodebuild -scheme HuManagerTests -destination 'platform=macOS' test
```

Tests cover XML parsing, crypto helpers (SHA256, HMAC, PBKDF2, XOR), band mask calculation, and request building.

## License

[MIT](LICENSE)
