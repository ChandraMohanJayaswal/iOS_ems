# Google Stitch Design Prompt — EMS (Employee Management System)

Design a complete, production-ready UI design system and full set of screen mockups for an iOS employee management app called **"EMS"**, built with SwiftUI. The output should give me a consistent theme from logo and icons to reusable components and every screen, so I can improve the existing app's design.

---

## 1. App Overview

- **Name:** EMS (short for Employee Management System)
- **Developer:** Chronelab Technologies
- **Platform:** iOS (iPhone), SwiftUI, portrait orientation
- **Purpose:** Employees manage their work attendance, leave requests, public holidays, and personal profile.
- **Audience:** Corporate employees and managers across departments.
- **Tone:** Professional, trustworthy, modern, friendly — not corporate-stiff. Clean, confident, high polish.

Key user flows that all screens must support:

1. Launch app → Splash → Onboarding (first-time) → Login → Main tabs.
2. View monthly/yearly attendance metrics on Home.
3. Browse the month calendar, see public holidays / weekends / personal leave days.
4. Request a new leave (full or partial day) and confirm submission.
5. Open the side menu → view / edit personal profile → sign out.

---

## 2. Brand & Design Direction

### Colors (existing palette to refine into one cohesive system)
The app currently uses an indigo/blue palette. Please define a **single brand color system** with name, hex, and usage, including **light and dark mode** variants.

- Primary / Brand blues:
  - `#4A4EF2` primaryBlue
  - `#3E41E8` royalBlue
  - `#262CCF` darkBlue (currently used for primary buttons and tab tint)
  - `#5D62FF` accentBlue
  - `#52/56/F9`-ish bright indigo glow for gradients
- Lavender neutrals (login form fields): `#C9CCF8` paleLavender, `#8E92C9` mutedLavender, `#E8EAFF` softWhite, `#F2F2ED` ashWhite
- Neutral / semantic (keep consistent):
  - `#0071BC` info blue
  - `#22C55E` success / approved green
  - `#F59E0B` warning / pending amber
  - `#EF4444` error / rejected red
  - `#A92525` dark red (past-day holidays)
  - `#B7B9C3` light gray, `#686060` warm gray (muted/disabled/dates outside month)

Please either confirm this palette as-is (cleanly documented) or recommend an improved, more cohesive version with the same personality — and give every color a light-mode and dark-mode value.

### Typography
- Fonts: **Poppins** (display/headings, big numbers, page titles and metric values) + **Inter** (body, subheadline, captions, labels, buttons). Both bundled as static TTFs (Regular 400, Medium 500, SemiBold 600, Bold 700) and registered via `UIAppFonts`.
- Keep a clean hierarchy with named type styles:
  - Large title (28–34), Title 1/2/3, Headline, Subheadline, Body, Caption, Caption 2.
  - Poppins acts as the rounded display style for big numbers (metrics, counters).
- Provide line-height and weight guidance per style.
- SF Symbols always use the system font (custom fonts do not render symbol glyphs).

### Iconography
- Use Apple SF Symbols for consistency (list the recommended symbol or alternative for each key action/state: home, calendar, leave, menu, edit, sign out, holidays, weekend, success/pending/rejected status, notifications, etc.).
- Icon style guidance: stroke weight, grid sizing (e.g., 24pt within 44pt touch targets), color usage.

### Logo & App Icon
Design a **logo and app icon** for "EMS":
- A memorable monogram/mark that reads as an employee-management / people-organization concept (e.g., stylized people + calendar/clock motif), using the brand indigo gradient.
- App icon on both light and dark background and rounded-rect mask.
- A smaller standalone mark for the splash screen and login header.
- Optional: a simple horizontal lockup "EMS" wordmark + subline "By Chronelab Technologies".

### Shape & Elevation Language
- Cards: rounded rectangles, corner radii from 12 (buttons/inputs) to 20–24 (cards/charts), subtle soft shadows (low opacity, y-offset).
- Pills/badges: capsule shape (full round) for tags, status, and small controls.
- Buttons: capsule or 12pt rounded-rect primary buttons.
- Surfaces: grouped background (light gray) behind cards; floating cards on `.white` / `.background`.
- Accessory: current app uses a subtle `glassEffect` on toasts — keep the floating-pill toast concept.

---

## 3. Screen-by-Screen Design Brief

Design every screen in iPhone size (e.g., 390x844), light and dark, and with a realistic data states.

### 3.1 Splash
- Centered **"EMS"** wordmark in brand indigo, heavy weight, large title.
- Subline: **"By Chronelab Technologies"** in gray.
- Decorative animated mark: people icon with a rotating gear badge (top-trailing). Suggest a cleaner, calmer premium version of this animation concept.
- Auto-advances after ~3s to Login (or Home if already logged in).

### 3.2 Onboarding (3 pages) — first-time users
Full-screen vertical gradient (indigo → deep blue). Left-aligned or centered content:
1. **Welcome** — "Manage your team" — illustration of people/team.
2. **Features** — "Analytics, Tracking, Management" — illustration of analytics/dashboard.
3. **Employee Management System** — "Manage. Engage. Grow" — people icon tile + CTA.

Elements:
- Page dots indicator (animated; active dot wider/longer than inactive).
- Bottom button: white pill with brand-colored text — "Next" on pages 1–2, **"Get Started"** on page 3.
- Subtle spring animations on page change.
- Provide the illustrations as clean, flat, brand-colored vector concepts.

### 3.3 Login
- Decorative wash: two soft lavender gradient circles bleeding off-screen (top-left and bottom-right) over the background.
- Centered logo tile: "people" icon in a rounded lavender square.
- Title **"Welcome Back"** + subtitle **"Sign in to continue to your account"**.
- Email field (envelope icon) and Password field (lock icon + show/hide eye toggle) — rounded 12pt inputs on pale lavender background with subtle border.
- **Sign In** button: full-width, brand dark blue, disabled state gray; shows a spinner while loading.
- "Forgot Password?" link below.
- Error handling: alert dialog with message, plus inline field validation feedback.

