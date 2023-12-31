# --- Clipping --- #
## Clipping                         : Clips the UMI's and makes them headers using Je
rule clip:
    input:
        data = config["fastq"] + "{smp}.fq.gz",
        je = config["script"] + "je_1.2_bundle.jar"
    output:
        config["results"] + "preprocess/{smp}_clipped.fq.gz"
    params:
        outdir = config["results"] + "preprocess"
    resources:
        mem_mb=lambda wildcards, attempt: attempt * 6000
    shell:
        "java -Xmx{resources.mem_mb}m -jar {input.je} clip F1={input.data} LEN=6 O={params.outdir}"

# --- Seqkit Pruning --- #
## seqkit_grep                        : Removes reads that does not contain specific sequence
rule seqkit_grep:
    input:
        config["results"] + "preprocess/{smp}_clipped.fq.gz"
    output:
        config["results"] + "preprocess/{smp}_pruned.fq.gz"
    params:
        tn_filter = config["transposon_static_region"]
    threads: 4
    shell:
        "zcat < {input} | seqkit grep --threads {threads} --by-seq --ignore-case --pattern {params.tn_filter} -o {output}"