import 'package:flutter/material.dart';

enum DestinationCategory {
  all,
  sea,
  mountain,
  cafe,
  culture,
  roadtrip,
  camping,
}

class Destination {
  final String id;
  final String title;
  final String province;
  final DestinationCategory category;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final String vibeEmoji;
  final List<String> tags;
  final String description;
  final int estimatedBudget;
  final String bestTime;
  final List<String> photoSpots;
  final List<String> highlights;
  final bool isFeatured;
  bool isFavorite;

  Destination({
    required this.id,
    required this.title,
    required this.province,
    required this.category,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.vibeEmoji,
    required this.tags,
    required this.description,
    required this.estimatedBudget,
    required this.bestTime,
    required this.photoSpots,
    required this.highlights,
    this.isFeatured = false,
    this.isFavorite = false,
  });
}

class CommunityPost {
  final String id;
  final String authorName;
  final String authorAvatar;
  final String authorHandle;
  final String location;
  final String timeAgo;
  final String content;
  final List<String> imageUrls;
  final List<String> tags;
  int likes;
  bool isLiked;
  final int commentsCount;
  bool isSaved;
  final String vibeEmoji;
  final int? budgetPerPerson;
  final String? findBuddyStatus; // e.g. "รับ 2 คน ชาย/หญิง", "หารค่าน้ำมัน"

  CommunityPost({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.authorHandle,
    required this.location,
    required this.timeAgo,
    required this.content,
    required this.imageUrls,
    required this.tags,
    required this.likes,
    this.isLiked = false,
    required this.commentsCount,
    this.isSaved = false,
    required this.vibeEmoji,
    this.budgetPerPerson,
    this.findBuddyStatus,
  });
}

class StoryItem {
  final String id;
  final String userName;
  final String userAvatar;
  final String imageUrl;
  final String location;
  final String vibe;
  final bool isLive;

  StoryItem({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.imageUrl,
    required this.location,
    required this.vibe,
    this.isLive = false,
  });
}

enum ExpenseCategory {
  food,
  stay,
  transport,
  cafe,
  activity,
  shopping,
  other,
}

class ExpenseItem {
  final String id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final String paidBy;
  final List<String> splitWith;
  final DateTime dateTime;
  final String? note;

  ExpenseItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.paidBy,
    required this.splitWith,
    required this.dateTime,
    this.note,
  });
}

class TripMember {
  final String id;
  final String name;
  final String avatar;
  final String promptPayNumber;
  final String promptPayName;

  TripMember({
    required this.id,
    required this.name,
    required this.avatar,
    required this.promptPayNumber,
    required this.promptPayName,
  });
}

class TripGroup {
  final String id;
  final String title;
  final String location;
  final String bannerUrl;
  final double totalBudget;
  final DateTime startDate;
  final DateTime endDate;
  final List<TripMember> members;
  final List<ExpenseItem> expenses;

  TripGroup({
    required this.id,
    required this.title,
    required this.location,
    required this.bannerUrl,
    required this.totalBudget,
    required this.startDate,
    required this.endDate,
    required this.members,
    required this.expenses,
  });

  double get totalSpent => expenses.fold(0, (sum, item) => sum + item.amount);
}

class MemoryMedia {
  final String id;
  final String url;
  final bool isVideo;
  final String title;
  final String location;
  final String date;
  final String filterUsed;
  final List<String> stickers;

  MemoryMedia({
    required this.id,
    required this.url,
    this.isVideo = false,
    required this.title,
    required this.location,
    required this.date,
    required this.filterUsed,
    this.stickers = const [],
  });
}

class PassportBadge {
  final String id;
  final String title;
  final String subtitle;
  final String iconEmoji;
  final String province;
  final String unlockedDate;
  final Color color;

  PassportBadge({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconEmoji,
    required this.province,
    required this.unlockedDate,
    required this.color,
  });
}
