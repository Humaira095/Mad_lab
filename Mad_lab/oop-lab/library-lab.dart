```dart
// library_lab.dart - Campus Library System
// Name: ____________________ Roll no: ____________

const String rollNo = 'YOUR-ROLL-NO-HERE'; // Replace with your actual roll number.

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t;

final int feePerDay = 5 + t;
final int daysLate = 3 + (t + u) % 6;
final int daysBig = 10 + u;
final int feeCap = 150 + 10 * t;
final int renewLimit = 1 + t % 3;
final int renewAttempts = 2 + u;
final int shelfSize = 3 + u % 4;
// ===========================================================================

// STEP 1 AND STEP 2: CLASSES, INHERITANCE, OVERRIDING

class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  // Step 2: Describe the general library item.
  String describe() => '$title ($year)';
}

class Book extends LibraryItem {
  final int pages;

  Book(super.title, super.year, this.pages);

  // Step 2: Override the parent's describe() method.
  @override
  String describe() => '${super.describe()}, $pages pages';
}

class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  // Step 2: Describe a magazine with its issue number.
  @override
  String describe() => '${super.describe()}, issue $issue';
}

// Top-level function required by Step 1.
Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

// Top-level function required by Step 2.
Magazine mainMagazine() {
  final int i = (u + 1) % 10;

  return Magazine(
    titles[i],
    yearOf(i),
    1 + (t + u) % 12,
  );
}

// MAIN FUNCTION

void main() {
  print('Seed: $seed (t=$t, u=$u)');

  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

// STEP 1: Classes and extends

void step1() {
  print('--- Step 1 ---');

  final Book b = mainBook();

  // Store a Book object in a variable declared as LibraryItem.
  final LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');
}

// Think: item.pages is a compile error because item is declared as
// LibraryItem, and LibraryItem does not declare a pages member.

// STEP 2: super and @override

void step2() {
  print('--- Step 2 ---');

  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');
}

// Think: If describe() is mistyped as descibe(), it does not override
// the parent's method. Calls to describe() use the inherited version.

// STEP 3: Abstract Classes
// Complete this step in the next checkpoint.
