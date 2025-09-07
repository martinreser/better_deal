# Commission Comparison Calculator App

Create a Flutter mobile application using Dart that helps users compare different withdrawal/exchange scenarios with multiple commission structures.

## Core Functionality

The app should allow users to:

1. **Input a base amount** (e.g., $1000 USD)
2. **Compare two different scenarios:**
   - **Scenario A**: Multi-commission process with final conversion
   - **Scenario B**: Multi-commission process with final conversion

### Scenario A (Multi-Commission Process)

- Input: Base amount in USD
- Input: Commission 1 - can be percentage (e.g., 1%) or fixed amount (e.g., $5)
- Input: Commission 2 - can be percentage (e.g., 1%) or fixed amount (e.g., $5)
- Input: Additional commissions (allow adding more)
- Input: Final exchange rate after all commissions
- Output: Final amount after all commissions and conversion

### Scenario B (Multi-Commission Process)

- Input: Base amount in USD
- Input: Commission 1 - can be percentage (e.g., 1%) or fixed amount (e.g., $5)
- Input: Commission 2 - can be percentage (e.g., 1%) or fixed amount (e.g., $5)
- Input: Additional commissions (allow adding more)
- Input: Final exchange rate after all commissions
- Output: Final amount after all commissions and conversion

## Technical Requirements

- **Framework**: Flutter with Dart
- **UI Design**: Clean, modern Material Design (Dark mode only)
- **Architecture**: Use proper state management (Provider or Riverpod)
- **Features needed**:
  - Input validation for percentages, fixed amounts, and base amounts
  - Real-time calculation updates
  - Clear comparison display showing which option is better
  - Ability to add/remove commission steps dynamically
  - Toggle between percentage and fixed amount commissions
  - Currency formatting for different locales

## User Interface Requirements

1. **Main Screen**:

   - Header with app title
   - Base amount input field
   - Two comparison cards side by side or stacked

2. **Scenario A Card**:

   - Dynamic list of commission inputs with add/remove buttons
   - Commission type toggle (percentage vs fixed amount)
   - Final exchange rate input
   - Step-by-step calculation breakdown
   - Final result display

3. **Scenario B Card**:

   - Dynamic list of commission inputs with add/remove buttons
   - Commission type toggle (percentage vs fixed amount)
   - Final exchange rate input
   - Step-by-step calculation breakdown
   - Final result display

4. **Comparison Result**:
   - Highlight which scenario gives better value
   - Show difference amount and percentage
   - Visual indicators (colors, icons)

## Calculation Logic

For both scenarios, the calculation should work as:

**Percentage Commission:**
```
Step 1: Base Amount - (Base Amount × Commission 1%)
Step 2: Result from Step 1 - (Result × Commission 2%)
Step N: Continue for all commissions
Final: Final Amount × Exchange Rate
```

**Fixed Amount Commission:**
```
Step 1: Base Amount - Commission 1 (fixed $)
Step 2: Result from Step 1 - Commission 2 (fixed $)
Step N: Continue for all commissions
Final: Final Amount × Exchange Rate
```

## Additional Features

- Currency symbol customization
- Export comparison results
- Offline functionality

## File Structure

Organize the code with:

- `/lib/models/` - Data models for calculations
- `/lib/screens/` - UI screens
- `/lib/widgets/` - Reusable components
- `/lib/services/` - Calculation logic
- `/lib/providers/` - State management
- Proper error handling and user feedback

Create a professional, user-friendly app that makes it easy to understand complex commission structures and make informed financial decisions.
