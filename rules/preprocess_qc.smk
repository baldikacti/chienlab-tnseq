# --- Seqkit QC --- #
## seqkit_grep                        : Removes reads that does not contain specific sequence
rule seqkit_qc_fastq:
    input:
        fastq = expand(config["results"] + "preprocess/{smp}{suff}.fq.gz",suff = ["_clipped", "_pruned"], smp = SAMPLES)
    output:
        fout = config["results"] + "preprocess/QC/QC_fq.txt"
    threads: 4
    shell:
        """
        seqkit stats -j {threads} {input.fastq} --quiet -a -T &> {output.fout}
        """

rule seqkit_qc_bam:
    input:
        bam = expand(config["results"] + "bwa_aln/{smp}{suff}",suff = [".bam", "_marked.bam"], smp = SAMPLES)
    output:
        bout = config["results"] + "preprocess/QC/QC_bam.txt"
    threads: 4
    shell:
        """
        seqkit bam -j {threads} -s {input.bam} --quiet &> {output.bout}
        """