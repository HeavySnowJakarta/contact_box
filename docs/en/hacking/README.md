# Hacking

Welcome to hack this project!

This doc aims to help you understand the structure of this project easier. See the toolchain it uses:

## The tech stack

This project uses `flutter-rust`. `flutter` ensures the cross-platform compatibility (across mobile and desktop) and the `rust` library makes the data expressed with good structures (enum and struct) and also helps the efficiency.

## File structure

Only the files you are more likely to concern are put here(like the actual source code):

```
.
├docs
|└<different languages>
├lib
│└rustcore                              Libs written in Rust.
│ ├src                                  Rust source codes.
│ │└cap                                 CAP profiles.
├pubspec.yaml                           Flutter info and dependencies.
├README.md
├rust                                   The Rustcore.
│└src                                   Rust source files.
│ ├cap                                  Contact Attribute Protocal definitions.
├lib                                    The Dart library.
│└io                                    IO library for Flutter Rust Bridge.
└
```

and the other files are generated by the toolchain.