# Better Deal 💰

A Flutter app that helps users compare commission structures and exchange scenarios to find the best financial deal when transferring money or making currency exchanges.

## 🎯 Key Features

### 📊 **Dual Scenario Comparison**
- Compare two different financial scenarios side-by-side
- Real-time calculations with instant visual feedback
- Clear winner indication with detailed breakdown and analysis

### 💸 **Advanced Commission System**
- **Multiple commissions per scenario** - Add unlimited commission steps
- **Flexible types** - Support for both percentage (%) and fixed amount ($) commissions
- **Custom descriptions** - Name your commissions for clarity
- **Smart calculation order** - Commissions applied sequentially for accuracy

### 📈 **Reimbursement Management**
- **Offset commission costs** with reimbursements (cashback, refunds, etc.)
- **Dual types** - Percentage or fixed amount reimbursements
- **Applied after commissions** for accurate final calculations
- **Visual distinction** - Green-themed UI to differentiate from red commissions

### 🌍 **Complete Bilingual Support**
- **English** 🇺🇸 and **Spanish** 🇪🇸 with flag-based language switching
- **Full localization** including:
  - All UI text, buttons, and labels
  - Calculation step descriptions ("Final conversion" / "Conversión final")
  - Share messages and detailed breakdowns
  - Error messages and validation text

### 📱 **Professional Share Feature**
- **Detailed shareable reports** in user's selected language
- **Complete breakdown** including:
  - Initial base amount
  - All commissions with descriptions and values
  - All reimbursements with descriptions and values  
  - Exchange rates and final calculations
  - Winner determination and difference analysis
- **Professional formatting** with emojis, hashtags (#betterdeal)

### 🎨 **Modern Material Design**
- **Material Design 3** with dynamic theming
- **Responsive layout** - Optimized for mobile and tablet screens
- **Smart visual hierarchy** - Color-coded scenarios and intuitive icons
- **Accessibility features** - Proper contrast and text sizing

## 📱 Screenshots

### Main Interface
- Clean, modern Material Design 3 interface
- Side-by-side comparison cards (on wide screens)
- Stacked layout for mobile devices

### Key Components
- **Base Amount Input**: Set the initial amount for comparison
- **Scenario A Card**: Multi-commission configuration with percentage/fixed amount options
- **Scenario B Card**: Multi-commission configuration with percentage/fixed amount options  
- **Commission Type Toggle**: Switch between percentage (%) and fixed amount ($) for each commission
- **Comparison Result**: Visual winner indication with detailed analysis

## 🛠️ Technical Architecture

### Project Structure
```
lib/
├── constants/          # App constants and strings
├── models/            # Data models
│   ├── amount.dart
│   ├── commission.dart
│   ├── scenario.dart
│   └── comparison_result.dart
├── providers/         # State management (Provider)
│   └── comparison_provider.dart
├── screens/           # UI screens
│   └── comparison_screen.dart
├── services/          # Business logic
│   ├── calculation_service.dart
│   ├── export_service.dart
│   └── error_service.dart
├── widgets/           # Reusable UI components
│   ├── base_amount_card.dart
│   ├── scenario_a_card.dart
│   ├── scenario_b_card.dart
│   └── comparison_result_card.dart
└── main.dart
```

### Key Technologies
- **Framework**: Flutter 3.8+
- **State Management**: Provider pattern with ChangeNotifier
- **Architecture**: MVVM with clean separation of concerns
- **UI**: Material Design 3 with responsive layouts
- **Localization**: Custom translation service
- **Sharing**: share_plus package for cross-platform sharing

### 🔢 Advanced Calculation Logic

The app uses a sophisticated calculation engine that processes financial scenarios in the correct order:

#### Calculation Order:
1. **Commissions Applied First** (reduces amount)
2. **Reimbursements Applied Second** (increases amount) 
3. **Exchange Rate Applied Last** (final conversion)

#### Examples:

**Scenario with Commissions + Reimbursements:**
```
Base Amount: $1,000
Commission 1: 2% = $980 (1000 - 20)
Commission 2: $5 = $975 (980 - 5)
Reimbursement 1: 1% = $984.75 (975 + 9.75)
Reimbursement 2: $10 = $994.75 (984.75 + 10)
Exchange Rate: 1.05 = $1,044.49 final
```

**Mixed Types:**
```
Base: $5,000
- Bank Fee: 1.5% = $4,925
- Wire Fee: $15 = $4,910  
- Cashback: 0.5% = $4,934.55
- Bonus: $25 = $4,959.55
- Rate: 0.95 = €4,711.57 final
```

## 🚦 Getting Started

### Prerequisites
- Flutter SDK 3.8.1 or higher
- Dart 3.0 or higher
- iOS 11.0+ / Android API 21+

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd better_deal
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

#### Android
```bash
flutter build apk --release
```

#### iOS
```bash
flutter build ios --release
```

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

The project includes comprehensive tests for:
- Calculation logic validation
- Commission mathematics
- Scenario comparison accuracy
- Input validation functions

## 📊 Usage Examples

### Example 1: Currency Exchange Comparison
- **Base Amount**: $1,000 USD
- **Scenario A**: No commissions + 350 ARS/USD = 350,000 ARS
- **Scenario B**: 1% fee + 1% fee + 348 ARS/USD = 339,592 ARS
- **Result**: Scenario A is better by 10,408 ARS (3.07%)

### Example 2: Investment Platform Comparison
- **Base Amount**: $5,000 USD
- **Scenario A**: $10 fixed fee + 1:1 rate = $4,990
- **Scenario B**: 0.5% platform fee + $5 processing fee + 1:1 rate = $4,970
- **Result**: Scenario A is better by $20 (0.40%)

## 🔧 Configuration

### Default Values
- Base Amount: $1,000 USD
- Exchange Rates: 1.0
- Commission Percentage: 1.0%

### Limits
- Maximum Amount: $1 billion
- Commission Range: 0% - 100% (percentage) / $0+ (fixed amount)
- Unlimited scenarios (no save/load functionality)

## 📖 Documentation

For detailed implementation information, see:
- [Requirements Document](docs/requirements.md)
- [Development Plan](docs/plan.md)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙋‍♂️ Support

For support, email support@betterdeal.app or open an issue on GitHub.

---

Built with ❤️ using Flutter
