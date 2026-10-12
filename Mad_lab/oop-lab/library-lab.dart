
 // library_lab.dart - Campus Library System
 // Name: ____________________   Roll no: ____________

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
// ==========================================================================

// STEP 1–3: Abstract classes and inheritance.

abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  // Step 2: The parent provides the common description.
  String describe() => '$title ($year)';

  // Step 3: Every concrete subclass must implement this method.
  int lateFee(int days);
}

class Book extends LibraryItem {
  final int pages;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) => days * feePerDay;
}

class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

class Dvd extends LibraryItem {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

// Step 1: Create a Book using the seeded settings.
Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

// Step 2: Create a Magazine using the seeded settings.
Magazine mainMagazine() {
  final int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

// Step 3: Create a DVD using the seeded settings.
Dvd mainDvd() {
  final int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

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

// STEP 1: Classes and inheritance.
void step1() {
  print('--- Step 1 ---');

  final Book b = mainBook();
  final LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');

  // Think: item.pages is a compile error because the variable is declared
  // as LibraryItem, which does not declare a pages property.
  // The actual object is a Book, but its extra property is not available
  // through the LibraryItem type.
}

// STEP 2: super and method overriding.
void step2() {
  print('--- Step 2 ---');

  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');

  // Think: If describe() were misspelled as descibe(), Dart would not
  // override the parent's method. The misspelled method would be separate.
  // Using @override helps Dart detect this kind of mistake.
}

// STEP 3: Abstract classes and late fees.
void step3() {
  print('--- Step 3 ---');

  final Book book = mainBook();
  final Magazine magazine = mainMagazine();
  final Dvd dvd = mainDvd();

  print(
    'Step 3: Book late fee for $daysLate days = '
    '${book.lateFee(daysLate)}',
  );

  print(
    'Step 3: Magazine late fee for $daysLate days = '
    '${magazine.lateFee(daysLate)}',
  );

  print(
    'Step 3: Dvd late fee for $daysLate days = '
    '${dvd.lateFee(daysLate)}',
  );

  // Think: LibraryItem cannot be instantiated directly because it is
  // abstract. It declares lateFee() without providing its implementation.
  // Concrete subclasses such as Book, Magazine, and Dvd must implement it.
}
