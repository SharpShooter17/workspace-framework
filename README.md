# Workspace Framework

The Workspace Framework enables the organization of work environments. The execution environment is
Linux / MacOS.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
    - [Framework Configuration](#framework-configuration)
    - [Workspace Configuration](#workspace-configuration)
- [Commands](#commands)
    - [Change Workspace](#change)
    - [Invoke Command in Workspace](#invoke-command-in-workspace)
    - [Create Workspace](#create)
    - [Current Workspace](#current)
    - [Drop Workspace](#drop)
    - [Help](#help)
    - [Install](#install)
    - [List Workspaces](#list)
    - [Open Workspace](#open)
    - [Uninstall](#uninstall)
    - [Update Workspace](#update)
- [Troubleshooting](#troubleshooting)
    - [Missing Autocompletion](#missing-autocompletion)

## Requirements

1. Zsh shell
2. Oh My Zsh framework
3. yq (YAML processor)
4. Git - required for the framework to work properly and manage repositories in the Workspace.

## Installation

To install the framework, run the following command:

```zsh
./workspace.sh install
```

The framework will be installed and configured in your environment. Shortcuts and autocompletion
will be added to the Zsh / Oh My Zsh environment.

## Usage

- Communication with the framework is done through the command line. The `workspace` command allows
  you to execute various commands.
- This framework allows for the management of multiple Workspaces on a device.
- All scripts are written for the Zsh shell.

## Configuration

### Framework Configuration

The `workspace.yml` file is used to configure the Workspace Framework. It contains settings related
to the current workspace and other configuration options.

#### Example

```yaml
config:
  current_workspace: default # The current workspace
```

### Workspace Configuration

Each Workspace has its own configuration file, `workspace.yml`. This file contains settings related
to the Workspace.

In the Workspace configuration file, you can define the following settings:

- `repositories` - a list of repositories that workspace should contain.

#### Example

```yaml
repositories:
  - git@github.com:example/example-1.git
  - git@github.com:example/example-2.git
```

## Commands

All command definitions are located in the `commands` directory. Each Workspace is configurable
through the `workspace.yml` file in the directory indicated by the environment
variable `WORKSPACE_<workspace-name>`.

### Change

Switches to the Workspace with the provided name and saves it in the configuration
file `workaspace.yml`.

```zsh
workspace change <workspace-name>
```

### Invoke command in Workspace

Executes the command in the current Workspace directory. The command must be provided as an
argument. Command scripts must be located in the `commands` directory of the Workspace.

```zsh
workspace cmd <command>
```

### Create

Creates a new Workspace with the specified name. If the Workspace already exists, an error message
will be displayed.

```zsh
workspace create <workspace-name>
```

### Current

Show the current workspace.

```zsh
workspace current
```

### Drop

Drop a workspace from the configuration file and delete the workspace directory.

```zsh
workspace drop <workspace-name>
```

### Help

Displays more commands available in the framework.

```zsh
workspace help
```

### Install

Install and configure the framework

```zsh
workspace install
```

### List

Lists all available workspaces.

```zsh
workspace list
```

### Open

Change directory to the workspace directory. If you provide a workspace name, it will change to that
workspace, otherwise it will change to the current workspace.

```zsh
workspace open <workspace-name>
```

### Uninstall

Uninstall the framework and remove workspace configuration file.

```zsh
workspace uninstall
```

### Update

Clone or update all repositories in the current workspace.

```zsh
workspace update
```

## Troubleshooting

### Missing autocompletion

If the autocompletion is not working, you can try to add the following line to your `.zshrc` file:

```zsh
autoload -U compinit
compinit
```