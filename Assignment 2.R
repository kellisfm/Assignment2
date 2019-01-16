##Assignment 2 script. 
#Kai Ellis, 20019803
#This script will: 
#1 Load a file called InData.csv into a data.frame object
#2 Remove rows with total biomass < 60
#3 Reorder columns to: Total, Taxon, Scenario, Nutrients, and remove the rest
#4 convert the Total column from mg to grams and replace Total with TotalG
#5 Replace all periods with commas in the TotalG column
#6 If a column named Nutrients exists,  all strings with their first letter


#if dplyr or measurements is not already installed, run the following command(s)
#install.packages("dplyr")
#install.packages("measurements")

#These allow use of the dplyr and measurements commands in this document
library(dplyr)
library(measurements)

#import the csv
Fallo=read.csv("InData.csv")

#the select function keeps only the selected columns, in the order that they are typed
Fallo=select(Fallo,Total,Taxon,Scenario,Nutrients)


#filter allows the removal of all rows that do not fit the criteria
#in this case, all rows with a total biomass less than 60 are removed
Fallo=filter(Fallo,Total>=60)

#we can create a new TotalG column with the total grams via Fallo$TotalG
#to convert from mg to gram we use the conv_unit command found in the measurements package
Fallo$TotalG=conv_unit(Fallo$Total,"mg","g")

#next we can replace Total with TotalG, by using the select command again
Fallo=select(Fallo,TotalG,Taxon,Scenario,Nutrients)

#For the last two steps we use gsub to replace everthing in a particular column
#in the case of changing all periods to commas in TotalG we can use the following command
Fallo$TotalG=gsub("\\.",",",(Fallo$TotalG))
#the \\. selects all periods, while the "," says to replace with commas

#Finally, we run a check to see if there is a column named nutrients, if there is we replace any words
#longer than one letter with thier first letter
#(\\w) selects all letters and digets, \\w+ forces the selection to be on words/digets>1 letter long
#\\1 replaces the selected strings with thier first letter or diget
if ("Nutrients" %in% colnames(Fallo)) {
  Fallo$Nutrients=gsub("(\\w)\\w+","\\1",(Fallo$Nutrients))
}
