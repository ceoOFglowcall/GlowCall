# GlowCall

GlowCall is a lightweight iOS app that helps users look clearer in low-light video calls by turning the phone screen into a soft light panel.

## Product Vision

- Focus: instant appearance boost for video calls, especially at night.
- Promise: better on-camera look in seconds, without extra hardware.
- Principle: practical, simple, one-tap UX.

## Core Experience

1. Pick a light tone.
2. Adjust brightness.
3. Start call and tap `Activate Light`.

## Positioning Pack

### App Store Short Description

Look better on video calls in 10 seconds.

### App Store Long Description

GlowCall turns your screen into a soft light panel so your face looks clearer in low-light calls.  
Choose a tone, set brightness, and activate with one tap during FaceTime, WhatsApp, or Instagram calls.

Built for practical daily use:
- Fast setup and simple controls
- Timer for auto-off
- Eye-protection mode
- Pro options for advanced warmth and premium presets

### Messaging Notes

- Avoid "brightness app" framing.
- Emphasize call quality and confidence on camera.
- Keep onboarding focused on quick value.

## Project Structure

- `GlowCall/` main iOS app (SwiftUI)
- `GlowCallWidget/` widget + control intent
- `GlowCall.xcodeproj/` Xcode project

## Build

Open `GlowCall.xcodeproj` in Xcode and run the `GlowCall` scheme.

## Verification

Run the repository verification script:

```bash
zsh ./verify.sh
```

If simulator/runtime names differ on your machine, adjust the destination inside the script.
