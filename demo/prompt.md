# Migration prompt

First, clone the skill:

```bash
git clone https://github.com/quarkusio/skills.git quarkus-skills
```

Then, from the `spring-petclinic` project directory:

```bash
claude -p "Migrate this Spring Boot project to Quarkus. Strategy: full-quarkus, Java 21, persistence: panache-active-record." \
  --permission-mode acceptEdits \
  --append-system-prompt "$(cat ../quarkus-skills/skills/migrate-spring-to-quarkus/SKILL.md)"
```

The skill is open source:
<https://github.com/quarkusio/skills/tree/main/skills/migrate-spring-to-quarkus>

Before running the prompt, start mtools (the deterministic validators) as an MCP server
in a separate terminal so Claude Code can call them during migration:

```bash
git clone https://github.com/snowdrop/migration-tool.git
cd migration-tool/mcp
quarkus dev -Dmtool.allowed-dirs=<generated-project-path>,<source-project-path>
```