setwd("/N/slate/danschw/new-phage-genome")
library(here)
library(tidyverse)

d <- read_tsv(here("assembly/bowtie2assembly/assembly.cvg"), col_names = c("chr", "position", "depth"))
avg <- round(mean(d$depth),0)

p <- ggplot(d, aes(position, depth))+
  geom_hline(yintercept = avg, color="grey")+
  geom_line()+
  theme_classic()+
  labs(caption = paste("average coverage =",avg))

ggsave(here("assembly/bowtie2assembly/map2assembly.png"), p, width = 10, height = 5)
