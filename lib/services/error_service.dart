import 'package:flutter/material.dart';

enum ErrorType {
  validation,
  calculation,
  storage,
  export,
  network,
  unknown,
}

class AppError {
  final ErrorType type;
  final String message;
  final String? userMessage;
  final String? suggestion;
  final DateTime timestamp;

  AppError({
    required this.type,
    required this.message,
    this.userMessage,
    this.suggestion,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() => 'AppError($type): $message';
}

class ErrorService {
  static void showError(BuildContext context, AppError error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              error.userMessage ?? error.message,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (error.suggestion != null) ...[
              const SizedBox(height: 4),
              Text(
                error.suggestion!,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Theme.of(context).colorScheme.onError,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.info,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showWarning(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.warning,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  static AppError createValidationError(String field, String issue) {
    return AppError(
      type: ErrorType.validation,
      message: 'Validation error in $field: $issue',
      userMessage: 'Invalid $field',
      suggestion: 'Please check your input and try again.',
    );
  }

  static AppError createCalculationError(String details) {
    return AppError(
      type: ErrorType.calculation,
      message: 'Calculation error: $details',
      userMessage: 'Unable to perform calculation',
      suggestion: 'Please verify all inputs are valid numbers.',
    );
  }

  static AppError createStorageError(String operation) {
    return AppError(
      type: ErrorType.storage,
      message: 'Storage error during $operation',
      userMessage: 'Failed to $operation',
      suggestion: 'Please try again. If the problem persists, restart the app.',
    );
  }

  static AppError createExportError(String format) {
    return AppError(
      type: ErrorType.export,
      message: 'Export error for format: $format',
      userMessage: 'Failed to export as $format',
      suggestion: 'Please try a different format or check your device storage.',
    );
  }

  static AppError createUnknownError(String details) {
    return AppError(
      type: ErrorType.unknown,
      message: 'Unknown error: $details',
      userMessage: 'Something went wrong',
      suggestion: 'Please try again or restart the app.',
    );
  }

  static void handleAsyncError(BuildContext context, Future<void> Function() operation, {
    String? operationName,
    String? successMessage,
  }) async {
    try {
      await operation();
      if (successMessage != null && context.mounted) {
        showSuccess(context, successMessage);
      }
    } catch (e) {
      if (context.mounted) {
        final error = createUnknownError(e.toString());
        showError(context, error);
      }
    }
  }

  static Widget buildErrorBoundary({
    required Widget child,
    Widget? fallback,
  }) {
    return Builder(
      builder: (context) {
        return child;
      },
    );
  }
}