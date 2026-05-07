# Justfile - AI agent runner with pre/post execution hooks
# Run `just` or `just help` to see available recipes

set positional-arguments

# Default recipe - show help
[group: "Metadata"]
default:
    @just --list --unsorted

# Show available recipes with descriptions
[group: "Metadata"]
help:
    @just --list --unsorted

####################
# AI Agents
####################

# Run Claude with pre/post hooks
[group: "AI Agents"]
[positional-arguments]
claude *args:
    @just _run claude "$@"

# Run Codex with pre/post hooks
[group: "AI Agents"]
[positional-arguments]
codex *args:
    @just _run codex "$@"

# Run Pi with pre/post hooks
[group: "AI Agents"]
[positional-arguments]
pi *args:
    @just _run pi "$@"

# Run OpenCode with pre/post hooks
[group: "AI Agents"]
[positional-arguments]
opencode *args:
    @just _run opencode "$@"

####################
# Hooks
####################

# Run before an agent command
[group: "Hooks"]
pre-exec agent *args:
    npx -y skills@latest update -y
    agentsmesh import --from codex-cli
    agentsmesh generate

# Run after an agent command. Customize this recipe with your hook logic.
[group: "Hooks"]
post-exec agent status *args:
    @echo "post-exec: {{agent}} exited {{status}} {{args}}"

####################
# Internals
####################

# Run an agent command with pre/post hooks, preserving the agent exit status
[group: "Internals"]
[private]
[positional-arguments]
_run agent *args:
    @bash -euo pipefail -c '\
        agent="$1"; shift; \
        status=0; \
        just pre-exec "$agent" "$@"; \
        "$agent" "$@" || status=$?; \
        just post-exec "$agent" "$status" "$@"; \
        exit "$status" \
    ' -- "$@"