### 3.4 Home (Dashboard tab)
- **Header:** Greeting "Hi, {FirstName}" (large bold title) on its own row.
- Second row: a **month/year period picker** pill (calendar icon + current selection + up/down chevron) and a pill showing fiscal year + current month. The period picker menu offers **Full Year** plus each month (Jan–Dec); choosing one refetches metrics for that period.
- **Statistics section title:** dynamically "Statistics for this Month" (or "Statistics for this Year" when Full Year is selected).
- **Attendance metrics card** containing:
  - A grouped bar chart of **Working / Worked / Leave** days (brand-colored bars: blue, green, orange), legend included.
  - Stat tiles in two rows: Working, Worked, Leave (number + label) and **Casual Leave balance / Sick Leave balance** (with red/yellow accent).
- Pull-to-refresh support.
- Badge style consistent with the rest of the app (capsule, tinted background).

### 3.5 Calendar tab
- **Header:** month picker pill + year picker pill (same capsule style as Home picker) + a **"Today"** text button in cyan.
- **Weekday row:** Sun–Sat, caption, secondary color.
- **Calendar grid:** 7 columns, spacious cells; today marked with a small dot; selected day highlighted with a filled circle (tinted brand/cyan).
- **Day color coding:** public holidays = red, weekends = gray, past days = muted gray, regular = primary.
- **Holiday legend / selected-date panel:** caption area showing holiday/description for the selected date with a colored left accent bar.
- **Personal Leaves section:** section title + circular "+" button (requests a leave, opens Request Leave sheet).
- **Segmented filter:** All / Approved / Pending / Rejected.
- **Leave request list items:** leading circular icon tile (calendar badge clock), leave type + date range, trailing status badge (Approved green / Pending orange / Rejected red). Tapping opens a detail sheet.
- Empty state for "no leaves" with friendly illustration + caption.

### 3.6 Request Leave (form, presented as sheet)
- Form sections:
  - **Line Manager** — multi-select menu (checkmarks), shows "N selected".
  - **Leave Type** — dropdown picker.
  - **Partial Leave** toggle; when on, a **Duration** picker surfaces (Quarter day 0.25 / Half day 0.5).
  - **Leave From Date / Leave To Date** date pickers (To hidden for partial).
  - **Description** multiline text field.
- **Submit button** (full-width) disabled until valid; on tap → confirmation alert → on success a capsule **toast** "Leave request submitted" (green check icon) slides in from top.
- Inline validation states for required fields.

### 3.7 Side Menu (slide-in from left)
- 300pt wide white panel over a dimmed scrim (tap outside to close).
- **User profile header:** avatar tile (rounded-square, brand blue with person icon), name + email; tapping navigates to Profile.
- Divider-separated rows: **About Us**, **Contact Us**, **Sign Out** (red, do not mute).
- Rows use icon + label + chevron format. Deliver a refined, consistent menu list design.

### 3.8 User Profile
- Navigation title **"Profile Details"** (principal), back chevron (leading), edit pencil (trailing).
- **Form list** of read-only rows: Role, Name, Gender, Date of Birth, Mobile No, Email Address (label left, value right-align).
- **Edit Profile sheet (modal):** editable form — First Name, Last Name, Gender (segmented Male/Female/Others), Date of birth (date picker), Mobile Number, Email Address — plus a Save button.
- Grouped/list layout with standard iOS section styling, styled to match the overall theme.

### 3.9 Placeholder screens (will be built later)
- **Users** and **Utility** — currently bare placeholders. Provide recommended layouts: a user directory/list screen with search, and a utilities/misc settings screen — so the design system covers them too.

---

## 4. Design System Deliverables

Produce a design system that makes every screen feel like one app:

1. **Tokenized color palette** — brand + neutral + semantic + status, light & dark, with usage rules.
2. **Typography scale** — named styles, weights, sizes, line heights, usage.
3. **Logo & app icon** — full set (mark, monogram, wordmark, icon variants).
4. **Iconography set** — SF Symbols list with color/fill guidance for every action and state.
5. **Component library:**
   - Buttons: primary, secondary/outline, ghost, disabled, loading; pill & rectangular variants.
   - Inputs & form fields: text, secure (with eye toggle), multi-line, pickers, date pickers, toggles, segmented control.
   - Pills/badges: status badges (approved/pending/rejected), period selector pill, holiday tag.
   - Cards: stat card, leave request card, holiday card.
   - Calendar: day cell (normal, today, selected, holiday, weekend, out-of-month), weekday header.
   - Chart card with bar-chart legend.
   - Navigation & toolbar: header layout (menu leading, title, bell trailing), back bars for sheets.
   - Tab bar: Home + Calendar (2 tabs currently), selected/unselected states.
   - Toast (capsule), alert dialogs, empty states, loading skeleton/spinner.
6. **State examples** for key screens: loading, loaded, empty, error.
7. **Accessibility & touch targets:** min 44pt targets, contrast ratios, dynamic-type notes.

---

## 5. Output Format

Deliver, in order:
1. Design principles & theme summary (3–5 bullets).
2. Color system + type scale + spacing/radius grid.
3. Logo, app icon, iconography.
4. Core components library.
5. Full mockups for every screen in **3. Screen-by-Screen Design Brief** (light mode, and dark mode where it changes meaningfully), with annotations.
6. Any recommended motion/transition guidance (screens' transitions, list animations, toast, pulse for calendar today dot).

Make everything consistent, elegant, and immediately buildable in SwiftUI.