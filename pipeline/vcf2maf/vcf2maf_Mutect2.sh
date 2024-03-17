#!/bin/bash

set -e

SDIR="$( cd "$( dirname "$0" )" && pwd )"

PERL=/opt/common/CentOS_7/perl/perl-5.22.0/bin/perl
VCF2MAF=$SDIR/vcf2maf-1.6.21/vcf2maf.pl

source bundle.sh

VCF=$1
NORMAL=$(zcat $VCF | head -1000 | fgrep normal_sample | sed 's/.*=//')
TUMOR=$(zcat $VCF | head -1000 | fgrep tumor_sample | sed 's/.*=//')

if [ -e /fscratch ]; then
    export TMPDIR=/fscratch/socci/vcf2maf
else
    export TMPDIR=/scratch/socci/vcf2maf
fi

mkdir -p $TMPDIR
TDIR=$(mktemp -d)
echo \$TDIR=$TDIR

trap 'rm -rf $TDIR' EXIT

zcat $VCF >$TDIR/vcf.vcf

OUTPUT=$(echo $VCF | sed 's/\.vcf.*/.maf/')
echo $OUTPUT

$PERL $VCF2MAF \
    --input-vcf $TDIR/vcf.vcf \
    --normal-id $NORMAL\
    --tumor-id $TUMOR \
    --output-maf $TDIR/maf.maf \
    --ref-fasta $GENOME \
    --vep-path $VEPPATH \
    --vep-data $VEPDATA \
    --species $VEPSPECIES \
    --ncbi-build $VEPBUILD \
    --vep-forks 12

rsync -avP $TDIR/maf.maf $OUTPUT

md5sum $TDIR/maf.maf
md5sum $OUTPUT

