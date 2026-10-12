// library_lab.dart - Campus Library System
// Name: YOUR NAME
// Roll no: YOUR ROLL NUMBER
//
// IMPORTANT:
// 1. Replace rollNo with your own roll number ending in two digits.
// 2. Do not change the seeded settings below.
// 3. Run with: dart run --enable-asserts oop_lab/library_lab.dart

const String rollNo = '04072313009'; // Example: '21F-0347'

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

// Abstract parent: all library items have a title/year and must calculate fees.
abstract class LibraryItem {
  final String title;
  final int year;

  static int created = 0;

  LibraryItem(this.title, this.year) {
    created++;
  }

  String describe() => '$title ($year)';

  int lateFee(int days);

  static int capFee(int fee) => fee > feeCap ? feeCap : fee;
}

// A Book inherits common LibraryItem data/behaviour, mixes in renewal behaviour,
// and fulfils the Borrowable contract.
class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) => days * feePerDay;

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

class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

// Interface/contract: a borrowable item must provide all three members.
abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

// Mixin: reusable renewal logic shared by Book and Dvd.
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

Book mainBook() => Book(titles[u], yearOf(u), 100 + 3 * seed);

Magazine mainMagazine() {
  final int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

Dvd mainDvd() {
  final int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

// Enhanced enum: each fixed member carries data and behaviour.
enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;

  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) =>
      fee - (fee * discountPercent ~/ 100);
}

// Extension methods add convenient behaviour to existing types.
extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials => split(' ').map((word) => word[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) =>
      fold(0, (sum, item) => sum + item.lateFee(days));
}

// Operator overloading lets Fine values use +, > and value-based equality.
class Fine {
  final int amount;

  const Fine(this.amount);

  Fine operator +(Fine other) => Fine(amount + other.amount);

  bool operator >(Fine other) => amount > other.amount;

  @override
  bool operator ==(Object other) =>
      other is Fine && other.amount == amount;

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'Fine($amount)';
}

List<LibraryItem> buildShelf() {
  final List<LibraryItem> shelf = [];

  for (int k = 0; k < shelfSize; k++) {
    final int i = (u + k) % 10;

    if (k % 3 == 0) {
      shelf.add(Book(titles[i], yearOf(i), 100 + 3 * seed));
    } else if (k % 3 == 1) {
      shelf.add(Magazine(titles[i], yearOf(i), 1 + (t + k) % 12));
    } else {
      shelf.add(Dvd(titles[i], yearOf(i), 90 + seed % 40));
    }
  }

  return shelf;
}

class Member {
  final String name;
  final MemberType type;

  Member(this.name, this.type);

  Fine feeFor(LibraryItem item, int days) {
    final int rawFee = item.lateFee(days);
    final int cappedFee = LibraryItem.capFee(rawFee);
    final int discountedFee = type.applyDiscount(cappedFee);
    return Fine(discountedFee);
  }
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
}

void step1() {
  print('--- Step 1 ---');
  final Book b = mainBook();
  final LibraryItem item = b;
  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');
  // Think: item.pages is a compile error because the variable's static type is
  // LibraryItem, which does not declare pages. The actual object is still Book.
}

void step2() {
  print('--- Step 2 ---');
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');
  // Think: without @override, a misspelled descibe() would be a separate method;
  // the inherited describe() would remain unchanged and the typo may go unnoticed.
}

void step3() {
  print('--- Step 3 ---');
  print('Step 3: Book late fee for $daysLate days = ${mainBook().lateFee(daysLate)}');
  print('Step 3: Magazine late fee for $daysLate days = ${mainMagazine().lateFee(daysLate)}');
  print('Step 3: Dvd late fee for $daysLate days = ${mainDvd().lateFee(daysLate)}');
  // Think: an abstract class cannot be instantiated because it can contain
  // unimplemented methods such as lateFee(), so a concrete subclass must finish them.
}

void step4() {
  print('--- Step 4 ---');
  final Book book = mainBook();
  print('Step 4: available? ${book.isAvailable}');
  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');
  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  final List<LibraryItem> items = [book, mainMagazine(), mainDvd()];
  for (final LibraryItem item in items) {
    print('Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}');
  }
  // Think: extends Borrowable would inherit implementation only if it had
  // concrete method bodies. Here Borrowable is a contract, so implements makes
  // Book provide the required behaviour explicitly.
}

void step5() {
  print('--- Step 5 ---');
  final Book book = mainBook();
  int ok = 0;

  for (int attempt = 0; attempt < renewAttempts; attempt++) {
    if (book.renew(renewLimit)) {
      ok++;
    }
  }

  print('Step 5: renewed $ok of $renewAttempts attempts (limit $renewLimit)');
  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');
  // Think: Renewable belongs only to classes that can be renewed. A mixin
  // shares this implementation without making every LibraryItem renewable.
}

void step6() {
  print('--- Step 6 ---');
  final MemberType type = MemberType.values[seed % 3];
  final int fee = mainBook().lateFee(daysLate);
  print('Step 6: member type = ${type.name} (index ${type.index})');
  print('Step 6: max loans = ${type.maxLoans}');
  print('Step 6: book fee $fee -> ${type.applyDiscount(fee)} after discount');
  // Think: MemberType.student is checked by Dart and cannot silently contain
  // a typo like the string 'studnet'; enum values are a fixed set of choices.
}
