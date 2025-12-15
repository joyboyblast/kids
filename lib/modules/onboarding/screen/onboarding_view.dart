import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_learning/modules/onboarding/data/models/character_model.dart';
import 'package:kids_learning/modules/onboarding/screen/widgets/character_card.dart';
import 'package:kids_learning/services/logger_service.dart';
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
      name: "Chintu",
      imagePath: Assets.imagesCharBird,
      backgroundColor: const Color(0xFFFFE5E5),
      audioPath: "audios/english/english_chintu.mp3",
    ),
    CharacterModel(
      name: "Gauri",
      imagePath: Assets.imagesCharCow,
      backgroundColor: const Color(0xFFE5F3FF),
      audioPath: "audios/english/english_gauri.mp3",
    ),
    CharacterModel(
      name: "Moti",
      imagePath: Assets.imagesCharDog,
      backgroundColor: const Color(0xFFFFF5E5),
      audioPath: "audios/english/english_moti.mp3",
    ),
    CharacterModel(
      name: "Gudiya",
      imagePath: Assets.imagesCharDonkey,
      backgroundColor: const Color(0xFFE5FFE5),
      audioPath: "audios/english/english_gudiya.mp3",
    ),
    CharacterModel(
      name: "Gajraj",
      imagePath: Assets.imagesCharElephant,
      backgroundColor: const Color(0xFFFBE5FF),
      audioPath: "audios/english/english_gajraj.mp3",
    ),
    CharacterModel(
      name: "Chiku",
      imagePath: Assets.imagesCharFox,
      backgroundColor: const Color.fromARGB(255, 233, 229, 255),
      audioPath: "audios/english/english_chiku.mp3",
    ),
    // CharacterModel(
    //   name: "Ullu",
    //   imagePath: Assets.imagesCharOwl,
    //   backgroundColor: const Color.fromARGB(255, 229, 255, 231),
    //   audioPath: "",
    // ),
    // CharacterModel(
    //   name: "Bunty",
    //   imagePath: Assets.imagesCharRabbit,
    //   backgroundColor: const Color.fromARGB(255, 255, 232, 229),
    //   audioPath: "",
    // ),
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
                            LoggerService.logInfo(
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
