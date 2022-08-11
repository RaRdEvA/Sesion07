
library(DBI)
library(RMySQL)
library(ggplot2)
library(dplyr)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

dbListFields(MyDataBase, 'CountryLanguage')

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
DataDB$bool <- ifelse(DataDB$IsOfficial == 'T', 1, 0)

dbDisconnect(MyDataBase)

class(DataDB)
head(DataDB)
summary(DataDB)

pop.spa <-  DataDB %>% filter(Language == 'Spanish') %>% select(CountryCode,Language,Percentage)

pop.spa

ggplot(pop.spa, aes( x = CountryCode, y=Percentage )) + 
  geom_bar(stat = "identity")
