import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_learning/utils/assets.dart';
import 'package:kids_learning/utils/themes/app_colors.dart';
import 'package:kids_learning/widgets/gaming_button.dart';

// Main Character Selector Screen
class CharacterSelectorScreen extends StatefulWidget {
  const CharacterSelectorScreen({super.key});

  @override
  State<CharacterSelectorScreen> createState() =>
      _CharacterSelectorScreenState();
}

class _CharacterSelectorScreenState extends State<CharacterSelectorScreen> {
  int? selectedCharacterIndex;

  // Replace these with your actual image paths
  final List<CharacterModel> characters = [
    CharacterModel(
      name: "Buddy",
      imagePath: Assets.imagesCharBird,
      backgroundColor: const Color(0xFFFFE5E5),
    ),
    CharacterModel(
      name: "Luna",
      imagePath: Assets.imagesCharCow,
      backgroundColor: const Color(0xFFE5F3FF),
    ),
    CharacterModel(
      name: "Max",
      imagePath: Assets.imagesCharDog,
      backgroundColor: const Color(0xFFFFF5E5),
    ),
    CharacterModel(
      name: "Bella",
      imagePath: Assets.imagesCharDonkey,
      backgroundColor: const Color(0xFFE5FFE5),
    ),
    CharacterModel(
      name: "Rocky",
      imagePath: Assets.imagesCharElephant,
      backgroundColor: const Color(0xFFFBE5FF),
    ),
    CharacterModel(
      name: "Daisy",
      imagePath: Assets.imagesCharFox,
      backgroundColor: const Color.fromARGB(255, 233, 229, 255),
    ),
    CharacterModel(
      name: "Golu",
      imagePath: Assets.imagesCharOwl,
      backgroundColor: const Color.fromARGB(255, 229, 255, 231),
    ),
    CharacterModel(
      name: "Pinky",
      imagePath: Assets.imagesCharRabbit,
      backgroundColor: const Color.fromARGB(255, 255, 232, 229),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFF9E6),
              const Color(0xFFE6F4FF),
              const Color(0xFFFFE6F0),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                // Header
                _buildHeader(),

                SizedBox(height: 30.h),

                // Character Grid
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(
                        character: characters[index],
                        isSelected: selectedCharacterIndex == index,
                        onTap: () {
                          setState(() {
                            selectedCharacterIndex = index;
                          });
                        },
                      );
                    },
                  ),
                ),

                SizedBox(height: 20.h),

                // Continue Button
                AnimatedOpacity(
                  opacity: selectedCharacterIndex != null ? 1.0 : 0.5,
                  duration: const Duration(milliseconds: 300),
                  child: UniversalGamingButton(
                    onPressed: selectedCharacterIndex != null
                        ? () {
                            // Handle character selection
                            print(
                              "Selected: ${characters[selectedCharacterIndex!].name}",
                            );
                          }
                        : () {},
                    width: 320.w,
                    height: 50,
                    text: "LET'S GO!",
                    textStyle: GoogleFonts.bubblegumSans(
                      color: AppColors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          "Choose Your Friend",
          style: GoogleFonts.bubblegumSans(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF5C4BDB),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Pick your favorite character!",
          style: GoogleFonts.bubblegumSans(
            fontSize: 16.sp,
            color: const Color(0xFF9E9E9E),
          ),
        ),
      ],
    );
  }
}

// Character Model
class CharacterModel {
  final String name;
  final String imagePath;
  final Color backgroundColor;

  CharacterModel({
    required this.name,
    required this.imagePath,
    required this.backgroundColor,
  });
}

// Character Card Widget
class CharacterCard extends StatefulWidget {
  final CharacterModel character;
  final bool isSelected;
  final VoidCallback onTap;

  const CharacterCard({
    super.key,
    required this.character,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: widget.isSelected
                        ? const Color(0xFF5C4BDB).withOpacity(0.4)
                        : Colors.black.withOpacity(0.08),
                    blurRadius: widget.isSelected ? 20 : 10,
                    offset: Offset(0, widget.isSelected ? 8 : 4),
                    spreadRadius: widget.isSelected ? 2 : 0,
                  ),
                ],
                border: Border.all(
                  color: widget.isSelected
                      ? const Color(0xFF5C4BDB)
                      : Colors.transparent,
                  width: 3,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Character Image Container
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: widget.character.backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: AnimatedScale(
                          scale: widget.isSelected ? 1.1 : 1.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Image.asset(
                            widget.character.imagePath,
                            width: 80.w,
                            height: 80.w,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                size: 60.sp,
                                color: Colors.grey.shade400,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Character Name
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Text(
                      widget.character.name,
                      style: GoogleFonts.bubblegumSans(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: widget.isSelected
                            ? const Color(0xFF5C4BDB)
                            : const Color(0xFF424242),
                      ),
                    ),
                  ),

                  // Selected Indicator
                  if (widget.isSelected)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: AnimatedCheckmark(),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Animated Checkmark Widget
class AnimatedCheckmark extends StatefulWidget {
  const AnimatedCheckmark({super.key});

  @override
  State<AnimatedCheckmark> createState() => _AnimatedCheckmarkState();
}

class _AnimatedCheckmarkState extends State<AnimatedCheckmark>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color: const Color(0xFF5C4BDB),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check, color: Colors.white, size: 18.sp),
      ),
    );
  }
}
