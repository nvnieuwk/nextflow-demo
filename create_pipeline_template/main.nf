workflow {
    ch_pairs = Channel.fromFilePairs(params.input)

    BWAMEM2_INDEX(
        file(params.fasta),
        file(params.fai)
    )

    BWAMEM2(
        ch_pairs,
        BWAMEM2_INDEX.out
    )

}

process BWAMEM2_INDEX {
    container "quay.io/biocontainers/bwa-mem2:2.2.1--hd03093a_5"

    input:
    path(fasta)
    path(fai)

    output:
    path("index")

    script:
    """
    mkdir index
    bwa-mem2 index $fasta -p index/genome
    """
}

process BWAMEM2 {
    container "quay.io/biocontainers/bwa-mem2:2.2.1--hd03093a_5"

    publishDir "${params.outdir}/bwamem2", mode: 'copy'
    cpus 2

    input:
    tuple val(id), path(fastqs)
    path(index)

    output:
    path("*.sam")

    script:
    """
    bwa-mem2 mem -t $task.cpus $index/genome $fastqs -o ${id}.sam
    """
}