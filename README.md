# Workspace Framework

The Workspace Framework enables the organization of work environments. The execution environment is
Linux / MacOS.

## Requirements

1. Zsh shell
2. Oh My Zsh framework

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

## Commands

All command definitions are located in the `commands` directory. Each Workspace is configurable
through the `workspace.yaml` file in the directory indicated by the environment
variable `WORKSPACE_<workspace-name>`.

#### Change Workspace

Switches to the Workspace with the provided name and saves it in the configuration
file `config.yaml`.

```zsh
workspace change <workspace-name>
```

#### Create Workspace

Creates a new Workspace with the specified name. If the Workspace already exists, an error message
will be displayed.

```zsh
workspace create <workspace-name>
```

#### Current Workspace

Show the current workspace.

```zsh
workspace current
```

#### Drop

Drop a workspace from the configuration file and delete the workspace directory.

```zsh
workspace drop <workspace-name>
```

#### Help

Displays more commands available in the framework.

```zsh
workspace help
```

#### Install

Install and configure the framework

```zsh
workspace install
```

#### List Workspace

Lists all available workspaces.

```zsh
workspace list
```

#### Open

Change directory to the workspace directory. If you provide a workspace name, it will change to that
workspace, otherwise it will change to the current workspace.

```zsh
workspace open <workspace-name>
```

#### Uninstall

Uninstall the framework

```zsh
workspace uninstall
```