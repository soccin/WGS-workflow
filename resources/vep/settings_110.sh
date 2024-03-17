#!/bin/bash

VEPROOT=/juno/work/bic/socci/Work/Users/KimK/AulitzA/Proj_14579_B/resources/vep
export VEP_PATH=$VEPROOT/ensembl-vep-release-110
export VEP_DATA=$VEPROOT/vep_data_110
export VER=110
export PERL5LIB=$VEP_PATH:$PERL5LIB
export PATH=$VEP_PATH/htslib:$PATH

cd $VEP_PATH

perl INSTALL.pl --AUTO a --DESTDIR $VEP_PATH --CACHEDIR $VEP_DATA --NO_HTSLIB
perl INSTALL.pl --AUTO f --SPECIES sus_scrofa --ASSEMBLY Sscrofa11.1 --DESTDIR $VEP_PATH --CACHEDIR $VEP_DATA
