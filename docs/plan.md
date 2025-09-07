# Commission Comparison Calculator - Development Plan

## Project Overview
Building a Flutter mobile application that helps users compare different withdrawal/exchange scenarios with multiple commission structures. Both scenarios support dynamic commission management with percentage and fixed amount options.

## Development Phases

### **Phase 1: Foundation & Setup**

#### Task 1: Set up Flutter project structure and dependencies
- Initialize Flutter project
- Set up folder structure according to requirements:
  - `/lib/models/` - Data models for calculations
  - `/lib/screens/` - UI screens
  - `/lib/widgets/` - Reusable components
  - `/lib/services/` - Calculation logic
  - `/lib/providers/` - State management
- Add necessary dependencies (Provider/Riverpod, intl for currency formatting)

#### Task 2: Create data models for calculations
- `Amount` model for handling monetary values
- `Commission` model for commission steps (supporting both percentage and fixed amounts)
- `Scenario` model for comparison scenarios
- `ComparisonResult` model for results

#### Task 3: Implement calculation service
- **Both Scenarios**: Multi-step commission calculation supporting:
  - **Percentage Commission**: `Amount - (Amount × Commission%)`
  - **Fixed Commission**: `Amount - Fixed Commission Amount`
  - Final conversion: `Final Amount × Exchange Rate`
- Comparison logic to determine better option

#### Task 4: Set up state management
- Choose between Provider or Riverpod
- Create providers for:
  - Base amount state
  - Scenario A state (commissions list, final exchange rate)
  - Scenario B state (commissions list, final exchange rate)
  - Comparison results state

### **Phase 2: Core UI Development**

#### Task 5: Create main screen layout
- Material Design app structure
- Header with app title
- Base amount input field with validation
- Container for scenario cards

#### Task 6: Build Scenario A card
- Clean card layout
- Dynamic commission inputs with add/remove buttons
- Commission type toggle (percentage vs fixed amount)
- Final exchange rate input field
- Step-by-step calculation breakdown
- Real-time calculated result display

#### Task 7: Build Scenario B card
- Dynamic commission inputs with add/remove buttons
- Commission type toggle (percentage vs fixed amount)
- Final exchange rate input
- Step-by-step calculation breakdown display
- Final result display

#### Task 8: Implement comparison result display
- Visual indicators (colors, icons) showing better option
- Difference amount and percentage calculation
- Clear highlighting of preferred scenario

### **Phase 3: Enhanced Features**

#### Task 9: Add input validation and real-time updates
- Percentage validation (0-100%)
- Fixed amount validation (positive numbers)
- Amount validation (positive numbers)
- Real-time calculation updates on input change
- Error state handling for invalid inputs

#### Task 10: Implement currency formatting
- Support for different locales
- Currency symbol customization
- Proper decimal formatting
- Internationalization support

#### Task 11: Implement additional features
- **Export comparison results** (text, JSON, CSV)
- **Offline functionality**
- Commission type switching UI

### **Phase 4: Finalization**

#### Task 12: Add error handling and user feedback
- Comprehensive error handling
- User-friendly error messages
- Loading states for calculations
- Success/failure feedback
- Input hints and tooltips

#### Task 13: Testing and polish
- Unit tests for calculation logic
- Widget tests for UI components
- Integration tests for user flows
- Performance optimization
- UI/UX polish and refinements

## Technical Specifications

- **Framework**: Flutter with Dart
- **UI Design**: Material Design 3
- **State Management**: Provider or Riverpod
- **Architecture**: Clean architecture with separation of concerns
- **Testing**: Unit, Widget, and Integration tests
- **Platforms**: Android and iOS

## Key Features Delivered

- ✅ Two-scenario comparison (Both with multi-commission support)
- ✅ Dynamic commission step management
- ✅ Commission type switching (percentage vs fixed amount)
- ✅ Real-time calculations and validation
- ✅ Visual comparison indicators
- ✅ Currency formatting and localization
- ✅ Dark mode theme
- ✅ Export functionality
- ✅ Offline capability

## Success Criteria

- Users can easily input amounts and compare scenarios with different commission types
- Calculations are accurate for both percentage and fixed amount commissions
- UI is intuitive and follows Material Design guidelines (dark mode)
- App performs well on both Android and iOS
- Code is well-structured and maintainable
- Comprehensive test coverage