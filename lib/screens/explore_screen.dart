import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/trip_model.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/destination_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final featured = appState.featuredDestinations;
    final allList = appState.destinations;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text('🌴', style: TextStyle(fontSize: 22)),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'GoGo',
                              style: GoogleFonts.prompt(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              'Thai',
                              style: GoogleFonts.prompt(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textMain,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.pinkLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'CUTE',
                                style: GoogleFonts.prompt(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.pink,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'เที่ยวไทยสไตล์วัยรุ่น ฮีลใจไปกับแก๊ง ✨',
                          style: GoogleFonts.prompt(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textMain),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('ยังไม่มีการแจ้งเตือนใหม่ 🔔'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                child: TextField(
                  onChanged: (val) => appState.setSearchQuery(val),
                  decoration: InputDecoration(
                    hintText: 'ค้นหาที่เที่ยว, จังหวัด, หรือ vibe เช่น เกาะกูด, ดอย...',
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
                    suffixIcon: appState.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () => appState.setSearchQuery(''),
                          )
                        : null,
                  ),
                ),
              ),
            ),

            // Category Chips
            SliverToBoxAdapter(
              child: SizedBox(
                height: 46,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildCategoryChip(context, DestinationCategory.all, '✨ ทั้งหมด', appState),
                    _buildCategoryChip(context, DestinationCategory.sea, '🏝️ ทะเลใส', appState),
                    _buildCategoryChip(context, DestinationCategory.mountain, '⛰️ ภูเขา/หมอก', appState),
                    _buildCategoryChip(context, DestinationCategory.cafe, '☕ คาเฟ่ฮอปปิ้ง', appState),
                    _buildCategoryChip(context, DestinationCategory.culture, '🏯 วัฒนธรรม', appState),
                    _buildCategoryChip(context, DestinationCategory.camping, '⛺ แคมป์ปิ้ง', appState),
                  ],
                ),
              ),
            ),

            // Featured Trips (Horizontal Slider)
            if (appState.searchQuery.isEmpty && appState.selectedCategory == DestinationCategory.all) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Row(
                    children: [
                      Text(
                        '🔥 ทริปฮิตติดกระแส',
                        style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textMain,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'ดูทั้งหมด',
                        style: GoogleFonts.prompt(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 285,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: featured.length,
                    separatorBuilder: (ctx, i) => const SizedBox(width: 16),
                    itemBuilder: (ctx, i) => DestinationCard(
                      destination: featured[i],
                      isLarge: true,
                    ),
                  ),
                ),
              ),
            ],

            // All Destinations Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Text(
                  '📍 ปักหมุดที่เที่ยวแนะนำ (${allList.length})',
                  style: GoogleFonts.prompt(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMain,
                  ),
                ),
              ),
            ),

            // Destinations List
            if (allList.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      const Text('🔍', style: TextStyle(fontSize: 48)),
                      const SizedBox(height: 12),
                      Text(
                        'ไม่พบสถานที่ที่คุณค้นหา',
                        style: GoogleFonts.prompt(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMain,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'ลองค้นหาด้วยคำอื่น หรือเลือกหมวดหมู่อื่นดูน้า',
                        style: GoogleFonts.prompt(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: DestinationCard(destination: allList[i]),
                    ),
                    childCount: allList.length,
                  ),
                ),
              ),

            // Bottom space for floating nav bar
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    DestinationCategory category,
    String label,
    AppState appState,
  ) {
    final isSelected = appState.selectedCategory == category;
    return GestureDetector(
      onTap: () => appState.setSelectedCategory(category),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.prompt(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textMain,
          ),
        ),
      ),
    );
  }
}
