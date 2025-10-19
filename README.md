# duppy-shell-config

This is an attempt to create a common command line shell and shell scripting environment across multiple platforms.

UPDATE 2025: I now realize that the 'stow' utility does most of this. TODO: adapt to directory organization that stow can use.

See [Savannah GNU.org](https://savannah.gnu.org/git/?group=stow) and [GNU.org GitHub](https://www.gnu.org/software/stow/stow.html)

Inspired by the fact that I want to work from my Windows gaming Desktop and also MacBook air with minimal cognitive friction.
Stretch goal: work from iPad or any Chrome Browser (I guess this implies Chrome Book).

Stauts as of 2024-06-02:
- Beta: Ubuntu on WSL2 (Windows 11)
- Beta: MacOS Sonoma
- UNTESTED: native Linux
- UNTESTED: GitHub codespaces

## Current strategy
- presume gnu coreutils
- maintain bash compatibility in scripts when practical
- use zsh for shell and limit zsh specific features to user interaction 'quality of life'

## Open questions
- How do other people solve this issue?
- Am I trying to solve something that has already been solved?
