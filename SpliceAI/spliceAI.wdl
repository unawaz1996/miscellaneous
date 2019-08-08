workflow SpliceAI {
    call splitVCF 
    call splitChrom
    call spliceai
}

task splitVCF {
    File VCF 
    File OUTDIR
    command {
        bash split_VCF.sh \
        ${VCF}
        ${OUTDIR}
    }
    output {
        File sampleVCF = "${OUTDIR}"
    }
}

task splitChrom {
    File sampleVCF
    command {
        bash split_chrom.sh ${sampleVCF}
    }
}

task spliceai {
    File WhoEvenKnows
    command {
        bash spliceAI.sh
    }
}