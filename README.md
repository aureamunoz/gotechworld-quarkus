# A few things I'd do if I wanted to modernize my Java application in 2026

Talk at [GoTech World 2026](https://www.gotech.world/), Bucharest, November 11, Developers Stage.

Áurea Muñoz · Quarkus team at IBM · Java Champion

## Abstract

Java is 30 years old and its backward compatibility is both its greatest strength and the
reason nobody touches the legacy app. This talk is about five things I'd do before and during
a modernization, with real tools for each one: migrating a Quarkus 3 app to Quarkus 4 with
`quarkus update`, and migrating Spring PetClinic to Quarkus with an open-source AI skill,
deterministic tooling and validators.

Modernizing isn't about starting over. It's about making the next change easier, safer and
cheaper than the last one.

## The five things

1. Ask yourself why, and understand what you have
2. Stop waiting for the perfect moment
3. Pick a target that doesn't force a day-one rewrite
4. Know when to use rules and when to use AI
5. Validate every step

## Contents

| What | Link |
|------|------|
| Slides (PDF) | [slides/gotechworld-slides.pdf](slides/gotechworld-slides.pdf) |
| Demo: steps to reproduce | [demo/README.md](demo/README.md) |
| The migration prompt | [demo/prompt.md](demo/prompt.md) |
| Setup script | [demo/setup.sh](demo/setup.sh) |
| Migration summary | [demo/migration-summary.md](demo/migration-summary.md) |
| Validator reports (JSON) | [demo/migration-reports/](demo/migration-reports/) |
| Migrated PetClinic on Quarkus | [aureamunoz/spring-petclinic-quarkus](https://github.com/aureamunoz/spring-petclinic-quarkus) |
| Video of the full migration | [Spring PetClinic Migration](https://drive.google.com/file/d/1Jspm0IhNVbjv7KfJJSta87N2d_41amqs/view?usp=sharing) |

## Tools shown

- [`quarkus update`](https://quarkus.io/guides/update-quarkus) — rule-based recipe engine for Quarkus version upgrades
- [migrate-spring-to-quarkus skill](https://github.com/quarkusio/skills/tree/main/skills/migrate-spring-to-quarkus) — open-source AI skill 
- [quarkit (migration-tool)](https://github.com/snowdrop/migration-tool) — deterministic validators exposed as an MCP server
- [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) — the demo app we migrate

## Try one thing

If you take one thing from the talk, try one tool this week: update your JDK, run
`quarkus update` on a project, or point the migration skill at a small Spring Boot app.
Then tell us what broke.

- Skill issues: <https://github.com/quarkusio/skills/issues>
- mtools issues: <https://github.com/snowdrop/migration-tool/issues>