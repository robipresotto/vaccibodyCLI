# VacciBody CLI

The vaccibody command line interface is designed to run the following commands:
- [x] Peptides/Proteome matcher
- [x] Help
- [ ] WIP

## Getting started

To build the solution from the source run `make`.
- `make init` - build the solution on linux - generates the binary and the peptides/proteome matches file output.
- `make build` - build the solution on linux and generates the binary on `/Resources` folder.
- `make run` - run the solution and generates the peptides/proteome matches on the `/Resources` folder. (Note: provide the files /Resources/peptides.fasta + /Resources/proteome.fasta on the build step).
- `make clean` - deletes the container
```
/Resources/peptides.fasta
/Resources/proteome.fasta
```

### Usage
```sh
USAGE: vaccibody <subcommand>

OPTIONS:
  -h, --help              Show help information.

SUBCOMMANDS:
  match                   Scan a list of short peptides against the proteome and returns the matches

See 'vaccibody help <subcommand>' for detailed help.
```

Example:
```sh
vaccibody match "/peptides.fasta" "/proteome.fasta"
```

`match` command returns the peptides/proteome matches in `json` format on the root path.

### Building on XCode
To build on mac run `make mac` - the process will download the dependencies and generate the XCode project file.

> To run the unit tests the project requires the following environment variables:

```
PROTEOME_FILE_PATH=/Resources/proteome.fasta
PEPTIDES_FILE_PATH=/Resources/peptides.fasta
```
