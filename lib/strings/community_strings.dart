import './string_provider.dart' show Language;

// Community specific strings for widget texts etc

class LocalizedCommunityStrings {
  // FIN
  static const String sellFI = "Myy";
  static const String buyFI = "Osta";
  static const String browseFI = "Selaa";
  static const String allFI = "Kaikki";
  static const String contactFI = "Ota yhteyttä";
  static const String buyingFI = "Ostetaan";
  static const String sellingFI = "Myydään";
  static const String freeFI = "Ilmainen";
  static const String offerFI = "Tarjoa";
  static const String askFI = "Pyydä";
  static const String offeringFI = "Tarjotaan";
  static const String askingFI = "Pyydetään";
  static const String todayFI = "Tänään";
  static const String tomorrowFI = "Huomenna";
  static const String yesterdayFI = "Eilen";
  static const String fromFI = "Mistä";
  static const String destinationFI = "Minne";

  // ENG
  static const String sellEN = "Sell";
  static const String buyEN = "Buy";
  static const String browseEN = "Browse";
  static const String allEN = "All";
  static const String contactEN = "Contact";
  static const String buyingEN = "Buying";
  static const String sellingEN = "Selling";
  static const String freeEN = "Free";
  static const String offerEN = "Offer";
  static const String askEN = "Ask";
  static const String offeringEN = "Offering";
  static const String askingEN = "Asking";
  static const String todayEN = "Today";
  static const String tomorrowEN = "Tomorrow";
  static const String yesterdayEN = "Yesterday";
  static const String fromEN = "From";
  static const String destinationEN = "To";

  static String sellToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return sellFI;
        break;
      case Language.EN:
        return sellEN;
        break;
      default:
        return sellEN;
        break;
    }
  }

  static String buyToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return buyFI;
        break;
      case Language.EN:
        return buyEN;
        break;
      default:
        return buyEN;
        break;
    }
  }

  static String browseToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return browseFI;
        break;
      case Language.EN:
        return browseEN;
        break;
      default:
        return browseEN;
        break;
    }
  }

  static String allToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return allFI;
        break;
      case Language.EN:
        return allEN;
        break;
      default:
        return allEN;
        break;
    }
  }

  static String contactToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return contactFI;
        break;
      case Language.EN:
        return contactEN;
        break;
      default:
        return contactEN;
        break;
    }
  }

  static String buyingToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return buyingFI;
        break;
      case Language.EN:
        return buyingEN;
        break;
      default:
        return buyingEN;
        break;
    }
  }

  static String sellingToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return sellingFI;
        break;
      case Language.EN:
        return sellingEN;
        break;
      default:
        return sellingEN;
        break;
    }
  }

  static String freeToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return freeFI;
        break;
      case Language.EN:
        return freeEN;
        break;
      default:
        return freeEN;
        break;
    }
  }

  static String offerToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return offerFI;
        break;
      case Language.EN:
        return offerEN;
        break;
      default:
        return offerEN;
        break;
    }
  }

  static String askToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return askFI;
        break;
      case Language.EN:
        return askEN;
        break;
      default:
        return askEN;
        break;
    }
  }

  static String offeringToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return offeringFI;
        break;
      case Language.EN:
        return offeringEN;
        break;
      default:
        return offeringEN;
        break;
    }
  }

  static String askingToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return askingFI;
        break;
      case Language.EN:
        return askingEN;
        break;
      default:
        return askingEN;
        break;
    }
  }

  static String todayToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return todayFI;
        break;
      case Language.EN:
        return todayEN;
        break;
      default:
        return todayEN;
        break;
    }
  }

  static String tomorrowToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return tomorrowFI;
        break;
      case Language.EN:
        return tomorrowEN;
        break;
      default:
        return tomorrowEN;
        break;
    }
  }

  static String yesterdayToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return yesterdayFI;
        break;
      case Language.EN:
        return yesterdayEN;
        break;
      default:
        return yesterdayEN;
        break;
    }
  }

  static String fromToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return fromFI;
        break;
      case Language.EN:
        return fromEN;
        break;
      default:
        return fromEN;
        break;
    }
  }

  static String destinationToLocalized(Language target) {
    switch (target) {
      case Language.FI:
        return destinationFI;
        break;
      case Language.EN:
        return destinationEN;
        break;
      default:
        return destinationEN;
        break;
    }
  }

  static String dateTimeToLocaleString(DateTime date, Language target) {
    String format = localizeDateFormat(date, target);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return format + " (${todayToLocalized(target)})";
    } else if (date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day) {
      return format + " (${tomorrowToLocalized(target)})";
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return format + " (${yesterdayToLocalized(target)})";
    } else {
      return format;
    }
  }

  static String localizeDateFormat(DateTime date, Language target) {
    switch (target) {
      case Language.FI:
        return "${date.day}.${date.month}.${date.year}";
        break;
      case Language.EN:
        return "${date.month}/${date.day}/${date.year}";
        break;
      default:
        return "${date.month}/${date.day}/${date.year}";
        break;
    }
  }
}