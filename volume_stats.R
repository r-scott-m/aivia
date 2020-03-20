#sudo R CMD javareconf (in terminal)
#install.packages("rJava",type='source')
#install.packages("xlsx")
#restart R studio

#Process aivia excel outputs and save data to Desktop.

library("xlsx")
setwd('~/Downloads/volume_stats') #directory where xlsx files are

my.files <- list.files()

df <- data.frame(File = character(),
                 Volume = double(),
                 SA = double(),
                 Bounding_Height = double(),
                 Bounding_Width = double(),
                 Bounding_Depth = double(),
                 stringsAsFactors=FALSE)

for(i in 1:length(my.files)){
  df[i,1] = my.files[i] #name of spreadsheet
  df[i,2] = sum(read.xlsx(my.files[i],1)[,2]) #sum, tab1, column2 (vol)
  df[i,3] = sum(read.xlsx(my.files[i],2)[,2]) #sum, tab2, column2 (surface area)
  df[i,4] = max(read.xlsx(my.files[i],4)[,2]) #max, tab4, column2 (bounding height)
  df[i,5] = max(read.xlsx(my.files[i],5)[,2]) #max, tab5, column2 (bounding width)
  df[i,6] = max(read.xlsx(my.files[i],6)[,2]) #max, tab6, column2 (bounding depth)
  print(paste("You are at file", i))
}


plot(df[,2],df[,3],xlab = "vol",ylab="sa")
hist(df[,2],main="vol")
hist(df[,3],main="SA")

write.table(df,
            file = "~/Desktop/031620_volumes_processed.txt",
            quote = FALSE,
            col.names=NA,
            sep="\t")
