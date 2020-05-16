#import package
library(here)
library(ggplot2)

#read file into R
df1 <- read.csv(here("data","daftar-importir-2019-.csv"))
summary(df1) #it is literally a list of importer in the city

df2 <- read.csv(here("data","data-siup-kota-batu-2017-.csv"),header=FALSE)
summary(df2) #another hard to digest data

df3 <- read.csv(here("data","jumlah-pohon-menghasilkan-dan-produksi-buah-2016.csv"),header=FALSE)
summary(df3) #much better
