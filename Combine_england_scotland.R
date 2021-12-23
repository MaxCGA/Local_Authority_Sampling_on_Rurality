# code to combine rurality ratings across UK into single system
# https://github.com/MaxCGA/Local_Authority_Sampling_on_Rurality.git
# DATA:
# - England: DEFRA rurality index 2011: https://www.gov.uk/government/statistics/2011-rural-urban-classification-of-local-authority-and-other-higher-level-geographies-for-statistical-purposes
# - Scotland: Scotland Rural/urban classification index 2016: https://www.gov.scot/publications/scottish-government-urban-rural-classification-2016/pages/2/
rm(list = ls())
library("tidyverse")
library(dplyr) 

setwd("Inputs")

# load England data
df_england = read.csv("RUC11_LAD11_ENv2.csv", header = TRUE)
# load Scotland data
df_scotland = read.csv("Scotland_6Fold.csv")

# Make Scotland data into a 2-fold system comparable with the England data
binary_index_Scotland=matrix(1,length(df_scotland$ONS.code))
for(i in 1:length(df_scotland$ONS.code))
{
  if(df_scotland$Large.urban[i] + df_scotland$Other.urban[i] > 50.0) # 1 and 2 are urban categories
  {
    binary_index_Scotland[i] = 1
  }
  else
  {
    binary_index_Scotland[i] = 2
  }
}
df_scotland$Binary_index <- binary_index_Scotland

# Make Scotland data into a 2-fold system comparable with the England data
binary_index_England=matrix(1,length(df_england$LAD11CD))
for(i in 1:length(df_england$LAD11CD))
{
  if(df_england$RUC11CD[i] >= 4) #  4,5 and 6 are majority urban classifications
  {
    binary_index_England[i] = 1
  }
  else
  {
    binary_index_England[i] = 2
  }
}
df_england$Binary_index <- binary_index_England

# remove not relevant variables
df_england2 = transmute(df_england,LAD11CD,LAD11NM,Binary_index)
df_scotland2 = transmute(df_scotland,ONS.code,Council.Area,Binary_index)
colnames(df_england2) = colnames(df_scotland2)
# combine the dataframes
df_all = rbind(df_england2,df_scotland2)








