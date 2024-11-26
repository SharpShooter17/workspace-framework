# Workspace Framework

The Workspace Framework enables the organization of work environments.
The execution environment is Linux / MacOS.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
    - [Framework Configuration](#framework-configuration)
    - [Workspace Configuration](#workspace-configuration)
- [Features](#features)
    - [Environment Variables](#environment-variables)
    - [Autocomplete](#autocomplete)
    - [Commands](#commands)
        - [Change Workspace](#change)
        - [Invoke Command in Workspace](#invoke-command-in-workspace)
        - [Create Workspace](#create)
        - [Current Workspace](#current)
        - [Drop Workspace](#drop)
        - [Export Environment Variables](#export-environment-variables)
        - [Help](#help)
        - [List Workspaces](#list)
        - [Open Workspace](#open)
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
chmode +x install.sh
./install.sh
```

The framework will be installed and configured in your environment.
Shortcuts and autocompletion will be added to the Zsh / Oh My Zsh environment.

## Usage

- Communication with the framework is done through the command line. The `workspace` command allows
  you to execute various commands.
- This framework allows for the management of multiple Workspaces on a device.
- All scripts are written for the Zsh shell.

### Example directory structure

```bash
WORKSPACES/                 # Workspace root directory
├───workspace-1/            # Workspace directory
│   ├───commands/           # Directory with workspace commands
│   │   └───command-1.sh    # Command script
│   ├───setup-command.sh    # Setup command script
│   └───workspace.yml       # Workspace configuration file
├───workspace-2/
.
.
├───workspace-n/
├───workspace-framework/    # Framework directory
│   ├───commands/           # Directory with framework commands
│   └───workspace.sh        # Framework main script
└───workspace.yml           # Framework configuration file
```

## Configuration

### Framework Configuration

The `workspace.yml` file is used to configure the Workspace Framework.
It contains settings related to the current workspace and other configuration options.

#### Example

```yaml
config:
  current_workspace: default # The current workspace
```

### Workspace Configuration

Each Workspace has its own configuration file, `workspace.yml`.
This file contains settings related to the Workspace.

In the Workspace configuration file, you can define the following settings:

- `repositories` - a list of repositories that workspace should contain.
- `commands` - a list of commands that can be executed in the Workspace.
- `command_directories` - a list of directories that contain command scripts.
- `env` - a list of environment variables that will be applied in terminal session.

#### Example

```yaml
repositories:
  - git@github.com:example/example-1.git
  - git@github.com:example/example-2.git

commands:
  - name: command-1
    script: dir-1/command-1.sh
  - name: command-2
    script: dir-2/command-2.sh

command_directories:
  - command-directory-1
  - command-directory-2

env:
  - name: ENV_VAR_1
    value: value-1
  - name: ENV_VAR_2
    value: value-2
```

## Features

The Workspace Framework provides the following features:

### Environment Variables

You can define environment variables in the Workspace configuration file.
These variables will be set in the terminal session.

### Autocomplete

The `workspace` command includes an autocomplete feature to help you quickly access available
commands and subcommands.
You can use the `Tab` key to autocomplete `workspace` commands and subcommands.
For example:

- Type `workspace ` and press `Tab` to see a list of available commands.
- Type `workspace cmd ` and press `Tab` to see a list of available commands from the current
  workspace configuration.
- Type `workspace change ` and press `Tab` to see a list of available workspaces.

The autocomplete feature will dynamically include commands from the `commands`
and `command_directories` sections of your `workspace.yml` file.

### Commands

All command definitions are located in the `commands` directory.
Each Workspace is configurable through the `workspace.yml` file in the directory indicated by the
environment variable `WORKSPACE_<workspace-name>`.

#### Change

Switches to the Workspace with the provided name and saves it in the configuration
file `workaspace.yml`.

```zsh
workspace change <workspace-name>
```

#### Invoke command in Workspace

Executes the command in the current Workspace directory.
The command must be provided as an argument.
If the command is not found, an error message will be displayed.
The command must be in the `commands` list in the Workspace configuration file.
If the command is not found on the list, the framework will search for the command in the
directories specified in the `command_directories` list.
If the command is not found in the directories, an error message will be displayed.
Path to the command script must be relative to the Workspace directory.

```zsh
workspace cmd <command>
```

#### Create

Creates a new Workspace with the specified name.
If the Workspace already exists, an error message will be displayed.

```zsh
workspace create <workspace-name>
```

#### Current

Show the current workspace.

```zsh
workspace current
```

#### Drop

Drop a workspace from the configuration file and delete the workspace directory.

```zsh
workspace drop <workspace-name>
```

#### Export environment variables

Exports environment variables defined in the Workspace configuration file.

```zsh
workspace export_env_vars
```

#### Help

Displays more commands available in the framework.

```zsh
workspace help
```

#### List

Lists all available workspaces.

```zsh
workspace list
```

#### Open

Change directory to the workspace directory.
If you provide a workspace name, it will change to that workspace, otherwise it will change to the
current workspace.

```zsh
workspace open <workspace-name>
```

#### Update

Clone or update all repositories in the current workspace.
Repositories will be cloned to the `WORKSPACE_ROOT/<workspace-name>/repositories` directory.

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