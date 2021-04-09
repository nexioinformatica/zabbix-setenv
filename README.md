# xabbix-setenv

[![test](https://github.com/nexioinformatica/zabbix-setenv/actions/workflows/test.yml/badge.svg)](https://github.com/nexioinformatica/zabbix-setenv/actions/workflows/test.yml)

Configure zabbix-docker environment and secrets. Manage them outside the `zabbix-docker` for easier updates and data management.

## Usage

Suppose you want to create the following structure

```
.
|-- zabbix-docker
|-- zabbix-setenv
`-- env
    |-- .POSTGRES_PASSWORD
    `-- zbx_env
```

This type of organization allows to manage easily zabbix versions inside `zabbix-docker`, indipendently update `zabbix-setenv` and manage or backup data within `env` folder.

Follow this steps:

1. Clone the [zabbix-docker](https://github.com/zabbix/zabbix-docker.git) repository and checkout the zabbix version of your interest, for example v5.2.

```bash
git clone https://github.com/zabbix/zabbix-docker.git && cd zabbix-docker
git checkout 5.2
```

2. Prepeare your env

```bash
mkdir env && cd env

touch .POSTGRES_PASSWORD  # edit this file with your postgres pw
mkdir zbx_env             # or copy an existing zbx_env folder
```

3. Run the `setenv.sh` script to arrange the environment.

```bash
export env_root="`pwd`/env"
export zbx_root="`pwd`/zabbix-docker"

git clone https://github.com/nexioinformatica/zabbix-setenv.git && cd zabbix-setenv
./setenv.sh
```

### Options

Tune the script behaviour by overriding the following env variables.

| Var                   | Type          | Default                                | Description                                  |
| --------------------- | ------------- | -------------------------------------- | -------------------------------------------- |
| `setenv_debug`        | `bool` \[^1\] | `0`                                    | Enable or disable debug. Set to 1 to enable. |
| `setenv_noprompt`     | `bool`        | `0`                                    | Enable or disable prompt confirmation.       |
| `env_root`            | `path`        | `pwd` \[^2\]                           | Set the env folder.                          |
| `env_passwd_filepath` | `path`        | `pwd/.POSTGRES_PASSWORD`               | Set the passwd env filepath.                 |
| `env_data_filepath`   | `path`        | `pwd/zbx_env`                          | Set the env data folder filepath.            |
| `zbx_root`            | `path`        | `pwd/zabbix-docker`                    | The path where configs are symlinked.        |
| `zbx_passwd_filepath` | `path`        | `pwd/zabbix-docker/.POSTGRES_PASSWORD` | The password filepath to symlink.            |
| `zbx_data_filepath`   | `path`        | `pwd/zabbix-docker/zbx_env`            | The data folder to symlink.                  |

\[^1\] Values in \{0, 1\}
\[^2\] The output of the `pwd` command

## Tests

```
cd tests && ./runall.sh
```

## Author

[Nexio Informatica Srl](https://nexioinformatica.com)

## Contributors

- [Luca Parolari](https://github.com/lparolari)

## License

MIT
