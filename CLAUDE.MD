# Flutter Learning — Claude Code Reference

## About Me

iOS developer with a CS degree. Experienced with SwiftUI, `@Observable`, and the Apple ecosystem. Installing Flutter for the first time and learning from scratch. Aim: get a solid overview in 2–3 days by building a playground app that evolves with each checkpoint.

**Do not run any commands on my behalf.** I will run everything myself for hands-on learning. Explain what a command does and why before I run it.

---

## My Background Mapping (SwiftUI → Flutter)

| SwiftUI / iOS | Flutter / Dart equivalent |
|---|---|
| `View` protocol | `Widget` (everything is a widget) |
| `struct ContentView: View` | `class MyWidget extends StatelessWidget` |
| `@State` | `setState()` inside `StatefulWidget` |
| `@Observable` / `@ObservedObject` | `ChangeNotifier` + `Provider`, or `Riverpod` |
| `@Environment` | `InheritedWidget` / `Provider.of(context)` |
| `VStack / HStack / ZStack` | `Column / Row / Stack` |
| `NavigationStack` | `Navigator` / `GoRouter` |
| `List` | `ListView` / `ListView.builder` |
| `Sheet` / `.sheet(isPresented:)` | `showModalBottomSheet` / `showDialog` |
| `GeometryReader` | `LayoutBuilder` / `MediaQuery` |
| `Canvas` / `Path` | `CustomPainter` / `Canvas` |
| `TimelineView` | `AnimationController` + `Ticker` |
| `async/await` | `async/await` (Dart has it too, very similar) |
| `Codable` | `fromJson` / `toJson` (manual or `json_serializable`) |
| `UserDefaults` | `shared_preferences` package |
| `URLSession` | `http` package / `dio` |
| Xcode Simulator | Android emulator + iOS Simulator (both via Flutter) |
| `xcodeproj` / SPM | `pubspec.yaml` |

---

## Playground App: "VibeFlutter"

A simple timer/stopwatch app that mirrors VibeTimer's core concepts — familiar domain, new framework. Evolves through checkpoints.

**Final shape:** single-screen app with a count-up stopwatch, a countdown timer, lap recording, and a settings page. Nothing fancy — just enough to touch every major Flutter concept.

---

## 2–3 Day Checklist

Work through these in order. Each checkpoint builds on the last.

### Day 1 — Foundations ✅ DONE (cheat sheet: `notes/day1_cheatsheet.md`)

- [x] **CP1 — Dart basics**
  - Variables, types, `null` safety (`?`, `!`, `??`)
  - Functions, named params (`{required}`)
  - Classes, constructors, `const`
  - `async` / `await` / `Future` / `Stream`
  - *SwiftUI parallel:* Dart is closer to Swift than you'd expect. `const` ≈ compile-time `let`. Named params ≈ Swift argument labels.

- [x] **CP2 — First Flutter app**
  - `flutter create vibe_flutter`
  - Understand `pubspec.yaml` (≈ `Package.swift` + app metadata)
  - Understand `lib/main.dart` entry point — `runApp()` ≈ `@main` + `WindowGroup`
  - Hot reload vs hot restart — understand the difference

- [x] **CP3 — Widget tree basics**
  - `StatelessWidget` — pure render, no mutable state (≈ a SwiftUI `View` with no `@State`)
  - `StatefulWidget` — widget + `State<T>` object; `setState()` triggers re-render
  - Understand why Flutter separates widget config from state object
  - Build: static timer display UI with hardcoded text

- [x] **CP4 — Layout widgets**
  - `Column`, `Row`, `Stack`
  - `Padding`, `SizedBox`, `Expanded`, `Flexible`
  - `Container` (≈ `ZStack` + modifiers rolled into one)
  - `Scaffold`, `AppBar`, `FloatingActionButton`
  - Build: lay out the stopwatch screen — big time readout, two buttons

### Day 2 — State & Navigation

- [ ] **CP5 — State management basics**
  - Lift state up the tree (same concept as SwiftUI)
  - `InheritedWidget` — understand why it exists before skipping to Provider
  - Install `provider` package; implement `ChangeNotifier` for a `StopwatchModel`
  - *SwiftUI parallel:* `ChangeNotifier` ≈ `@Observable` class; `ChangeNotifierProvider` ≈ `.environment()`; `Consumer<T>` / `context.watch<T>()` ≈ `@Environment(T.self)`
  - Build: wire Start/Pause/Reset buttons to `StopwatchModel`

- [ ] **CP6 — Timers & animation**
  - `Timer.periodic` from `dart:async` — tick every 10ms to update elapsed time
  - `AnimationController` + `Ticker` for 60fps work (≈ `CADisplayLink`)
  - `TweenAnimationBuilder` for simple animated values
  - Build: live updating `MM:SS.CC` readout; animated progress ring using `CustomPainter`

- [ ] **CP7 — Navigation**
  - `Navigator.push` / `Navigator.pop` — imperative (understand this first)
  - Named routes
  - `GoRouter` package — declarative routing (≈ `NavigationStack` + `.navigationDestination`)
  - Build: add a Settings page; navigate to it from an icon button in the AppBar

- [ ] **CP8 — Lists & scrolling**
  - `ListView`, `ListView.builder` (lazy, ≈ `List` with `ForEach`)
  - `ListTile`
  - Build: lap list below the stopwatch readout

### Day 3 — Polish & Platform

