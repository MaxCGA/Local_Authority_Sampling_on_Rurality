rm(list = ls())
library("tidyverse")
library(dplyr) 

setwd('Outputs')
read.csv('Binary_index.csv',header = TRUE)

#### stratified random sampling ####
num_urban = sum(df_all$Binary_index == 1)
num_rural = sum(df_all$Binary_index == 2)
prop_urban = num_urban/(num_urban+num_rural)

# check (should be true)
#sum(num_urban,num_rural) == length(df_all$Binary_index)

n_to_sample = 50 # set n local authorities to sample
# work out n to sample from each
n_urban_to_sample = round(prop_urban*n_to_sample)
n_rural_to_sample = round((1-prop_urban)*n_to_sample)

# sample urban
urban_selected_indices = sample(1:num_urban,n_urban_to_sample,replace = F)
rural_selected_indices = sample(1:num_rural,n_rural_to_sample,replace = F)

# pull out the selected local authorities
# Urban ones
urbans=which(df_all$Binary_index == 1)
Urban_selected_ONScodes = df_all$ONS.code[urbans[urban_selected_indices]]
Urban_selected_LAs = df_all$Council.Area[urbans[urban_selected_indices]]
# Rural ones
rurals=which(df_all$Binary_index == 2)
Rural_selected_ONScodes = df_all$ONS.code[rurals[rural_selected_indices]]
Rural_selected_LAs = df_all$Council.Area[rurals[rural_selected_indices]]

print(Rural_selected_LAs)
print(Urban_selected_LAs)