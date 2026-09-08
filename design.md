# EMS (Employee Management System) — Design Documentation

This document reflects the **actual implemented state** of the iOS EMS app (SwiftUI), verified against the current codebase. It documents the design system in use, each screen as built, and open gaps / planned improvements so future UI work targets the real app.

- **Name:** EMS (Employee Management System)
- **Developer:** Chronelab Technologies
- **Platform:** iOS (iPhone), SwiftUI, portrait orientation
- **Bundle ID:** `com.chronelab.ios-ems`
- **Display name:** EMS
- **Targets:** `iOS_EMS` (app), `iOS_EMSTests`, `iOS_EMSUITests`
- **Purpose:** Employees manage work attendance, leave requests, public holidays, and their personal profile.

---

## 1. App Flow (as implemented)

1. **Splash** (`ViewSplash`) → waits ~3s → `Login` (if not logged in) or `Tab Bar` (if logged in).
   - Routing lives in `RouteCoordinator` (single `AppScreen` enum + `currentScreen` switch). Screens: `login`, `splash`, `tabbar`, `userProfile`, `onBoarding`, `requestLeave`.
2. **Onboarding** (`ViewOnBoarding`) — defined in the code and routed from `AppScreen.onBoarding`, but **not yet wired into the launch flow** (see Gaps).
3. **Login** (`ViewLogin`) → on success navigates to the Tab Bar.
4. **Tab Bar** (`ViewTabBar`) — **4 tabs**: Home, Calendar, Profile, Settings.

> ⚠️ **Gap:** `isFirstTimeLoggedIn` (UserDefaults) is **not implemented**. There is no logic that decides Splash → Onboarding (first launch) vs Splash → Login. Onboarding is reachable only via the coordinator's `onBoarding` case, which nothing currently triggers.

---

## 2. Brand & Design System (as built)

### 2.1 Colors — `Util /Constants.swift`

The app now uses a single tokenized palette. All UI brand colors point at these values:

| Name | Hex | Usage |
|------|-----|-------|
| `blue` | `#262CCF` | Primary brand / tints / buttons / certain icons |
| `orange` | `#FFA528` | Accent (splash/login decorative shapes, Leave chart, Pending badge) |
| `red` | `#FF5E3A` | Destructive / Casual Leave stat / holiday marks / Rejected & Close |
| `neutral` | `#0E1236` | Dark profile icons (back / edit chevrons) |
| `warmGray` | `#686060` | Muted / secondary text |
| `lightGray` | `#B7B9C3` | Dates outside range / muted fills |

Additional colors used inline (not tokenized): `.green` (Worked chart bar, Approved), `.yellow` (Sick Leave stat), `.cyan` (Calendar "Today" indicator + selected-day fill + request "+" button), `.gray`, `.secondary`, `Color.accentColor`.

> **Note:** The previous broad indigo/lavender palette (primaryBlue/royalBlue/accentBlue/paleLavender/softWhite, etc.) was consolidated: only the used colors remain in `Constants.swift`. Unused constants were removed.

### 2.2 Typography — `Util /CustomUI/Fonts.swift`

Two bundled static fonts, registered via `UIAppFonts` in `ems-ios-Info.plist` (all as TTFs):

- **Poppins** (display/headings) — `Poppins-Regular|Medium|SemiBold|Bold`. Used via `.poppins(.weight, size:)`.
- **Inter** (body/labels) — `Inter-Regular|Medium|SemiBold|Bold`. Used via `.inter(.weight, size:)`.

Helper API: `extension Font { static func poppins(_ weight: PoppinsWeight = .regular, size: CGFloat) -> Font }` and `static func inter(...)`.

Observed usage:
- Titles/nav headers: `.poppins(.bold, size: 22)` (headers), `.poppins(.bold, size: 20)`, `.poppins(.bold, size: 34)` (splash/onboarding titles).
- Metric values / big numbers: `.poppins(.bold, size: 17)`.
- Body/interaction: `.inter(size: 12/15)`, `.inter(.semibold, size: 12/17)`, `.inter(.medium, size: 15)`.
- Tab bar labels: `Poppins-Medium` at 10pt via `UITabBarAppearance` (`EMSApp.applyTabBarAppearance`).
- **SF Symbols always use the system font** (custom fonts do not render symbol glyphs).

