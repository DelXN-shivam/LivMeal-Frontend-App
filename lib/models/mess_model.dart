class MessModel {
  final String id;
  final String messName;
  final String messOwnerName;
  final String email;
  final String contact;
  final String messAddress;
  final String mealTypes;
  final bool deliveryAvailable;
  final List<String> photos;
  final String isVerified;
  final MessTimings messTimings;
  final List<Subscription> subscription;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessModel({
    required this.id,
    required this.messName,
    required this.messOwnerName,
    required this.email,
    required this.contact,
    required this.messAddress,
    required this.mealTypes,
    required this.deliveryAvailable,
    required this.photos,
    required this.isVerified,
    required this.messTimings,
    required this.subscription,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessModel.fromJson(Map<String, dynamic> json) {
    return MessModel(
      id: json['_id'] ?? '',
      messName: json['messName'] ?? '',
      messOwnerName: json['messOwnerName'] ?? '',
      email: json['email'] ?? '',
      contact: json['contact'] ?? '',
      messAddress: json['messAddress'] ?? '',
      mealTypes: json['mealTypes'] ?? '',
      deliveryAvailable: json['deliveryAvailable'] ?? false,
      photos: List<String>.from(json['photos'] ?? []),
      isVerified: json['isVerified'] ?? 'pending',
      messTimings: MessTimings.fromJson(json['messTimings'] ?? {}),
      subscription:
          (json['subscription'] as List<dynamic>?)
              ?.map((sub) => Subscription.fromJson(sub))
              .toList() ??
          [],
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  // Helper method to get formatted meal type
  String get mealTypeDisplay {
    switch (mealTypes.toLowerCase()) {
      case 'veg':
        return 'Pure Veg';
      case 'non-veg':
        return 'Non-Veg';
      case 'both':
        return 'Veg & Non-Veg';
      default:
        return mealTypes;
    }
  }

  // Helper method to get verification status display
  String get verificationStatusDisplay {
    switch (isVerified.toLowerCase()) {
      case 'verified':
        return 'Verified';
      case 'pending':
        return 'Pending Verification';
      case 'rejected':
        return 'Not Verified';
      default:
        return isVerified;
    }
  }

  // Helper method to get daily meal price
  double get dailyMealPrice {
    if (subscription.isNotEmpty) {
      return subscription.first.dailyMealPrice;
    }
    return 0.0;
  }

  // Helper method to get monthly meal price
  double get monthlyMealPrice {
    if (subscription.isNotEmpty) {
      return subscription.first.monthlyMealPrice;
    }
    return 0.0;
  }
}

class MessTimings {
  final MealTiming breakfast;
  final MealTiming lunch;
  final MealTiming dinner;

  MessTimings({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  factory MessTimings.fromJson(Map<String, dynamic> json) {
    return MessTimings(
      breakfast: MealTiming.fromJson(json['breakfast'] ?? {}),
      lunch: MealTiming.fromJson(json['lunch'] ?? {}),
      dinner: MealTiming.fromJson(json['dinner'] ?? {}),
    );
  }
}

class MealTiming {
  final String from;
  final String to;

  MealTiming({required this.from, required this.to});

  factory MealTiming.fromJson(Map<String, dynamic> json) {
    return MealTiming(from: json['from'] ?? '', to: json['to'] ?? '');
  }

  String get displayTime {
    if (from.isEmpty || to.isEmpty) return 'Not specified';
    return '$from - $to';
  }
}

class Subscription {
  final double dailyMealPrice;
  final double weeklyMealPrice;
  final double monthlyMealPrice;
  final double trialMealPrice;
  final bool onGoingDiscount;
  final String discountOffer;
  final String id;

  Subscription({
    required this.dailyMealPrice,
    required this.weeklyMealPrice,
    required this.monthlyMealPrice,
    required this.trialMealPrice,
    required this.onGoingDiscount,
    required this.discountOffer,
    required this.id,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      dailyMealPrice: (json['dailyMealPrice'] ?? 0).toDouble(),
      weeklyMealPrice: (json['weeklyMealPrice'] ?? 0).toDouble(),
      monthlyMealPrice: (json['monthlyMealPrice'] ?? 0).toDouble(),
      trialMealPrice: (json['trialMealPrice'] ?? 0).toDouble(),
      onGoingDiscount: json['onGoingDiscount'] ?? false,
      discountOffer: json['discountOffer'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}

class MessApiResponse {
  final String message;
  final List<MessModel> data;

  MessApiResponse({required this.message, required this.data});

  factory MessApiResponse.fromJson(Map<String, dynamic> json) {
    return MessApiResponse(
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((mess) => MessModel.fromJson(mess))
              .toList() ??
          [],
    );
  }
}
