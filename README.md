# Tower of Hanoi / ReScript

## Overview
- A trial project for ReScript. Explored its usability using the *Tower of Hanoi* as a subject.
- Moves discs every specified interval on initial display or reload.
- The execution time and the number of discs are set in Config.res.

## Technologies Used
- ReScript
- rescript-webapi
  - Used for drawing on &lt;canvas>

## How to Run

1.  Install npm.
2.  Run `npm run dev`. (Run `npm run res:dev` during development as well.)
3.  Check http://localhost:5173/ in your browser.

## Notes
- Vibe Coding
  - Attempted Vibe Coding using ChatGPT for environment setup and coding.
  - The generated code tended towards procedural style, deviating from a functional programming approach.
  - Encountered several challenges, including compilation errors and unexpected behavior.
  - Personally, the process of debugging and refactoring proved to be a valuable learning experience.
  - Future advancements in training data and model improvements may lead to more sophisticated Vibe Coding capabilities.
  - Prompts were primarily in English.
- ReScript itself doesn't feel very functional. It gives the impression of a typed JavaScript that can be written a bit like OCaml.
- I tried to add tests, but build issues prevented me from testing, so I skipped it.

## References
- [rescript-lang.org](https://rescript-lang.org/)
- [wikipedia: Tower of Hanoi](https://en.wikipedia.org/wiki/Tower_of_Hanoi)
