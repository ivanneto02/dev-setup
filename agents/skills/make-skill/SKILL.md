---
name: make-skill
description: Create or improve agent skills. Use when the user asks to make a skill, write a SKILL.md, shorten an existing skill, or fix when a skill triggers. Not for general coding or learning a personal skill.
---

# Make or improve a skill

Produce a short `SKILL.md` with clear natural-language triggers.

1. Read the existing skill and one nearby skill. Preserve useful behavior.
   Ask only when missing information materially changes the result.
2. Give the skill one task. Use a lowercase, hyphenated name matching its folder.
3. Write a description that states the task and when to use it. Include phrases
   a user would naturally say and exclude likely false matches. Do not require
   `$name`, slash commands, or an exact phrase to request the skill.
4. Write direct steps, necessary constraints, and the expected result. Aim for
   under 80 lines. Remove repetition, generic advice, and unused metadata.
   Reference existing skills or supporting files instead of copying them.
5. Check the frontmatter and referenced paths. Review three matching requests
   and two near misses against the description. Fix ambiguous wording.
6. Report the changed path and checks. Distinguish a wording review from an
   observed runtime trigger; do not promise automatic selection.
7. Remember that the description serves as the natural trigger as well. So
   make sure to include when the skill should be triggered in the description.

Edit only the requested skill and necessary supporting files. Do not change
configuration or install the skill unless asked. Natural-language selection
requires the harness to discover the skill; wording alone cannot enable it.
