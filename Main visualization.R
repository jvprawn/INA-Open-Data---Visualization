#import package
library(here)
library(ggplot2)

#read file into R

#first file
df1 <- read.csv(here("data","daftar-importir-2019-.csv"))
summary(df1) #it is literally a list of importer in the city

#second file
df2 <- read.csv(here("data","data-siup-kota-batu-2017-.csv"),header=FALSE)
summary(df2) #another hard to digest data

#third file
df3 <- read.csv(here("data","jumlah-pohon-menghasilkan-dan-produksi-buah-2016.csv"),header=FALSE,stringsAsFactors = FALSE)
summary(df3) #incomplete but much better
#get every column class
sapply(df3, class)
#examine empty cell
colSums(is.na(df3))
colSums(df3 == "")

#merge two row after the title to create header name
nama=c()
for (x in (1:9)) {
  if (df3[3,x]=="") {
    kategori <- make.names(paste0(df3[3,x-1],df3[4,x]))
    }  else {
    kategori <- make.names(paste(df3[3,x],df3[4,x]))
    }
  
  nama <- append(nama,kategori,after = length(nama))
}
colnames(df3) <- nama

#remove description row
new_df3 <- df3[-c(1:4,30,31),]
#check column type
str(new_df3)
#convert into numeric vector
new_df3$Triwulan.I..Jumlah.Tanaman. <- as.numeric(as.vector(new_df3$Triwulan.I..Jumlah.Tanaman.))

colnames(new_df3)

#Not the best way but it works so far
barplot(as.numeric(as.vector(new_df3$Triwulan.I..Jumlah.Tanaman.)),
        names.arg = new_df3$Jenis.Tanaman..
        )
#It is also work finally but it's not looks that neat
ggplot(new_df3,aes(x=Jenis.Tanaman.., y=Triwulan.I..Jumlah.Tanaman.))+
  geom_bar(stat="identity")+
  coord_flip()

  #theme(axis.text.x = element_text(face="bold", color="#993333", 
   #                              size=14, angle=45),
    #  axis.text.y = element_text(face="bold", color="#993333", 
     #                            size=14, angle=45))

#reference: https://www.r-graph-gallery.com/301-custom-lollipop-chart.html#horiz
ggplot(new_df3, aes(x=Jenis.Tanaman.., y=Triwulan.I..Jumlah.Tanaman.)) +
  geom_segment( aes(x=Jenis.Tanaman.., xend=Jenis.Tanaman.., y=0, yend=Triwulan.I..Jumlah.Tanaman.), color="skyblue") +
  geom_point( color="blue", size=4, alpha=0.6) +
  theme_light() +
  coord_flip() +
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )

#fourth file
df4 <- read.csv(here("data","jumlah-tokoh-agama-di-kota-batu-tahun-2017-2019.csv"),header=FALSE)
summary(df4) #incomplete but much better

#fifth file
df5 <- read.csv(here("data","luas-panen-pertanian-2016-2018.csv"),header=FALSE)
summary(df5)
