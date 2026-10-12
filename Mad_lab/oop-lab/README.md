# OOP in Dart: Campus Library System Lab

Course: CS442 — Mobile Application Development  
Name: [Humaira_Nadeem]  
Roll Number: [04072313009]

## Part A: Think Questions — Steps 1–10

1. Classes and Inheritance: A `LibraryItem` variable can reference a `Book`, but cannot directly access `pages` because it belongs to `Book`.
2. `super` and `@override`: Misspelling `describe()` prevents correct overriding. `@override` helps detect the mistake.
3. Abstract Classes: Abstract classes cannot be instantiated directly. Concrete subclasses must implement required abstract methods.
4. `implements`: It requires implementing all interface members, while `extends` inherits existing implementations.
5. Mixins: `Renewable` allows `Book` and `Dvd` to share renewal behavior without adding it to `Magazine`.
6. Enhanced Enums: Enums provide predefined, type-safe values and help prevent invalid choices.
7. Extension Methods: Extensions add convenient methods to existing types without modifying them.
8.`==` and `hashCode`: Both should be overridden consistently so equal objects work correctly in sets and maps.
9. `static` and `const`: A static variable belongs to the class and can be accessed without creating an object.
10. Polymorphism: Different library items can implement `lateFee()` differently through the common `LibraryItem` type.

## Part B: Final Reflection Questions

Q1. What does `extends` provide that `implements` does not?  
`extends` inherits accessible fields and methods, while `implements` requires implementing all interface members.

Q2. When should I use a mixin or an abstract parent class?  
Use a mixin to share behavior across classes and an abstract parent class for shared identity, state, and behavior.

Q3. Why override `hashCode` with `==`?
Equal objects must have the same hash code for sets and maps to work correctly.

Q4. Why use a String extension instead of subclassing String?  
Dart's `String` is final and cannot be subclassed. Extensions add useful methods without changing its inheritance hierarchy.