- [ ] **CP9 — Forms & input**
  - `TextField`, `TextEditingController` (≈ `@Binding` + `TextField`)
  - `Form`, `TextFormField`, `GlobalKey<FormState>`
  - Build: settings page with a configurable interval input

- [ ] **CP10 — Persistence**
  - Add `shared_preferences` package
  - Read/write a setting (e.g., preferred interval)
  - *SwiftUI parallel:* `UserDefaults` — almost identical API

- [ ] **CP11 — Theming & styling**
  - `ThemeData`, `ColorScheme`
  - `MaterialApp` theme vs per-widget styling
  - Dark mode support
  - *SwiftUI parallel:* ≈ combining `Color` assets + `\.colorScheme` environment

- [ ] **CP12 — Platform differences & wrap-up**
  - iOS-specific: status bar, safe area (`SafeArea` widget ≈ `.safeAreaInset`)
  - `MediaQuery` for screen dimensions (≈ `GeometryReader`)
  - Flutter DevTools overview — widget inspector, performance overlay
  - Write down 3 things Flutter does better than SwiftUI and 3 things worse

---

## Working Rules for Claude

- **No commands without being asked.** Always explain first; I run it.
- **Map new concepts to SwiftUI equivalents** whenever possible.
- **Keep code snippets minimal** — show the pattern, not a full app.
- **Call out Dart gotchas** that would trip up a Swift developer (e.g., `null` safety differences, no value types for custom structs, `const` constructor rules).
- **Don't add packages** I haven't asked for. Suggest them with rationale; I decide.
- **Prefer `provider`** for state management at this stage — it's the most instructive bridge from SwiftUI's environment model. Don't jump to Riverpod/Bloc unless I ask.
- When I'm stuck, give the smallest hint first, not the full solution.

### Daily Cheat Sheet Workflow

At the end of each day (when I ask), produce a cheat sheet in `notes/dayN_cheatsheet.md`:
- Summarize that day's checkpoints as quick reference, mapped SwiftUI → Flutter.
- **Explicitly flag where I stumbled** with a ⚠️ marker, and include a "Stumble Summary" section at the bottom listing the specific mistakes to review.
- Keep snippets minimal — patterns, not full apps.
- After writing it, mark that day's checkpoints `[x]` in this file and tag the day heading `✅ DONE` with a link to the cheat sheet.

---

## Key Files (once project exists)

| File | Purpose |
|---|---|
| `pubspec.yaml` | Dependencies + app metadata |
| `lib/main.dart` | Entry point, `runApp()` |
| `lib/models/` | `ChangeNotifier` state models |
| `lib/screens/` | Full-page widgets (≈ Views) |
| `lib/widgets/` | Reusable sub-widgets (≈ Components) |
| `lib/theme.dart` | `ThemeData` config |

---

## Useful Commands (run these yourself)

```bash
flutter doctor          # check setup health
flutter create <name>   # new project
flutter run             # run on connected device/simulator
flutter run -d chrome   # run as web app
flutter pub add <pkg>   # add a package (≈ swift package add)
flutter pub get         # fetch packages after editing pubspec.yaml
flutter analyze         # static analysis (≈ swiftlint)
flutter test            # run tests
---

## Capstone Mini Project — "VibeFlutter Timer"

Build this **entirely on your own** after completing all checkpoints. No hints unless you ask.

### What to Build

A single-package Flutter app with two screens:

**Screen 1 — Stopwatch**
- Live `MM:SS.CC` count-up display (60fps feel)
- Start / Pause / Reset buttons
- Lap button — records split times
- Scrollable lap list below the controls (lap number + split time)
- Animated circular progress ring that completes every 60 seconds

**Screen 2 — Countdown Timer**
- User inputs a duration via a text field (e.g. "90" for 90 seconds)
- Countdown display — `MM:SS`
- Start / Pause / Reset
- Visual or color change when under 10 seconds
- A notification-style banner (SnackBar or dialog) when it hits zero

**Shared / App-wide**
- Bottom navigation bar to switch between the two screens
- Persist the last-used countdown duration across app restarts (`shared_preferences`)
- Light and dark mode support via `ThemeData`
- At least one reusable custom widget extracted into `lib/widgets/`

### Rules

- Implement everything yourself — no copying from checkpoint examples
- You may consult Flutter/Dart docs freely
- Ask Claude only for unblocking hints, not for writing code
- When done, paste your code and ask for a review

### AI Review & Scoring

When you're ready, share your code and say **"review my capstone"**. Claude will score each criterion out of the points shown and give written feedback like an exam grader.

| Criterion | Points |
|---|---|
| Dart code quality — null safety, types, `const` correctness | 10 |
| Widget architecture — stateless vs stateful used appropriately | 15 |
| State management — `ChangeNotifier` + `Provider` wired correctly | 20 |
| 60fps timer accuracy — no UI jank, correct tick source | 10 |
| Navigation — bottom nav + screen separation clean | 10 |
| Persistence — last-used duration survives app restart | 10 |
| Theming — dark/light mode works without hardcoded colors | 10 |
| Reusable widget — meaningful extraction, not just cosmetic | 10 |
| Code organisation — folder structure, naming conventions | 5 |
| **Total** | **100** |

**Grade scale:** 90–100 Distinction · 75–89 Pass · 60–74 Needs work · <60 Revisit checkpoints

Feedback will call out specific file/line issues, map them back to the checkpoint that covers the concept, and suggest what to fix — not rewrite it for you.