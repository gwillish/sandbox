# Sandbox

A Container file setup to run agentic coding agents in isolation.

Working out how and what's needed to enable the equivalent of docker sandbox with [Apple container](https://github.com/apple/container) OCI runtime.

Created for working on Swift projects that compile on Linux.

## Set it up locally

```bash
container build -t sandbox .
```

## Run it

```bash
container run --rm -it \
    -e GEMINI_API_KEY=... \
    -v "$(pwd)$:/src" \
    sandbox
```