### 2.3 App icon & assets — `Assets.xcassets`

Contains image sets: `AppIcon` (with `screen.png`), `SplashLogo`, `People`, `employeeLogo`, `peopleIcon`, plus `AccentColor` colorset. There is an **AccentColor colorset** defined in assets, distinct from the code-level `Color.accentColor`.

---

## 3. Screens (as implemented)

### 3.1 Splash — `ViewSplash.swift` + `LoadingBar.swift` + `SyncIndicator.swift`
- Background: oversized decorative outline shapes (circles/rounded rects/rotated squares) with `orange.opacity(0.5–0.6)` fills/strokes.
- Centered **"EMS"** wordmark (`.poppins(.bold, size: 34)` in `blue`), subline **"By Chronelab Technologies"** (`.inter(.bold, size: 24)`, gray).
- A "workspace window" mockup card: rounded rect with law-shadow, an `Image("SplashLogo")`, three colored status dots, and a yellow **"Employee Portal"** tag.
- `LoadingBar()` (animated capsule) + `SyncIndicator()` (spinning trim circle) + "Synchronizing attendance..." label (monospaced caption).
- Auto-advance after 3s → Login or Tab Bar based on `EMSManager.shared.isLoggedIn`.

### 3.2 Onboarding — `ViewOnBoarding.swift`
- **Not wired into launch flow yet.** Three pages driven by `OnBoardingPage` enum: `firstPage` ("Welcome" / "Manage your team"), `secondPage` ("Features" / "Analytics, Tracking, Management"), `thirdPage` ("Employee Management System" / "Manage. Engage. Grow").
- Full-screen `LinearGradient(colors: [.blue, blue])` (top→bottom).
- `TabView` with `.page` style, spring animation; animated page dots (active dot larger — 12 vs 8).
- Per-page content: title (`.poppins(.bold, size: 34)`), a `Circle` stroke + `Image("People")`, description (`.inter(.medium, size: 15)`); page 3 adds a `person.2.fill` tile.
- Bottom pill button (white, 12pt radius, `blue` text): **"Next"** on pages 1–2, **"Get Started"** on page 3 → `coordinator.navigate(to: .login)`.
- Entrance animations via `isAnimating` + `.spring()/.smooth` offsets.

### 3.3 Login — `ViewLogin.swift`
- Same decorative background shapes as Splash (`orange` accents).
- "EMS" + "By Chronelab Technologies" header; a "workspace window" card (with `SplashLogo`, status dots, yellow **"Login"** tag).
- Form (`loginForm`):
  - Work Email — envelope icon, rounded field, `.white` bg with gray border.
  - Password — lock icon, show/hide eye toggle (`eye`/`eye.slash`), `SecureField` vs `TextField`.
  - "Forgot Password?" link (`.foregroundStyle(blue)`).
  - **Sign In** button — full width, `blue` bg when valid / `Color.gray` when disabled; shows a `ProgressView` spinner while loading; green-arrow icon. Disabled until `viewModel.isFormValid`.
- Accessibility identifiers: `email`, `passwordField`, `toggleHidePassword`, `loginButton`.
- On success (`!.errorOccured`) → `coordinator.navigate(to: .tabbar)`.

### 3.4 Home (Dashboard) — `ViewHome.swift` + `ViewModelHome.swift`
- `ScrollView` with `.refreshable` (pull-to-refresh) calling `getMetrics()`.
- `.header(title: "Home")` (principal nav title via `HeaderModifier`), background `systemGroupedBackground`.
- **Header row:** `periodPicker` (Menu: Full Year + Jan–Dec, labeled with a calendar icon + chevrons) and a fiscal-year/month capsule.
- **Attendance card** (`attendanceCard`, 24pt radius, soft shadow):
  - `Charts` iOS bar chart, `chartForegroundStyleScale(["Working": blue, "Worked": .green, "Leave": orange])`.
  - Stat tiles (`.poppins(.bold, size: 17)` values): Working (blue), Worked (green), Leave (orange) in one row; **Casual leave** (red) and **Sick leave** (yellow) in the second row. Separated by `Divider()`s.

