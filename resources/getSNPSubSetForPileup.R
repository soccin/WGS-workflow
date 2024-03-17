require(tidyverse)
DBSNP="/juno/depot/assemblies/S.scrofa/Sscrofa11.1/sus_scrofa.vcf.gz"
db=read_tsv(DBSNP,comment="#",col_names=F) %>%
    filter(grepl("TSA=SNV",X8)) %>%
    filter(grepl("E_Multiple_observations",X8)) %>%
    filter(!grepl(",",X5)) %>%
    mutate(R=row_number()) %>%
    mutate(X8=paste0(X8,";AF=0.1"))

mainChr=count(db,X1) %>% pull(X1) %>% grep("AEMK",.,invert=T,value=T)

set.seed(42);
dbr=db %>% filter(X1 %in% mainChr) %>% sample_n(35000) %>% arrange(R)

write_tsv(select(dbr,-R),"dbSNP_SubSet.vcf0",col_names=F)
