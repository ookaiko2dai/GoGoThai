import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

class CameraMemoriesScreen extends StatefulWidget {
  const CameraMemoriesScreen({super.key});

  @override
  State<CameraMemoriesScreen> createState() => _CameraMemoriesScreenState();
}

class _CameraMemoriesScreenState extends State<CameraMemoriesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFlashOn = false;
  bool _isFrontCamera = false;
  bool _isVideoMode = false;
  bool _isRecording = false;

  final List<String> _samplePhotoUrls = [
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1563492065599-3520f775eeed?w=800&auto=format&fit=crop&q=80',
  ];
  int _currentSampleIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getFilterColorOverlay(String filter) {
    if (filter.contains('Film')) return Colors.amber.withValues(alpha: 0.12);
    if (filter.contains('Sunset')) return Colors.deepOrange.withValues(alpha: 0.15);
    if (filter.contains('Cafe')) return Colors.brown.withValues(alpha: 0.12);
    if (filter.contains('Teal')) return Colors.cyan.withValues(alpha: 0.15);
    if (filter.contains('Pastel')) return Colors.pink.withValues(alpha: 0.15);
    if (filter.contains('Mint')) return Colors.green.withValues(alpha: 0.12);
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Tab Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        labelColor: Colors.white,
                        unselectedLabelColor: AppColors.textMain,
                        labelStyle: GoogleFonts.prompt(fontSize: 13, fontWeight: FontWeight.w700),
                        unselectedLabelStyle: GoogleFonts.prompt(fontSize: 13, fontWeight: FontWeight.w500),
                        tabs: const [
                          Tab(text: '📸 กล้อง & ฟิลเตอร์ Y2K'),
                          Tab(text: '🖼️ ความทรงจำ & วิดีโอ Vlog'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCameraViewfinder(context, appState),
                  _buildMemoriesGallery(context, appState),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraViewfinder(BuildContext context, AppState appState) {
    final filterColor = _getFilterColorOverlay(appState.selectedFilter);

    return Column(
      children: [
        // Camera Viewfinder Box
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                // Camera Preview Container
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        _samplePhotoUrls[_currentSampleIndex % _samplePhotoUrls.length],
                        fit: BoxFit.cover,
                      ),
                      // Filter overlay
                      Container(color: filterColor),

                      // Camera Grid Lines
                      CustomPaint(
                        painter: GridPainter(),
                      ),

                      // Video Recording Badge
                      if (_isRecording)
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'REC 00:04',
                                  style: GoogleFonts.prompt(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Filter Watermark Tag
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            appState.selectedFilter,
                            style: GoogleFonts.prompt(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Top Floating Camera Controls
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildRoundBtn(
                        icon: _isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                        color: _isFlashOn ? AppColors.yellow : Colors.white,
                        onTap: () {
                          setState(() => _isFlashOn = !_isFlashOn);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_isFlashOn ? 'เปิดแฟลชแล้ว ⚡' : 'ปิดแฟลชแล้ว 🌙'),
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          );
                        },
                      ),
                      _buildRoundBtn(
                        icon: Icons.sync_rounded,
                        color: Colors.white,
                        onTap: () {
                          setState(() {
                            _isFrontCamera = !_isFrontCamera;
                            _currentSampleIndex = (_currentSampleIndex + 1) % _samplePhotoUrls.length;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Filter Carousel Selector
        SizedBox(
          height: 42,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: appState.cameraFilters.length,
            itemBuilder: (ctx, i) {
              final filter = appState.cameraFilters[i];
              final isSelected = appState.selectedFilter == filter;

              return GestureDetector(
                onTap: () => appState.setSelectedFilter(filter),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryPastel : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    filter,
                    style: GoogleFonts.prompt(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? AppColors.primary : AppColors.textMain,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // Photo / Video Toggle & Shutter Controls
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Photo / Video Mode switch
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isVideoMode = !_isVideoMode;
                    _isRecording = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _isVideoMode ? Icons.videocam_rounded : Icons.camera_alt_rounded,
                        color: AppColors.primary,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _isVideoMode ? 'วิดีโอ Vlog' : 'ถ่ายรูปภาพ',
                        style: GoogleFonts.prompt(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),

              // Big Cute Shutter Button
              GestureDetector(
                onTap: () {
                  if (_isVideoMode) {
                    setState(() => _isRecording = !_isRecording);
                    if (!_isRecording) {
                      appState.addMemoryPhoto(
                        title: 'คลิป Vlog ชิลล์ริมทะเล 📹',
                        location: 'เกาะกูด, ตราด',
                        customUrl: _samplePhotoUrls[_currentSampleIndex],
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('บันทึก Vlog เข้าแกลเลอรีความทรงจำแล้ว! 🎥✨'),
                          backgroundColor: AppColors.mint,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      );
                    }
                  } else {
                    appState.addMemoryPhoto(
                      title: 'แชะภาพมุมโปรด 📸',
                      location: 'เชียงใหม่, ไทย',
                      customUrl: _samplePhotoUrls[_currentSampleIndex],
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('แชะ! บันทึกภาพลงไดอารี่ทริปแล้ว 📸💖'),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 72,
                  height: 72,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 4),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isVideoMode ? (_isRecording ? Colors.red : AppColors.primary) : AppColors.primary,
                    ),
                    child: Center(
                      child: Icon(
                        _isVideoMode
                            ? (_isRecording ? Icons.stop_rounded : Icons.videocam_rounded)
                            : Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),

              // Switch Sample Scene
              IconButton.filledTonal(
                onPressed: () {
                  setState(() {
                    _currentSampleIndex = (_currentSampleIndex + 1) % _samplePhotoUrls.length;
                  });
                },
                icon: const Icon(Icons.shuffle_rounded, color: AppColors.textMain),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMemoriesGallery(BuildContext context, AppState appState) {
    final memories = appState.memories;

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
      itemCount: memories.length,
      itemBuilder: (ctx, i) {
        final item = memories[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Image.network(
                        item.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          item.filterUsed,
                          style: GoogleFonts.prompt(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 14,
                      right: 14,
                      child: Row(
                        children: item.stickers.map((s) => Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(s, style: const TextStyle(fontSize: 20)),
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text(
                          item.location,
                          style: GoogleFonts.prompt(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          item.date,
                          style: GoogleFonts.prompt(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.title,
                      style: GoogleFonts.prompt(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textMain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRoundBtn({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..strokeWidth = 1;

    // Vertical lines
    canvas.drawLine(Offset(size.width / 3, 0), Offset(size.width / 3, size.height), paint);
    canvas.drawLine(Offset(size.width * 2 / 3, 0), Offset(size.width * 2 / 3, size.height), paint);

    // Horizontal lines
    canvas.drawLine(Offset(0, size.height / 3), Offset(size.width, size.height / 3), paint);
    canvas.drawLine(Offset(0, size.height * 2 / 3), Offset(size.width, size.height * 2 / 3), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