### 3.5 Calendar — `ViewCalendar.swift` + `ViewModelCalendar.swift`
- Cards: `calendarCard`, `dateInfoCard`, `personalLeavesCard`; `.header(title: "Calendar")`.
- **Month/Year pickers**: two pill Menus (month names + years 2020–2030) in `Color.accentColor`; a **"Today"** button (`.cyan`).
- **Weekday header**: Sun–Sat, `.inter(.semibold, size: 12)`, secondary.
- **Day grid**: 7 columns; today marked with a `.cyan` dot; selected day filled with a `.cyan.opacity(0.18)` circle; public holidays show a **red** dot (`red`).
- Day text color via `viewModel.checkDateColor(day)` (past holidays = `darkRed`→ now `red`, etc.).
- **Date info card**: weekday/date title (`.poppins(.bold, size: 20)`), holiday description list with a colored left accent bar (`checkDateColor`).
- **Personal Leaves card**: title + circular cyan **"+"** button (opens `ViewRequestLeave` sheet); segmented filter (All/Approved/Pending/Rejected via `LeaveStatusType`); list of `LeaveRequestItem`s.

### 3.6 LeaveRequestItem — `Util /CustomUI/LeaveRequestItem.swift`
- Row: leading `calendar.badge.clock` icon tile (accent tint), leave type (`.poppins(.semibold, size: 17)`), date range (`.inter size 12), trailing **status badge** (`statusColor`): APPROVED `.green`, PENDING `orange`, REJECTED `red`.
- Tap → detail sheet (Leave Type, Requested Date Time, From/To, Description, Status, Comment) with red close button.

### 3.7 Request Leave (sheet) — `ViewRequestLeave.swift` + `ViewModelRequestLeave.swift`
- `Form` with: `MultiSelectPicker` Line Manager (checkmark multi-select, "N selected"), Leave Type `Picker`, **Partial Leave** toggle (reveals Duration picker: Quarter day 0.25 / Half day 0.5), Leave From/To `DatePicker`s (To hidden for partial), Description multiline `TextField`.
- **Submit** button disabled until `isFormValid`; tap → confirmation alert ("Send leave request?") → on success, a green check **toast** "Leave request submitted" (`ToastModifier`, capsule, `glassEffect`).
- All form controls use `.inter(size: 15/17)`.

### 3.8 Tab Bar — `Util /Coordinator/TabBar.swift`
- 4 tabs via `TabValue` (iOS 18+ `Tab`): Home (`house`), Calendar (`calendar`), Profile (`person.crop.circle`), Settings (`gearshape`).
- `.tint(blue)`; `.tabBarMinimizeBehavior(.onScrollDown)`.
- Accessibility identifiers: `tab_home`, `tab_public_holidays`, `tab_profile`, `tab_settings`.
- Each tab wrapped in its own `NavigationStack`.

### 3.9 Profile (tab) — `ViewProfile.swift`
- `profileCard`: avatar (`person.circle.fill`, `blue`), name + role, trailing edit pencil (`blue` circle) → opens `EditProfileSheet`.
- `detailsCard`: read-only rows — Role, Gender, Mobile No, Email Address.
- **Sign Out** button (`door.right.hand.open`, `red` bg) → `EMSManager.shared.signOut()` → navigate to Login.

### 3.10 User Profile (detail flow) — `ViewUserProfile.swift` + `ProfileForm.swift` + `ProfileRow.swift` + `ProfileHeader.swift`
- `ProfileHeader` toolbar: **"Profile Details"** title (`.poppins(.bold, size: 22)`), back chevron (`neutral`), edit pencil (`neutral`).
- `ProfileForm` (read-only `Form`): Role, Name, Gender, Date of Birth, Mobile No, Email Address (via `ProfileRow`: `"title:"` + value, `.inter size 15`).

### 3.11 Edit Profile (sheet) — `EditProfileSheet.swift`
- Editable `Form`: First Name, Last Name, Gender (segmented), Date of birth (date picker), Mobile Number, Email Address — all `.inter(size: 17)`.
- **Save** button (`opticaldisc` icon) → `onSave`.

### 3.12 Settings (tab) — `ViewSettings.swift`
- `.header(title: "Settings")`; a list of `SettingsItem` rows (icon tile in `blue`, title, chevron): Notifications, About Us, Contact Us, Privacy Policy, Terms & Conditions. Rows are currently non-functional buttons.

---

## 4. Shared Components

- **Header modifier** — `HeaderModifier` / `View.header(title:)`: inline nav title (`.poppins(.bold, size: 22)`) + top divider. Used by Home, Calendar, Profile, Settings.
- **Toast** — `ToastModifier` / `View.toast(isPresented:message:icon:)`: top capsule, auto-dismiss after 3s, slide+opacity transition, `glassEffect`.
- **LeaveRequestItem** — status-badge list row + detail sheet (see 3.6).
- **MultiSelectPicker** — generic menu-based multi-select (defined in `ViewRequestLeave.swift`).
- **Fonts** — `PoppinsWeight` / `InterWeight` enums + `.poppins()` / `.inter()` helpers.
- **Tab bar appearance** — Poppins-Medium 10pt labels applied globally in `EMSApp`.

---

## 5. State / Persistence

- `EMSManager` (singleton) wraps `UserDefaults` + `KeychainSwift`:
  - Keys: `loggedUser` (JSON `User`), `user_token` (Keychain), `isUserLoggedIn` (Bool).
  - `login(user:token:)`, `signOut()` (clears Keychain + `removePersistentDomain`), computed `currentUser`, `token`, `isLoggedIn`.
- **No `isFirstTimeLoggedIn` flag exists yet** — this is a pending requirement (see Gaps).

---

## 6. Gaps & Next Steps

1. **Add `isFirstTimeLoggedIn` to UserDefaults** (pending, in TODO). Wire Onboarding into the launch flow:
   - First launch → Splash → **Onboarding** → Login.
   - Returning user (already logged in) → Splash → Tab Bar.
2. **Onboarding UI refresh** — the screen exists but needs a design polish pass to match the rest of the app (it is not currently reachable at launch).
3. **Settings rows** (Notifications/About/Contact/Privacy/Terms) are placeholders — no destinations wired.
4. **`routeCoordinator.requestLeave` case** in `ViewRoot` has a commented-out body — Request Leave is only reachable from the Calendar "+" sheet, not the coordinator.
5. **Dark mode** — current palette identifies colors as light-mode values; no explicit dark-variant tokens or asset catalog color sets are used for the UI background beyond `systemGroupedBackground` / `.background`.
6. **App icon** — `AppIcon.appiconset` contains placeholder `screen.png`; final branded icon not yet set.
7. **Empty states** — Calendar "no leaves" empty state and loading skeletons are not yet implemented.
8. **Unit tests** — `TestViewModelPublicHolidays` currently doesn't compile (references removed types like `PublicHolidaysAPIResponseDetails` / `allpublicHolidayList` / `truncateDescription`); left as-is pending a decision.

---

## 7. Conventions for Ongoing UI Work

- Always use the tokenized colors (`blue`, `orange`, `red`, `neutral`, `warmGray`, `lightGray`) from `Constants.swift` rather than inline `Color(red:...)`.
- Use `.poppins(...)` for display/headings/numbers and `.inter(...)` for body/labels; keep system font for SF Symbols.
- Reuse shared components (`header(title:)`, `toast`, `LeaveRequestItem`) where possible.
- System colors such as `.green`/`.yellow`/`.cyan` may remain for status/accent semantics; add a token if a color is reused more than twice.
