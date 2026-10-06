import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/community_post_card.dart';
import '../widgets/create_post_sheet.dart';
import '../widgets/story_bubble.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final stories = appState.stories;
    final posts = appState.communityPosts;

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (ctx) => const CreatePostSheet(),
            );
          },
          elevation: 4,
          backgroundColor: AppColors.primary,
          icon: const Icon(Icons.edit_note_rounded, color: Colors.white),
          label: Text(
            'เขียนรีวิว / หาเพื่อน',
            style: GoogleFonts.prompt(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Community',
                              style: GoogleFonts.prompt(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textMain,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text('💬', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        Text(
                          'ฟีดรีวิววัยรุ่น แลกเปลี่ยนพิกัดลับ & หาเพื่อนหารทริป',
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
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.filter_list_rounded, color: AppColors.textMain),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('กำลังแสดงโพสต์แนะนำยอดนิยม ✨'),
                              backgroundColor: AppColors.mint,
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

            // 24h Stories Bar
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: Row(
                      children: [
                        Text(
                          '📸 สตอรี่ทริปสด 24 ชม.',
                          style: GoogleFonts.prompt(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textMain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 105,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: stories.length,
                      itemBuilder: (ctx, i) => StoryBubble(story: stories[i]),
                    ),
                  ),
                ],
              ),
            ),

            const SliverToBoxAdapter(
              child: Divider(color: AppColors.border, height: 24, thickness: 1, indent: 20, endIndent: 20),
            ),

            // Posts List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => CommunityPostCard(post: posts[i]),
                  childCount: posts.length,
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
}
