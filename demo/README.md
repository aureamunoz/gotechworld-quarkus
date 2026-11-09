# Demo cheat sheet

Two demos, back to back. Total stage time: ~15 minutes.

---

## Demo 1 — `quarkus update` (Quarkus 3.35 → 4.0)

Project: [cook-with-quarkus](https://github.com/aureamunoz/cook-with-quarkus), module `recipes-stream`.

**Terminal tab: cook-with-quarkus/recipes-stream**

| # | Command | Say |
|---|---------|-----|
| 1 | `quarkus update --stream=4.0 --no-rewrite` | Preview what the update engine would change — nothing is written yet. |
| 2 | `quarkus update --stream=4.0 -y` | Apply the recipes. This rewrites pom.xml, properties, and source files in place. |
| 3 | `git diff` | Walk through the diff: version bump, renamed artifacts, config changes. |
| 4 | `./mvnw install` | Build and run the tests to prove it still works. |

**Key point:** Rules, not guesswork. Every change is an OpenRewrite recipe, reproducible and auditable.

---

## Demo 2 — Spring PetClinic → Quarkus (AI + deterministic validators)

Source: [spring-petclinic](https://github.com/spring-projects/spring-petclinic) at commit `500158f`.
Skill: [migrate-spring-to-quarkus](https://github.com/quarkusio/skills/tree/main/skills/migrate-spring-to-quarkus).
Validators: [mtools (migration-tool)](https://github.com/snowdrop/migration-tool) as an MCP server.

### Before you go on stage

Start mtools in a terminal so the MCP server is ready:

```bash
cd gotechworld-demo/migration-tool/mcp
quarkus dev -Dmtool.allowed-dirs=$(cd ../.. && pwd)
```

### On stage

**Terminal tab: mtools** (already running)

| # | Say |
|---|-----|
| 1 | The validators are running as an MCP server. The agent will call them at each gate. |

**Terminal tab: spring-petclinic-quarkus**

| # | Command | Say |
|---|---------|-----|
| 2 | `claude -p "Migrate this Spring Boot project to Quarkus" --permission-mode acceptEdits --append-system-prompt "$(cat ../quarkus-skills/skills/migrate-spring-to-quarkus/SKILL.md)"` | One prompt. The skill gives Claude the migration plan; mtools validates each step. |
| 3 | (watch the agent work) | Point out: it runs modules in order — build, persistence, code, frontend, testing. At each gate it calls the MCP validators. |
| 4 | (when done) `./mvnw clean test` | 82 tests, 0 failures. Show the migration summary. |
| 5 | `./mvnw quarkus:dev` | Open `http://localhost:8090` and click through the app. |

**Key point:** The AI writes code, but deterministic validators catch what the AI misses. Every module has a gate.

### If the agent fails or takes too long

Show the pre-migrated result instead:

```bash
cd gotechworld-demo/spring-petclinic-quarkus   # already migrated
./mvnw clean test                               # 82 tests, 0 failures, 5 skipped
./mvnw quarkus:dev                              # open http://localhost:8090
```

Walk through `migration-summary.md` and the validator reports to explain what happened.

---

## Video

Full migration recording (~5 min): [Spring PetClinic Migration](https://drive.google.com/file/d/1Jspm0IhNVbjv7KfJJSta87N2d_41amqs/view?usp=sharing)

---

## Results

| Metric | Value |
|--------|-------|
| Source | Spring Boot 4.1.0, Java 17 |
| Target | Quarkus 3.40.1.1, Java 21 |
| Strategy | full-quarkus (no Spring compat layer) |
| Duration | ~19 minutes |
| Modules | 9 (1 skipped: no messaging) |
| Entities migrated | 6/6 (Panache Active Record) |
| Controllers migrated | 6/6 (JAX-RS + Qute) |
| Templates converted | 11 (Thymeleaf → Qute) |
| Tests | 82 run, 0 failures, 5 skipped |
| Verification checks | 6/6 PASS |

---

## Setup

Run `demo/setup.sh` to clone and build everything. See [demo/prompt.md](prompt.md) for the
exact prompt and [demo/migration-summary.md](migration-summary.md) for the full report.