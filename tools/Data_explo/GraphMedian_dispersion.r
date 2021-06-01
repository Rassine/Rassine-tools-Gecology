#Rscript

################################
##    Median and dispersion   ##
################################

#####Packages : Cowplot
#		ggplot2

#####Load arguments

args = commandArgs(trailingOnly = TRUE)

if(length(args)==0)
{
    stop("This tool needs at least one argument")
}else{
    Table <- args[1]
	var1 <- as.numeric(args[2])
	var2 <- as.numeric(args[3])
	HR <- args[4]
}

if (HR == "false"){HR <- FALSE} else {HR <- TRUE}

#####Import data
Data <- read.table(Table, sep = "\t", dec = ".", header = HR, fill = TRUE, encoding = "UTF-8")
Data <- na.omit(Data)
colvar1 <- colnames(Data)[var1]
colvar2 <- colnames(Data)[var2]
#####Your analysis

####Median and data dispersion####

#Median
graph_median <- function(Data, var1){
  graph_median <- ggplot2::ggplot(Data, ggplot2::aes_string(y = var1)) + 
  ggplot2::geom_boxplot(color="darkblue") +
  ggplot2::theme(legend.position = "none") + ggplot2::ggtitle("Median")
  
return(graph_median)

}

#Dispersion
dispersion <- function(Data, var1, var2){
  graph_dispersion <- ggplot2::ggplot(Data) +
  ggplot2::geom_point(ggplot2::aes_string(x = var2, y = var1, color = var2)) +
  ggplot2::scale_fill_brewer(palette = "Set3") +
  ggplot2::theme(legend.position = "none", axis.text.x = ggplot2::element_text(angle = 90, vjust = 0.5, hjust = 1), plot.title = ggplot2::element_text(color = "black", size = 12, face = "bold")) + ggplot2::ggtitle("Dispersion")

return(graph_dispersion) 

}

#The 2 graph
MD <- function(med, disp){
  graph <- cowplot::plot_grid(med, disp, ncol = 1, nrow = 2, vjust = -5,  scales = "free")

  ggplot2::ggsave("Med_Disp.png", graph, width=12, height=20, units="cm")
}

MD(med = graph_median(Data, var1 = colvar1), disp = dispersion(Data, var1 = colvar1, var2= colvar2))
