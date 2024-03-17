require(tidyverse)

MAX_LEN=100
mainChromosomes=read_tsv("genome_main.bed",col_names=F) %>% pull(X1)

argv=commandArgs(trailing=T)

bed0=read_tsv(argv[1],comment="@",col_names=F) %>%
    mutate(X2=X2-1) %>%
    mutate(RID=row_number()) %>%
    mutate(LEN=(X3-X2)/1e6) %>%
    filter(X1 %in% mainChromosomes)


bed=bed0
get_next_batch<-function(bb) {
    bb=arrange(bb,desc(LEN))
    if(any(bb$LEN>MAX_LEN)) {
        return(bb$RID[1])
    }
    batch=bb[1,]
    bb=bb[-1,]
    while(sum(batch$LEN)<MAX_LEN) {
        rid=bb %>% filter(LEN<MAX_LEN-sum(batch$LEN)) %>% slice(1) %>% pull(RID)
        if(len(rid)>0) {
            batch=bind_rows(batch,filter(bb,RID==rid))
            bb=bb %>% filter(RID!=rid)
        } else {
            break
        }
    }
    return(batch$RID)
}

batches=list()
while(nrow(bed)>0) {
    regions=get_next_batch(bed)
    if(is.null(regions)) {
        break
    }
    batches[[len(batches)+1]]=bed %>% filter(RID %in% regions)
    bed=bed %>% filter(!(RID %in% regions))
}

ii=1
base=gsub(".interval_list","",basename(argv[1]))
ODIR=file.path("scatter",base)
fs::dir_create(ODIR)

for(bi in batches) {

    bi %>%
        arrange(factor(X1,levels=unique(bed0$X1)),X2) %>%
        select(X1,X2,X3) %>%
        write_tsv(file.path(ODIR,sprintf("%s_scatter_%02d.bed",base,ii)),col_names=F)
    ii=ii+1

}
