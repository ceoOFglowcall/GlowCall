# GlowCall Minimum Test Plan

This plan covers critical state behavior and core user flows.

## State & Persistence

1. **Onboarding persistence**
   - Fresh install: onboarding appears.
   - Tap start.
   - Relaunch app.
   - Expect onboarding hidden.

2. **Brightness reset on relaunch**
   - Set brightness to a custom value (e.g. 67%).
   - Close and relaunch app.
   - Expect brightness to return to app default.

3. **Eye mode reset on relaunch**
   - Toggle eye protection on.
   - Close and relaunch app.
   - Expect eye mode off by default.

4. **Preset index safety**
   - Manually set an invalid `gc_preset` value in defaults (debug/tools).
   - Relaunch app.
   - Expect fallback to default preset without crash.

## Core Flows

1. **Activate/deactivate flow**
   - Tap `Activate Light`.
   - Verify flash screen opens.
   - Double tap to close.
   - Verify return to home.

2. **Timer flow**
   - Select 15 min.
   - Activate light.
   - Verify countdown starts and updates.
   - Stop manually and verify timer resets to 0.

3. **Low battery sheet flow**
   - Simulate battery <= 20% and not charging.
   - Activate light with brightness > 60.
   - Verify battery sheet appears.
   - Tap reduce brightness and verify current screen brightness reduces.

4. **Widget sync flow**
   - Toggle GlowCall from widget/control.
   - Open app.
   - Verify `isFlashActive` reflects widget state.
   - Toggle off from widget and re-open app.
   - Verify state is off.

## StoreKit & Pricing

1. **Localized price display**
   - Use a tester account with a non-TRY storefront.
   - Open premium sheet.
   - Verify monthly/yearly prices use local currency from App Store.

2. **Purchase flow**
   - Tap a plan and complete purchase in sandbox.
   - Verify Pro-locked controls become available.
   - Relaunch app and verify entitlement still grants Pro.

3. **Restore flow**
   - On another device / fresh install, tap restore.
   - Verify prior purchases are restored and Pro unlocks.

## Regression Notes

- Check language switch (TR/EN/DE) still updates visible copy.
- Confirm premium sheet opens from locked features.
