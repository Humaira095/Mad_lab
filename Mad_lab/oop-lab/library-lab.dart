
 // library_lab.dart - Campus Library System
 // Name: ____________________   Roll no: ____________

const String rollNo = '04072313009dart run library_lab.dart'; // Replace with your actual roll number.

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

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

// STEP 3: Abstract parent class.
abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  String describe() => '$title ($year)';

  int lateFee(int days);
}

// STEP 4: Contract for items that can be borrowed.
abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

// STEP 5: Mixin for reusable renewal functionality.
mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) {
      return false;
    }

    renewals++;
    return true;
  }
}

// STEP 1 and STEP 4: Book inherits LibraryItem,
// uses Renewable, and implements Borrowable.
class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;

  // false means the book is currently available.
  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) => days * feePerDay;

  // Implement the Borrowable contract.
  @override
  bool get isAvailable => !_out;

  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }
}

// STEP 2: Magazine inherits LibraryItem.
// It does not use Renewable.
class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

// STEP 3 and STEP 5: DVD inherits LibraryItem and uses Renewable.
class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

// Create the seeded Book.
Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

// Create the seeded Magazine.
Magazine mainMagazine() {
  final int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

// Create the seeded DVD.
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

  // Think: item.pages is a compile error because its declared type is
  // LibraryItem, and LibraryItem does not declare a pages property.
}

// STEP 2: super and method overriding.
void step2() {
  print('--- Step 2 ---');

  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');

  // Think: If describe() were misspelled as descibe(), it would not
  // override the parent's method. @override helps catch this mistake.
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

  // Think: An abstract class cannot be instantiated directly.
  // Its abstract lateFee() method must be implemented by subclasses.
}

// STEP 4: implements and the Borrowable contract.
void step4() {
  print('--- Step 4 ---');

  final Book book = mainBook();

  print('Step 4: available? ${book.isAvailable}');

  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');

  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  final List<LibraryItem> items = [
    book,
    mainMagazine(),
    mainDvd(),
  ];

  for (final LibraryItem item in items) {
    print(
      'Step 4: ${item.runtimeType} borrowable? '
      '${item is Borrowable}',
    );
  }

  // Think: Dart allows only one superclass. Book already extends
  // LibraryItem, so implements lets it fulfil Borrowable's contract.
}

// STEP 5: Mixins and renewals.
void step5() {
  print('--- Step 5 ---');

  final Book book = mainBook();
  final Dvd dvd = mainDvd();
  final Magazine magazine = mainMagazine();

  // Try renewing the Book the seeded number of times.
  for (int i = 1; i <= renewAttempts; i++) {
    final bool success = book.renew(renewLimit);

    print(
      'Step 5: Book renewal attempt $i = $success '
      '(total renewals: ${book.renewals})',
    );
  }

  // Try renewing the DVD the seeded number of times.
  for (int i = 1; i <= renewAttempts; i++) {
    final bool success = dvd.renew(renewLimit);

    print(
      'Step 5: Dvd renewal attempt $i = $success '
      '(total renewals: ${dvd.renewals})',
    );
  }

  // Check which items use the Renewable mixin.
  print('Step 5: Book renewable? ${book is Renewable}');
  print('Step 5: Magazine renewable? ${magazine is Renewable}');
  print('Step 5: Dvd renewable? ${dvd is Renewable}');

  // Think: A mixin reuses functionality without becoming another
  // superclass. Book and Dvd use Renewable; Magazine does not.
}

