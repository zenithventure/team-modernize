---
name: mobile-development
description: Build a React Native mobile companion app using Expo that shares the same Supabase backend as the web app.
requirements:
  - Node.js installed
  - Expo Go app on physical device (iOS or Android)
  - Supabase credentials (same as web app)
---

# Mobile Development Skill

Create a mobile app that shares the same backend as your web application. One database, two frontends.

## Tech Stack

- **React Native** — cross-platform mobile framework
- **Expo** — development toolchain and runtime for React Native
- **TypeScript** — type-safe JavaScript
- **Expo Go** — app on your phone for previewing during development
- **Supabase** — same backend as the web app

## Setup

### 1. Create Mobile App
Ask Claude Code to generate a React Native mobile app:
```
Claude, please create a React Native mobile app using Expo based on
our existing web app specs. Place it in a /mobile folder.
```

### 2. Install Dependencies
```bash
cd mobile && npm install
```

### 3. Install Expo Go on Phone
- iOS: Download "Expo Go" from App Store
- Android: Download "Expo Go" from Google Play

### 4. Start Development Server
```bash
npx expo start
```
Scan the QR code with Expo Go on your phone.

## Connecting to Supabase

The mobile app uses the **same Supabase credentials** as the web app:

```
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGci...
```

Create a `.env` file in the `/mobile` folder with these values.

### Shared Database
- Data created in the web app appears in the mobile app
- Data created in the mobile app appears in the web app
- Both use the same authentication system
- Same RLS policies apply to both

## SDK Version Management

- Expo Go requires matching SDK versions
- Check your Expo Go app version and match the SDK in `app.json`
- Avoid beta SDK versions — stick with stable releases
- Upgrade/downgrade with: `npx expo install expo@sdk-XX`

## Development Tips

- **Hot reload** — changes appear on phone instantly
- **Console logs** — visible in the terminal where `npx expo start` is running
- **Debugging** — shake phone to open Expo debug menu
- **Simulators** — Xcode (iOS) or Android Studio (Android) for emulator testing

## Common Issues

| Problem | Fix |
|---------|-----|
| QR code not scanning | Ensure phone and computer are on same WiFi network |
| SDK version mismatch | Match Expo Go version with SDK version in app.json |
| Xcode not installed | Install from Mac App Store (for iOS simulator only) |
| npm permission errors | Fix npm cache ownership or use `npx` |

## Environment Targeting

- **Development:** Point to Supabase branch database for safe testing
- **Production:** Point to Supabase production database
- Use separate `.env` files: `.env.dev` and `.env.prod`
