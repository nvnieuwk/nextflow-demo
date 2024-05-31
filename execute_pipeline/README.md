# Demo steps

1. Install Nextflow in a fresh conda environment

```bash
mamba create -n nextflow-demo -c bioconda -c conda-forge nextflow
mamba activate nextflow-demo
nextflow -version
```

2. Run sarek with the example test data

```bash
nextflow run nf-core/sarek -r 3.4.2 -params-file params.yaml -profile docker
```

3. Have a look at the output