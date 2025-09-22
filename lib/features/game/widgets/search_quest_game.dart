import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SearchQuestGame extends StatefulWidget {
  final Map<String, dynamic> gameData;
  final Function(bool isCorrect, int points) onComplete;

  const SearchQuestGame({
    super.key,
    required this.gameData,
    required this.onComplete,
  });

  @override
  State<SearchQuestGame> createState() => _SearchQuestGameState();
}

class _SearchQuestGameState extends State<SearchQuestGame>
    with TickerProviderStateMixin {
  late AnimationController _searchController;
  late AnimationController _successController;
  
  String question = '';
  List<String> acceptableKeywords = [];
  String correctAnswer = '';
  List<Map<String, dynamic>> simulatedResults = [];
  
  String searchInput = '';
  bool hasSearched = false;
  bool gameComplete = false;
  String? selectedResult;
  
  TextEditingController searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    
    _searchController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _successController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _initializeGame();
  }

  void _initializeGame() {
    question = widget.gameData['question'] ?? '';
    acceptableKeywords = List<String>.from(widget.gameData['acceptableKeywords'] ?? []);
    correctAnswer = widget.gameData['correctAnswer'] ?? '';
    simulatedResults = List<Map<String, dynamic>>.from(widget.gameData['simulatedResults'] ?? []);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _successController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = searchController.text.trim().toLowerCase();
    
    if (query.isEmpty) {
      _showSearchTip('Please enter some search keywords!');
      return;
    }
    
    // Check if keywords are acceptable
    bool hasGoodKeywords = acceptableKeywords.any((keyword) => 
        query.contains(keyword.toLowerCase()));
    
    if (!hasGoodKeywords) {
      _showSearchTip('Try using keywords like: ${acceptableKeywords.take(2).join(", ")}');
      return;
    }
    
    setState(() {
      searchInput = query;
      hasSearched = true;
    });
    
    _searchController.forward();
  }

  void _showSearchTip(String tip) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.lightbulb, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(tip)),
          ],
        ),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _selectResult(int index) {
    final result = simulatedResults[index];
    final isCredible = result['credible'] == true;
    
    setState(() {
      selectedResult = result['title'];
    });
    
    if (isCredible) {
      setState(() {
        gameComplete = true;
      });
      
      _successController.forward();
      
      Future.delayed(const Duration(milliseconds: 2000), () {
        widget.onComplete(true, 100);
      });
    } else {
      _showResultFeedback(result, false);
    }
  }

  void _showResultFeedback(Map<String, dynamic> result, bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isCorrect ? Icons.check_circle : Icons.warning,
              color: isCorrect ? Colors.green : Colors.orange,
              size: 30,
            ),
            const SizedBox(width: 8),
            Text(
              isCorrect ? 'Great Choice!' : 'Think Again!',
              style: TextStyle(
                color: isCorrect ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
        content: Text(
          isCorrect 
            ? 'You chose a reliable source! This website provides accurate information.'
            : 'This source might not be reliable. Look for sources from trusted organizations like schools, governments, or well-known educational websites.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: isCorrect ? Colors.green : Colors.orange,
            ),
            child: Text(
              isCorrect ? 'Continue' : 'Try Again',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchInterface() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search engine logo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.green, Colors.red, Colors.yellow],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'S',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'SearchEngine',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Search question
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.help_outline, color: Colors.blue[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    question,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Search bar
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Enter your search keywords...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  onSubmitted: (value) => _performSearch(),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _performSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (!hasSearched) return const SizedBox.shrink();
    
    return AnimatedBuilder(
      animation: _searchController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _searchController.value)),
          child: Opacity(
            opacity: _searchController.value,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Search results for: "$searchInput"',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Search results
                  ...simulatedResults.asMap().entries.map((entry) {
                    final index = entry.key;
                    final result = entry.value;
                    return _buildSearchResult(result, index);
                  }).toList(),
                  
                  const SizedBox(height: 12),
                  
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.orange[600]),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Tip: Choose results from trusted sources like government websites, educational institutions, or well-known organizations.',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResult(Map<String, dynamic> result, int index) {
    final isCredible = result['credible'] == true;
    final isSelected = selectedResult == result['title'];
    
    return GestureDetector(
      onTap: () => _selectResult(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected 
            ? (isCredible ? Colors.green[50] : Colors.red[50])
            : Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
              ? (isCredible ? Colors.green : Colors.red)
              : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with credibility indicator
            Row(
              children: [
                Expanded(
                  child: Text(
                    result['title'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
                if (result['source'] != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: isCredible ? Colors.green[100] : Colors.orange[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      result['source'],
                      style: TextStyle(
                        fontSize: 10,
                        color: isCredible ? Colors.green[800] : Colors.orange[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 4),
            
            // Snippet
            Text(
              result['snippet'] ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
            
            if (isSelected) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    isCredible ? Icons.check_circle : Icons.warning,
                    color: isCredible ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isCredible ? 'Reliable source!' : 'Be careful with this source',
                    style: TextStyle(
                      color: isCredible ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    ).animate(target: isSelected ? 1 : 0)
     .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.02, 1.02));
  }

  Widget _buildSuccessOverlay() {
    if (!gameComplete) return const SizedBox.shrink();
    
    return Positioned.fill(
      child: Container(
        color: Colors.green.withOpacity(0.9),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 100,
                color: Colors.white,
              ).animate(controller: _successController)
               .rotate(begin: 0, end: 1)
               .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2)),
              
              const SizedBox(height: 20),
              
              const Text(
                'Search Expert!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 10),
              
              const Text(
                'You found reliable information!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 10),
              
              const Text(
                'Great search skills help you find accurate information online!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue[50]!,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Instructions
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.gameData['instructions'] ?? 
                    'Search for the answer and choose the most reliable source!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),

                // Search interface
                _buildSearchInterface(),

                // Search results
                _buildSearchResults(),
              ],
            ),
          ),

          // Success overlay
          _buildSuccessOverlay(),
        ],
      ),
    );
  }
}