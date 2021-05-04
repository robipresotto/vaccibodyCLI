# VacciBody CLI

The vaccibody command line interface has the following commands:
- Peptides/Proteome matcher

```sh
vaccibody match "peptides.fasta" "proteome.fasta"
```

the application returns the peptides/proteome matches in `json` format.

## Getting started

To build the solution from the source run `make`.
- make all - build the solution on linux and generates the peptides/proteome matches file.
- make build - build the solution on linux and generates the binary on `/Resources` folder.
- make run - run the solution and generates the peptides/proteome matches on the `/Resources` folder. (Note: provide the files /Resources/peptides.fasta + /Resources/proteome.fasta)

```
/Resources/peptides.fasta
/Resources/proteome.fasta
```

> To build on mac run make mac - the process will generate the XCode project file.