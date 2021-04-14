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
export source_root="`pwd`/env"
export target_root="`pwd`/zabbix-docker"

git clone https://github.com/nexioinformatica/zabbix-setenv.git && cd zabbix-setenv
./setenv.sh
```

### Options

Tune the script behaviour by overriding the following env variables. Variables types are reported in the table below.

**Variables**

| Var                   | Type   | Default                                 | Description                                                     |
| --------------------- | ------ | --------------------------------------- | --------------------------------------------------------------- |
| `setenv_debug`        | _bool_ | `0` (i.e., disabled)                    | Enable or disable debug.                                        |
| `setenv_noprompt`     | _bool_ | `0` (i.e., disabled)                    | Enable or disable prompt confirmation.                          |
| `setenv_use_defaults` | _bool_ | `0` (i.e., disabled)                    | Enable or disable defaults. This prevent unintented executions. |
| `setenv_root`         | _path_ | `pwd` (i.e., current working directory) | Path to script root. (This is used to _source_ other scripts)   |

**Types**

| Type   | Values                      | Description and Notes                                                                   |
| ------ | --------------------------- | --------------------------------------------------------------------------------------- |
| _bool_ | `0`, `1`                    | Even if we are in bash, for readability reason we use `0` as _false_ and `1` as _true_. |
| _path_ | A valid path (posix format) | Please note that we do not check path correctenss.                                      |

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
