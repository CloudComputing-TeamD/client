import 'package:flutter/material.dart';
import 'user_info_input_page2.dart';
import '../models/user_data.dart';
import 'package:flutter/cupertino.dart';

class UserInfoInputPage1_5 extends StatefulWidget {
  final UserData userData;

  const UserInfoInputPage1_5({super.key, required this.userData});

  @override
  State<UserInfoInputPage1_5> createState() => _UserInfoInputPage1_5State();
}

class _UserInfoInputPage1_5State extends State<UserInfoInputPage1_5> {
  String? _selectedGender;
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  DateTime? _selectedDate;

  void _showCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime(2000),
            minimumDate: DateTime(1950),
            maximumDate: DateTime.now(),
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _selectedDate = newDate;
                widget.userData.birthDate = newDate;
              });
            },
          ),
        );
      },
    );
  }

  void _onNext() {
    if (_selectedGender != null &&
        _heightController.text.isNotEmpty &&
        _weightController.text.isNotEmpty &&
        _selectedDate != null) {
      widget.userData.gender = _selectedGender!;
      widget.userData.height = int.tryParse(_heightController.text) ?? 0;
      widget.userData.weight = int.tryParse(_weightController.text) ?? 0;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserInfoInputPage2(userData: widget.userData),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 정보를 입력해주세요.')),
      );
    }
  }

  Widget _genderOption(String label, String value) {
    final isSelected = _selectedGender == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = value;
        });
      },
      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A237E) : Colors.white,
          border: Border.all(color: const Color(0xFF1A237E)),
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1A237E),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Positioned(
            left: 40,
            top: 20,
            child: SizedBox(width: 60, height: 24),
          ),
          Positioned(
            top: 44,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5, color: Color(0xFFBFBFC4)),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new,
                        size: 24, color: Colors.black),
                  ),
                  const SizedBox(width: 12),
                  Image.asset('assets/info/logo.png', width: 60),
                ],
              ),
            ),
          ),
          // 진행 바
          Positioned(
            top: 124,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 8,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 3, color: Color(0xFF1A237E)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Positioned(
            left: 36,
            top: 160,
            child: Text(
              'Q. 기초 신체 정보를 입력해주세요',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: 36,
            right: 36,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('성별 선택', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _genderOption("남성", "MALE"),
                    _genderOption("여성", "FEMALE"),
                  ],
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '키 (cm)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '몸무게 (kg)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('생년월일'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _showCupertinoDatePicker(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A237E),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        '날짜 선택',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (_selectedDate != null)
                      Text(
                        '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 128, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '다음',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
