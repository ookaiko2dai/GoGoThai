import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/trip_model.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class CommunityPostCard extends StatelessWidget {
  final CommunityPost post;

  const CommunityPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(post.authorAvatar),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.authorName,
                            style: GoogleFonts.prompt(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textMain,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            post.vibeEmoji,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 12, color: AppColors.primary),
                          const SizedBox(width: 2),
                          Text(
                            post.location,
                            style: GoogleFonts.prompt(
                              fontSize: 11,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            ' • ${post.timeAgo}',
                            style: GoogleFonts.prompt(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (post.findBuddyStatus != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.mintLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.mint.withValues(alpha: 0.5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.group_add_rounded, size: 12, color: AppColors.mint),
                        const SizedBox(width: 4),
                        Text(
                          post.findBuddyStatus!,
                          style: GoogleFonts.prompt(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mint,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              post.content,
              style: GoogleFonts.prompt(
                fontSize: 14,
                color: AppColors.textMain,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Tags & Budget Pill
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                if (post.budgetPerPerson != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.yellowLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '💰 ~฿${post.budgetPerPerson}/คน',
                      style: GoogleFonts.prompt(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFD97706),
                      ),
                    ),
                  ),
                ...post.tags.map((tag) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.prompt(
                      fontSize: 11,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Post Media
          if (post.imageUrls.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: Image.network(
                      post.imageUrls.first,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),

          // Action Buttons (Like, Comment, Save, Share)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Consumer<AppState>(
                  builder: (context, appState, child) {
                    return GestureDetector(
                      onTap: () => appState.togglePostLike(post.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: post.isLiked ? AppColors.primaryPastel : AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              post.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              size: 16,
                              color: post.isLiked ? AppColors.primary : AppColors.textMuted,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${post.likes}',
                              style: GoogleFonts.prompt(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: post.isLiked ? AppColors.primary : AppColors.textMain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('เปิดกล่องคอมเมนต์แล้ว 💬'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.mode_comment_outlined, size: 16, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          '${post.commentsCount}',
                          style: GoogleFonts.prompt(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textMain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Consumer<AppState>(
                  builder: (context, appState, child) {
                    return IconButton(
                      icon: Icon(
                        post.isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                        color: post.isSaved ? AppColors.yellow : AppColors.textMuted,
                        size: 22,
                      ),
                      onPressed: () => appState.togglePostSave(post.id),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined, color: AppColors.textMuted, size: 20),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('แชร์โพสต์ไปยังสตอรี่/แชทแล้ว 🚀'),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
