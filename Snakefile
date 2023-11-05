configfile: "config/config.yaml"
SAMPLES = glob_wildcards(config["fastq"] + "{smp}.fq.gz").smp

# --- Build Rules --- #

## all                                : Build all final outputs
rule all:
    input:
        config["results"] + "read_counts/totalcounts_full.tsv",
        config["results"] + "read_counts/totalcounts_mid.tsv",
        config["results"] + "read_counts/uniquecounts_full.tsv",
        config["results"] + "read_counts/uniquecounts_mid.tsv",
        expand(config["results"] + "bigwig/{smp}.bw",smp=SAMPLES),
        config["results"] + "preprocess/QC/QC_fq.txt",
        config["results"] + "preprocess/QC/QC_bam.txt"


# --- Include Rules --- #
include: "rules/preprocess.smk"
include: "rules/align.smk"
include: "rules/preprocess_qc.smk"
include: "rules/map.smk"
include: "rules/bam2bw.smk"
include: "rules/tab.smk"
include: "rules/concat.smk"