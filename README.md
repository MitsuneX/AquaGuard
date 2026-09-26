# 💧 AquaGuard — SDG 6 Clean Water & Sanitation

AquaGuard is a modern, responsive **Flutter Web** educational platform dedicated to **UN Sustainable Development Goal 6: Clean Water and Sanitation**.

It enables users to explore global water issues, learn about water and sanitation challenges, view interactive data visualizations, calculate their personal daily water footprint, and discover actionable conservation steps.

---

## 🌟 Features

- **🌊 Animated Landing & Hero**: Engaging ocean wave animations, fast facts, and quick navigation.
- **💧 Water Education**: Deep dive into freshwater availability, water quality, scarcity, and conservation strategies.
- **🚽 Sanitation & Hygiene**: Dedicated insights into sanitation infrastructure, hygiene practices, wastewater treatment, and health impacts.
- **📊 Interactive Dashboard**: Visual data powered by `fl_chart`, tracking progress towards 2030 SDG 6 targets and regional access gaps.
- **🧮 Water Footprint Calculator**: Real-time personal daily/weekly/monthly water usage calculator with savings projections.
- **🌱 Take Action**: Practical, high-impact conservation practices categorized by effort and impact.
- **📖 About SDG 6**: Comprehensive target breakdown (6.1 – 6.B), historical timeline, and partner organizations.

---

## 🛠️ Tech Stack & Constraints

- **Framework**: Flutter Web (Material 3)
- **Language**: Dart
- **Architecture**: 100% Frontend (zero backend, zero database, all static Dart models/constants)
- **Charts**: `fl_chart`
- **Typography**: Google Fonts (Inter)

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.0.0)
- Google Chrome or any modern web browser

### Installation & Run

```bash
# 1. Install dependencies
flutter pub get

# 2. Run locally in Chrome
flutter run -d chrome

# Or run as a local web server
flutter run -d web-server --web-port 8080
```

### Production Build

```bash
flutter build web --release
```
The compiled static assets will be located in `build/web/`.

---

## 📄 License

Educational project for academic and SDG awareness purposes.
