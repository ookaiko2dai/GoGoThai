import 'package:flutter/material.dart';
import '../models/trip_model.dart';

class AppState extends ChangeNotifier {
  // --- Category & Search ---
  DestinationCategory _selectedCategory = DestinationCategory.all;
  String _searchQuery = '';

  DestinationCategory get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  void setSelectedCategory(DestinationCategory category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // --- Mock Destinations ---
  final List<Destination> _destinations = [
    Destination(
      id: 'dest_1',
      title: 'เกาะกูด ทะเลน้ำใส vibe มัลดีฟส์เมืองไทย',
      province: 'ตราด',
      category: DestinationCategory.sea,
      rating: 4.9,
      reviewsCount: 382,
      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop&q=80',
      vibeEmoji: '🏝️',
      tags: ['น้ำใสระดับHD', 'พายคายัค', 'พระอาทิตย์ตกฟินๆ', 'สงบส่วนตัว'],
      description: 'เกาะที่ยังคงความธรรมชาติและเงียบสงบ เหมาะกับการมาพักผ่อน ชิลล์ริมหาดทรายขาวละเอียด มีทั้งสะพานไม้ยื่นลงทะเลและจุดพายซับบอร์ดสุดฮิต',
      estimatedBudget: 4500,
      bestTime: 'พ.ย. - เม.ย.',
      photoSpots: ['สะพานไม้อ่าวบางเบ้า', 'หาดคลองเจ้า', 'น้ำตกคลองเจ้า'],
      highlights: ['นอนเปลตาข่ายเหนือน้ำ', 'คาเฟ่ริมหาดมินิมอล', 'ดำน้ำดูปะการัง'],
      isFeatured: true,
    ),
    Destination(
      id: 'dest_2',
      title: 'ม่อนแจ่ม & แม่ริม รับลมหนาวกลางสายหมอก',
      province: 'เชียงใหม่',
      category: DestinationCategory.mountain,
      rating: 4.8,
      reviewsCount: 512,
      imageUrl: 'https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&auto=format&fit=crop&q=80',
      vibeEmoji: '⛰️',
      tags: ['ทะเลหมอก', 'ทุ่งดอกไม้', 'แคมป์ปิ้ง', 'อากาศเย็นสบาย'],
      description: 'จุดเช็คอินยอดฮิตของวัยรุ่น ฟินกับแปลงดอกเวอร์บีน่า กางเต็นท์โดมใสดูดาวตอนกลางคืน และกินหมูกระทะบนยอดดอย',
      estimatedBudget: 3200,
      bestTime: 'ต.ค. - ก.พ.',
      photoSpots: ['ยิ่งยงสวนดอกไม้', 'สกายวอล์คม่อนแจ่ม', 'สวนส้มยอดดอย'],
      highlights: ['กินหมูกระทะชมวิวหมอก', 'จิบกาแฟดริปตอนเช้า', 'เก็บส้มสดๆ จากต้น'],
      isFeatured: true,
    ),
    Destination(
      id: 'dest_3',
      title: 'อารีย์ & ประดิพัทธ์ คาเฟ่ฮอปปิ้งสายมินิมอล',
      province: 'กรุงเทพมหานคร',
      category: DestinationCategory.cafe,
      rating: 4.7,
      reviewsCount: 640,
      imageUrl: 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800&auto=format&fit=crop&q=80',
      vibeEmoji: '☕',
      tags: ['CafeHopping', 'มินิมอลคุมโทน', 'Photogenic', 'เบเกอรี่โฮมเมด'],
      description: 'ย่านสุดชิคที่เต็มไปด้วยคาเฟ่สไตล์เกาหลี ญี่ปุ่น และ specialty coffee มีมุมถ่ายรูปสตรีทและมุมแสงธรรมชาติสวยๆ เพียบ',
      estimatedBudget: 800,
      bestTime: 'ตลอดทั้งปี',
      photoSpots: ['Gump Ari Community Space', 'ซอยอารีย์สัมพันธ์ 5', 'มุมกำแพงสีพาสเทล'],
      highlights: ['มัทฉะเกรดพรีเมียม', 'ตู้สติกเกอร์ Y2K', 'เบเกอรี่สไตล์ฝรั่งเศส'],
      isFeatured: false,
    ),
    Destination(
      id: 'dest_4',
      title: 'อยุธยาเมืองเก่า นั่งเรือรับลม & คาเฟ่ริมน้ำ',
      province: 'พระนครศรีอยุธยา',
      category: DestinationCategory.culture,
      rating: 4.8,
      reviewsCount: 290,
      imageUrl: 'https://images.unsplash.com/photo-1563492065599-3520f775eeed?w=800&auto=format&fit=crop&q=80',
      vibeEmoji: '🏯',
      tags: ['วันเดย์ทริป', 'ใส่ชุดไทยถ่ายรูป', 'กุ้งแม่น้ำเผา', 'ขับรถแป๊บเดียว'],
      description: 'ทริปสั้น 1 วันใกล้กรุงเทพฯ ถ่ายรูปฟีลโมเดิร์นคลาสสิกกับโบราณสถาน จิบเครื่องดื่มชิลล์ๆ ในคาเฟ่ริมแม่น้ำเจ้าพระยา',
      estimatedBudget: 1200,
      bestTime: 'พ.ย. - มี.ค.',
      photoSpots: ['วัดไชยวัฒนาราม', 'พระราชวังบางปะอิน', 'ศาลาอยุธยา'],
      highlights: ['โรตีสายไหมเจ้าดัง', 'เช่าชุดไทยน่ารักๆ', 'ล่องเรือชมพระอาทิตย์ตก'],
      isFeatured: true,
    ),
    Destination(
      id: 'dest_5',
      title: 'เกาะล้าน พัทยา วันหยุดสั้นๆ ก็ชิลล์ได้',
      province: 'ชลบุรี',
      category: DestinationCategory.sea,
      rating: 4.6,
      reviewsCount: 820,
      imageUrl: 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&auto=format&fit=crop&q=80',
      vibeEmoji: '🛵',
      tags: ['ขี่มอเตอร์ไซค์รอบเกาะ', 'หาดเทียนห่านน้อย', 'บาร์ริมหาด', 'งบประหยัด'],
      description: 'เกาะยอดนิยมสำหรับแก๊งเพื่อน นั่งเรือจากแหลมบาลีฮายเพียง 30 นาที เช่ามอไซค์ขี่ชิลล์ๆ แวะถ่ายรูปกับน้องห่านริมหาดเทียน',
      estimatedBudget: 2000,
      bestTime: 'พ.ย. - พ.ค.',
      photoSpots: ['หาดเทียนจุดปล่อยห่าน', 'จุดชมวิวกังหันลม', 'หาดตายาย'],
      highlights: ['คาเฟ่บีชคลับฟิลบาหลี', 'หมูกระทะซีฟู้ดริมหาด', 'ซับบอร์ดใสถ่ายรูป'],
      isFeatured: false,
    ),
    Destination(
      id: 'dest_6',
      title: 'แคมป์ปิ้ง ลานสนเขากระโจม สวนผึ้ง',
      province: 'ราชบุรี',
      category: DestinationCategory.camping,
      rating: 4.7,
      reviewsCount: 195,
      imageUrl: 'https://images.unsplash.com/photo-1510312305653-8ed496efae75?w=800&auto=format&fit=crop&q=80',
      vibeEmoji: '⛺',
      tags: ['กางเต็นท์', 'นอนดูดาว', 'กาแฟแคมป์', 'ธรรมชาติบำบัด'],
      description: 'จุดกางเต็นท์ในป่าสนร่มรื่น สัมผัสอากาศบริสุทธิ์ ก่อกองไฟปิ้งมาร์ชเมลโลว์ ฟังเพลงอะคูสติกกับเพื่อนๆ',
      estimatedBudget: 1500,
      bestTime: 'พ.ย. - ก.พ.',
      photoSpots: ['ทิวป่าสนริมลำธาร', 'จุดชมพระอาทิตย์ขึ้น', 'สะพานแขวนธรรมชาติ'],
      highlights: ['ดริปกาแฟยามเช้า', 'ปิ้งบาร์บีคิวรอบกองไฟ', 'ทางช้างเผือกยามค่ำคืน'],
      isFeatured: false,
    ),
  ];

  List<Destination> get destinations {
    return _destinations.where((d) {
      final matchesCategory = _selectedCategory == DestinationCategory.all || d.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          d.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d.province.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d.tags.any((t) => t.toLowerCase().contains(_searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<Destination> get featuredDestinations =>
      _destinations.where((d) => d.isFeatured).toList();

  List<Destination> get favoriteDestinations =>
      _destinations.where((d) => d.isFavorite).toList();

  void toggleFavorite(String id) {
    final index = _destinations.indexWhere((d) => d.id == id);
    if (index != -1) {
      _destinations[index].isFavorite = !_destinations[index].isFavorite;
      notifyListeners();
    }
  }

  // --- Stories Mock Data ---
  final List<StoryItem> _stories = [
    StoryItem(
      id: 'story_1',
      userName: 'มายด์_travel',
      userAvatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80',
      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop&q=80',
      location: 'เกาะกูด, ตราด',
      vibe: 'น้ำใสมากทุกคนนน 🌊💖',
      isLive: true,
    ),
    StoryItem(
      id: 'story_2',
      userName: 'บีม_สายคาเฟ่',
      userAvatar: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150&auto=format&fit=crop&q=80',
      imageUrl: 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800&auto=format&fit=crop&q=80',
      location: 'Ari Alley, BKK',
      vibe: 'Matcha latte ร้านใหม่ปังมาก 🍵✨',
    ),
    StoryItem(
      id: 'story_3',
      userName: 'ต้นกล้า_แคมป์',
      userAvatar: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150&auto=format&fit=crop&q=80',
      imageUrl: 'https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&auto=format&fit=crop&q=80',
      location: 'ม่อนแจ่ม, เชียงใหม่',
      vibe: 'หมอกลง 18 องศา ฟินสุดๆ 🏔️❄️',
      isLive: true,
    ),
    StoryItem(
      id: 'story_4',
      userName: 'พลอย_roadtrip',
      userAvatar: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=150&auto=format&fit=crop&q=80',
      imageUrl: 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&auto=format&fit=crop&q=80',
      location: 'เกาะล้าน, พัทยา',
      vibe: 'ให้อาหารน้องห่าน 🪿🌤️',
    ),
    StoryItem(
      id: 'story_5',
      userName: 'กัปตัน_journey',
      userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80',
      imageUrl: 'https://images.unsplash.com/photo-1563492065599-3520f775eeed?w=800&auto=format&fit=crop&q=80',
      location: 'วัดไชยฯ, อยุธยา',
      vibe: 'แสงเย็นสวยสะกด 🏯🌅',
    ),
  ];

  List<StoryItem> get stories => _stories;

  // --- Community Feed Posts ---
  final List<CommunityPost> _communityPosts = [
    CommunityPost(
      id: 'post_1',
      authorName: 'ฟ้าใส พาเที่ยว',
      authorAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80',
      authorHandle: '@fah_wanderer',
      location: 'เกาะกูด, ตราด',
      timeAgo: '2 ชม. ที่แล้ว',
      content: 'แจกแพลนเที่ยวเกาะกูด 3 วัน 2 คืน ฉบับงบ 4,500 บาท รวมทุกอย่าง! น้ำใสเห็นตัวปลา ถ่ายรูปมุมไหนก็เกาหลีเกาใจมาก แนะนำช่วง 4 โมงเย็นแสงสะท้อนผิวน้ำระยิบระยับเลย ✨ ใครกำลังหาทริปฮีลใจเซฟไว้เลยยย 🏝️🧳',
      imageUrls: [
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800&auto=format&fit=crop&q=80',
      ],
      tags: ['#เกาะกูด', '#ทะเลตะวันออก', '#แจกแพลนเที่ยว', '#งบประหยัด'],
      likes: 1240,
      isLiked: false,
      commentsCount: 86,
      vibeEmoji: '🌴',
      budgetPerPerson: 4500,
    ),
    CommunityPost(
      id: 'post_2',
      authorName: 'เจมส์ & แก๊งแบกเป้',
      authorAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&auto=format&fit=crop&q=80',
      authorHandle: '@james_backpacker',
      location: 'ม่อนแจ่ม - แม่กำปอง, เชียงใหม่',
      timeAgo: '4 ชม. ที่แล้ว',
      content: '🚨 หาเพื่อนร่วมทริปเชียงใหม่-แม่กำปอง เสาร์-อาทิตย์หน้านี้! ตอนนี้มี 2 คน ขาดอีก 2 คนช่วยหารค่าน้ำมันรถเช่า + ค่าที่พักโฮมสเตย์ ริมลำธาร ใครชอบถ่ายรูป ฟีลสบายๆ ทักมาคุยกันได้เลยน้า 🚗💨',
      imageUrls: [
        'https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&auto=format&fit=crop&q=80',
      ],
      tags: ['#หาเพื่อนเที่ยว', '#หารค่าทริป', '#เชียงใหม่', '#แม่กำปอง'],
      likes: 452,
      isLiked: true,
      commentsCount: 34,
      vibeEmoji: '🚗',
      budgetPerPerson: 2800,
      findBuddyStatus: 'รับอีก 2 คน (ชาย/หญิง)',
    ),
    CommunityPost(
      id: 'post_3',
      authorName: 'มินิ สายชิม',
      authorAvatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80',
      authorHandle: '@mini_foodie',
      location: 'Ari Soi 4, Bangkok',
      timeAgo: '6 ชม. ที่แล้ว',
      content: 'ปักหมุดคาเฟ่เปิดใหม่สไตล์ Y2K โทนชมพูครีมมี่ 💖 ขนมเค้กสตอเบอรี่ช็อตเค้กอร่อยแสงออกปาก มีตู้ Photobooth กรอบน่ารักให้ถ่ายด้วย แนะนำมาช่วงบ่าย แสงตกกระทบหน้าร้านสวยมากกก 🍰📸',
      imageUrls: [
        'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800&auto=format&fit=crop&q=80',
      ],
      tags: ['#CafeAri', '#คาเฟ่กรุงเทพ', '#Y2KStyle', '#รีวิวของกิน'],
      likes: 890,
      isLiked: false,
      commentsCount: 42,
      vibeEmoji: '🍰',
      budgetPerPerson: 350,
    ),
  ];

  List<CommunityPost> get communityPosts => _communityPosts;

  void togglePostLike(String postId) {
    final index = _communityPosts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      final post = _communityPosts[index];
      post.isLiked = !post.isLiked;
      if (post.isLiked) {
        post.likes += 1;
      } else {
        post.likes -= 1;
      }
      notifyListeners();
    }
  }

  void togglePostSave(String postId) {
    final index = _communityPosts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      _communityPosts[index].isSaved = !_communityPosts[index].isSaved;
      notifyListeners();
    }
  }

  void addCommunityPost({
    required String content,
    required String location,
    required List<String> tags,
    int? budget,
    String? buddyStatus,
    String vibeEmoji = '✨',
  }) {
    final newPost = CommunityPost(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      authorName: 'คุณ (Me)',
      authorAvatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80',
      authorHandle: '@me_gogothai',
      location: location.isEmpty ? 'Thailand' : location,
      timeAgo: 'เมื่อสักครู่',
      content: content,
      imageUrls: [
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop&q=80',
      ],
      tags: tags.isEmpty ? ['#GoGoThai'] : tags,
      likes: 1,
      isLiked: true,
      commentsCount: 0,
      vibeEmoji: vibeEmoji,
      budgetPerPerson: budget,
      findBuddyStatus: buddyStatus,
    );
    _communityPosts.insert(0, newPost);
    notifyListeners();
  }

  // --- Expense Split & Trips Mock Data ---
  final List<TripMember> _tripMembers = [
    TripMember(
      id: 'm1',
      name: 'คุณ (Me)',
      avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&auto=format&fit=crop&q=80',
      promptPayNumber: '089-123-4567',
      promptPayName: 'สมใจ ไปเที่ยว',
    ),
    TripMember(
      id: 'm2',
      name: 'แพรวา',
      avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80',
      promptPayNumber: '081-987-6543',
      promptPayName: 'แพรวา ใจดี',
    ),
    TripMember(
      id: 'm3',
      name: 'นนท์',
      avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80',
      promptPayNumber: '086-456-7890',
      promptPayName: 'ชานนท์ มิตรแท้',
    ),
    TripMember(
      id: 'm4',
      name: 'เจมส์',
      avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&auto=format&fit=crop&q=80',
      promptPayNumber: '095-321-6549',
      promptPayName: 'จิรายุ บินเดี่ยว',
    ),
  ];

  late TripGroup _activeTrip;

  TripGroup get activeTrip => _activeTrip;
  List<TripMember> get tripMembers => _tripMembers;

  AppState() {
    _activeTrip = TripGroup(
      id: 'trip_cnxbuddy',
      title: 'ทริปเชียงใหม่-ม่อนแจ่ม เดอะแก๊ง 4 คน',
      location: 'เชียงใหม่, ไทย',
      bannerUrl: 'https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&auto=format&fit=crop&q=80',
      totalBudget: 16000,
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(days: 2)),
      members: _tripMembers,
      expenses: [
        ExpenseItem(
          id: 'exp_1',
          title: 'ที่พัก ม่อนแจ่มโดมใส 2 คืน',
          amount: 4800,
          category: ExpenseCategory.stay,
          paidBy: 'm1', // Me
          splitWith: ['m1', 'm2', 'm3', 'm4'],
          dateTime: DateTime.now().subtract(const Duration(days: 1)),
          note: 'รวมอาหารเช้าและชุดหมูกระทะ',
        ),
        ExpenseItem(
          id: 'exp_2',
          title: 'ค่าเช่ารถยนต์ Yaris Cross + ประกัน',
          amount: 3200,
          category: ExpenseCategory.transport,
          paidBy: 'm3', // นนท์
          splitWith: ['m1', 'm2', 'm3', 'm4'],
          dateTime: DateTime.now().subtract(const Duration(hours: 18)),
          note: 'รับรถที่สนามบินเชียงใหม่',
        ),
        ExpenseItem(
          id: 'exp_3',
          title: 'มื้อเย็น ข้าวซอยแม่สาย & ไส้อั่ว',
          amount: 960,
          category: ExpenseCategory.food,
          paidBy: 'm2', // แพรวา
          splitWith: ['m1', 'm2', 'm3', 'm4'],
          dateTime: DateTime.now().subtract(const Duration(hours: 14)),
        ),
        ExpenseItem(
          id: 'exp_4',
          title: 'คาเฟ่ Fleur Cafe & Eatery',
          amount: 840,
          category: ExpenseCategory.cafe,
          paidBy: 'm4', // เจมส์
          splitWith: ['m1', 'm2', 'm3', 'm4'],
          dateTime: DateTime.now().subtract(const Duration(hours: 4)),
          note: 'เค้ก 3 ชิ้น เครื่องดื่ม 4 แก้ว',
        ),
        ExpenseItem(
          id: 'exp_5',
          title: 'ค่าน้ำมัน ปตท. แม่ริม',
          amount: 1100,
          category: ExpenseCategory.transport,
          paidBy: 'm1', // Me
          splitWith: ['m1', 'm2', 'm3', 'm4'],
          dateTime: DateTime.now().subtract(const Duration(hours: 2)),
        ),
      ],
    );
  }

  void addExpense({
    required String title,
    required double amount,
    required ExpenseCategory category,
    required String paidById,
    required List<String> splitWithIds,
    String? note,
  }) {
    final newExp = ExpenseItem(
      id: 'exp_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      amount: amount,
      category: category,
      paidBy: paidById,
      splitWith: splitWithIds,
      dateTime: DateTime.now(),
      note: note,
    );
    _activeTrip.expenses.insert(0, newExp);
    notifyListeners();
  }

  void deleteExpense(String id) {
    _activeTrip.expenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // Calculate balances: for each member, calculate total paid minus total share
  Map<String, double> get memberBalances {
    final balances = <String, double>{};
    for (var m in _activeTrip.members) {
      balances[m.id] = 0.0;
    }

    for (var exp in _activeTrip.expenses) {
      // Payer gets + amount
      balances[exp.paidBy] = (balances[exp.paidBy] ?? 0) + exp.amount;

      // Each consumer pays their share
      final share = exp.amount / exp.splitWith.length;
      for (var consumerId in exp.splitWith) {
        balances[consumerId] = (balances[consumerId] ?? 0) - share;
      }
    }
    return balances;
  }

  // --- Camera & Memories ---
  String _selectedFilter = 'Normal';
  final List<String> _cameraFilters = [
    'Normal',
    '📸 Film Y2K',
    '🌅 Golden Sunset',
    '☕ Warm Cafe',
    '🌊 Teal Ocean',
    '🧋 Pastel Pink',
    '🌿 Mint Green',
  ];

  List<String> get cameraFilters => _cameraFilters;
  String get selectedFilter => _selectedFilter;

  void setSelectedFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  final List<MemoryMedia> _memories = [
    MemoryMedia(
      id: 'mem_1',
      url: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop&q=80',
      title: 'เช้าวันแรกที่เกาะกูด น้ำใสมากก',
      location: 'เกาะกูด, ตราด',
      date: '6 ต.ค. 2026',
      filterUsed: '🌊 Teal Ocean',
      stickers: ['🏝️', '💖', '✨'],
    ),
    MemoryMedia(
      id: 'mem_2',
      url: 'https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&auto=format&fit=crop&q=80',
      title: 'หมอกยามเช้าหน้าเต็นท์โดม',
      location: 'ม่อนแจ่ม, เชียงใหม่',
      date: '5 ต.ค. 2026',
      filterUsed: '📸 Film Y2K',
      stickers: ['❄️', '☕', '🏕️'],
    ),
    MemoryMedia(
      id: 'mem_3',
      url: 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800&auto=format&fit=crop&q=80',
      title: 'มุมแสงบ่ายร้านกาแฟ',
      location: 'อารีย์, กรุงเทพฯ',
      date: '3 ต.ค. 2026',
      filterUsed: '☕ Warm Cafe',
      stickers: ['🍰', '✨'],
    ),
    MemoryMedia(
      id: 'mem_4',
      url: 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&auto=format&fit=crop&q=80',
      title: 'น้องห่านเดินเล่นริมหาดเทียน',
      location: 'เกาะล้าน, พัทยา',
      date: '28 ก.ย. 2026',
      filterUsed: '🌅 Golden Sunset',
      stickers: ['🪿', '🏖️'],
    ),
  ];

  List<MemoryMedia> get memories => _memories;

  void addMemoryPhoto({
    required String title,
    required String location,
    String? customUrl,
  }) {
    final newMem = MemoryMedia(
      id: 'mem_${DateTime.now().millisecondsSinceEpoch}',
      url: customUrl ?? 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop&q=80',
      title: title.isEmpty ? 'ความทรงจำใหม่ 📸' : title,
      location: location.isEmpty ? 'ประเทศไทย' : location,
      date: 'วันนี้',
      filterUsed: _selectedFilter,
      stickers: ['✨', '💖'],
    );
    _memories.insert(0, newMem);
    notifyListeners();
  }

  // --- Passport Badges ---
  final List<PassportBadge> _badges = [
    PassportBadge(
      id: 'badge_1',
      title: 'นักล่าหมอกยอดดอย',
      subtitle: 'เช็คอินดอยสูง 5 แห่ง',
      iconEmoji: '🏔️',
      province: 'ภาคเหนือ',
      unlockedDate: 'ปลดล็อกแล้ว',
      color: Color(0xFF4ECDC4),
    ),
    PassportBadge(
      id: 'badge_2',
      title: 'คาเฟ่ฮอปปิ้งตัวแม่',
      subtitle: 'เช็คอิน 20 คาเฟ่เก๋',
      iconEmoji: '☕',
      province: 'กรุงเทพฯ',
      unlockedDate: 'ปลดล็อกแล้ว',
      color: Color(0xFFFF6B6B),
    ),
    PassportBadge(
      id: 'badge_3',
      title: 'เจ้าสมุทรเกาะใต้',
      subtitle: 'ข้ามเกาะน้ำใส 3 เกาะ',
      iconEmoji: '🏝️',
      province: 'ภาคใต้/ตะวันออก',
      unlockedDate: 'ปลดล็อกแล้ว',
      color: Color(0xFF00BBF9),
    ),
    PassportBadge(
      id: 'badge_4',
      title: 'นักหารบิลมือโปร',
      subtitle: 'เคลียร์บิลทริปครบ 10 ครั้ง',
      iconEmoji: '🧾',
      province: 'ทุกทริป',
      unlockedDate: 'ปลดล็อกแล้ว',
      color: Color(0xFFFFD166),
    ),
  ];

  List<PassportBadge> get badges => _badges;
}
