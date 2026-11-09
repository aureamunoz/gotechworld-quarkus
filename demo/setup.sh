#!/usr/bin/env bash
set -euo pipefail

# Clones and builds everything needed for the GoTech World 2026 demo.
# Run from anywhere; repos land in ../gotechworld-demo relative to this script.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEMO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)/gotechworld-demo"
mkdir -p "$DEMO_DIR"

# --- spring-petclinic (the app we migrate) ---
PETCLINIC_DIR="$DEMO_DIR/spring-petclinic"
PETCLINIC_COMMIT="500158f732419217507c7656904b8e6aa1bcc0d6"
if [ -d "$PETCLINIC_DIR" ]; then
  echo "spring-petclinic already cloned, skipping."
else
  git clone https://github.com/spring-projects/spring-petclinic.git "$PETCLINIC_DIR"
  git -C "$PETCLINIC_DIR" checkout "$PETCLINIC_COMMIT"
fi
echo "Building spring-petclinic..."
./mvnw -q install -DskipTests -f "$PETCLINIC_DIR/pom.xml"

# --- migration-tool (mtools — deterministic validators, MCP server) ---
MTOOL_DIR="$DEMO_DIR/migration-tool"
MTOOL_COMMIT="6b5c0f5dfcae81ca782b28d2d4eff96d637891e8"
if [ -d "$MTOOL_DIR" ]; then
  echo "migration-tool already cloned, skipping."
else
  git clone https://github.com/snowdrop/migration-tool.git "$MTOOL_DIR"
  git -C "$MTOOL_DIR" checkout "$MTOOL_COMMIT"
fi
echo "Building migration-tool..."
./mvnw -q install -DskipTests -f "$MTOOL_DIR/pom.xml"

# --- quarkus-skills (the migration skill for Claude Code) ---
SKILLS_DIR="$DEMO_DIR/quarkus-skills"
if [ -d "$SKILLS_DIR" ]; then
  echo "quarkus-skills already cloned, skipping."
else
  git clone https://github.com/quarkusio/skills.git "$SKILLS_DIR"
fi

# --- copy spring-petclinic to the migration target directory ---
PETCLINIC_QUARKUS_DIR="$DEMO_DIR/spring-petclinic-quarkus"
if [ -d "$PETCLINIC_QUARKUS_DIR" ]; then
  echo "spring-petclinic-quarkus already exists, skipping copy."
else
  cp -R "$PETCLINIC_DIR" "$PETCLINIC_QUARKUS_DIR"
  echo "Copied spring-petclinic to spring-petclinic-quarkus."
fi

echo ""
echo "Done. Next steps:"
echo ""
echo "  1. Start mtools (in a separate terminal):"
echo "     cd $MTOOL_DIR && quarkus dev -Dmtool.allowed-dirs=$DEMO_DIR"
echo ""
echo "  2. Run the migration (in another terminal):"
echo "     cd $PETCLINIC_QUARKUS_DIR"
echo "     claude -p \"Migrate this Spring Boot project to Quarkus\" \\"
echo "       --permission-mode acceptEdits \\"
echo "       --append-system-prompt \"\\\$(cat $SKILLS_DIR/skills/migrate-spring-to-quarkus/SKILL.md)\""