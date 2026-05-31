# Day 1 — Foundations Cheat Sheet

Quick reference for Dart + Flutter basics, mapped from SwiftUI. Stumbles are flagged with ⚠️.

---

## CP1 — Dart Basics

### Variables
```dart
var name = "VibeFlutter";  // inferred (like Swift var)
final elapsed = 0;         // runtime constant — reach for this when Swift instinct says `let`
const pi = 3.14;           // compile-time constant
```

| Swift | Dart |
|---|---|
| `let x = ...` | `final x = ...` |
| static compile-time `let` | `const x = ...` |

### Null Safety (almost 1:1 with Swift)
```dart
String? name = null;       // nullable, same ? as Swift
print(name!);              // force unwrap (same danger)
print(name ?? "default");  // nil-coalescing
print(name?.length);       // optional chaining
```

### Functions & Named Params
```dart
String greet(String name, {bool loud = false}) { ... }
greet("Ash", loud: true);

// required named param:
String greet({required String name}) { ... }
```
- Named params go in `{}` — this is everywhere in Flutter widget trees.

### Classes
```dart
class StopwatchModel {
  final String label;
  int _elapsed = 0;          // _ prefix = private (like fileprivate)
  StopwatchModel({required this.label});  // constructor shorthand
  void tick() => _elapsed++;
}
```
⚠️ **No value types.** Dart has no `struct` — everything is a class (reference type).

### async / Future / Stream
```dart
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return "done";
}

Stream<int> counter() async* {   // async generator (≈ AsyncStream)
  yield i++;
}
```

---

## CP2 — First Flutter App

- `flutter create vibe_flutter` → scaffolds whole project.
- ⚠️ **Snake_case name required** — becomes the Dart package name + import prefix (`package:vibe_flutter/...`). Display name is set separately in platform files.
- `pubspec.yaml` ≈ `Package.swift` + `Info.plist`. `^1.0.8` = "up to next major" (like SPM).
- `runApp(const MyApp())` ≈ `@main` + `WindowGroup`.

### Hot reload vs hot restart
| | Key | Rebuilds | State kept? |
|---|---|---|---|
| Hot reload | `r` | widget tree | ✅ yes |
| Hot restart | `R` | Dart VM | ❌ no |

Hot reload ≈ Xcode Previews live update. Hot restart ≈ re-running the app.

---

## CP3 — Widget Tree Basics

### The two widget types
```dart
// StatelessWidget — pure render, all fields final
class TimerUI extends StatelessWidget {
  final String time;
  const TimerUI({super.key, required this.time});
  @override
  Widget build(BuildContext context) => Text(time);
}
```
- `StatelessWidget` ≈ a SwiftUI `View` with no `@State`.
- `StatefulWidget` = splits into TWO classes: the immutable **widget config** + a mutable **`State<T>`** object. `setState()` triggers `build()` to re-run.

| SwiftUI | Flutter |
|---|---|
| `struct MyView: View` | `class MyPage extends StatefulWidget` |
| `@State var count = 0` | `int _counter = 0` in the State class |
| `var body: some View` | `Widget build(context)` |
| one struct | two classes |

### ⚠️ const constructor rules (where I stumbled most)
The whole point: **`const` = everything known at compile time.**

```dart
final time = DateTime.now().toString();   // ❌ runtime value → can't be const
const TimerUI(time: DateTime.now()...);   // ❌ argument is runtime → const invalid
const TimerUI(time: "00:00.00");          // ✅ string literal is compile-time
```

⚠️ **Closures are never const.** Any widget taking a callback can't be `const`:
```dart
ElevatedButton(onPressed: () {}, child: const Text("Start"))  // ✅ no const on button
```

**Pattern:** `const` widgets are dumb display boxes — data flows IN, nothing computed inside.

---

## CP4 — Layout Widgets

### Core widgets
```dart
SizedBox(height: 24)              // fixed gap (≈ Spacer(minLength:) / fixed frame)
Padding(padding: EdgeInsets.all(16), child: ...)   // ≈ .padding()
Container(width:, height:, decoration:, child:)    // Swiss Army: ZStack+frame+bg+padding
Expanded(child: ...)             // fill remaining space along main axis
```

### ⚠️ The Expanded gotcha (where I stumbled)
`Expanded` only works as a **direct child of `Row`/`Column`**, and it eats remaining space along that axis.

| `Expanded` inside | takes remaining... |
|---|---|
| `Column` | vertical space |
| `Row` | horizontal space |

❌ Wrapping a `Padding`(→`Row`) in `Expanded` inside a Column made the whole button block eat all vertical height → buttons floated in a huge empty zone.

✅ Fix: drop the outer `Expanded`, keep `Padding`; use inner `Expanded`s inside the `Row` to split width. Add `SizedBox(width: 16)` between buttons so they don't touch.

### Dart gotcha
⚠️ `() => {}` is a **Set literal**, not an empty function. Use `() {}` for an empty callback.

### The mental shift from SwiftUI
SwiftUI: views size to content, add `Spacer()` to push apart.
Flutter: some widgets grow as big as possible, others shrink to content — you must know which is which.

---

## Stumble Summary (review these)
1. `const` + runtime values (`DateTime.now()`) — const must be fully compile-time.
2. `const` + closures — callbacks block `const`.
3. `() => {}` returns a Set, not a function body.
4. `Expanded` placement — only direct children of Row/Column; wrapping wrong widget = wrong axis greedily filled.
