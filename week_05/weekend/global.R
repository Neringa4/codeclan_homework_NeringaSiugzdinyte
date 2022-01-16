library(shiny)
library(tidyverse)
library(CodeClanData)
library(shinythemes)

publishers <- game_sales %>% 
  distinct(publisher) %>% 
  arrange(publisher) %>% 
  pull()

genres <- game_sales %>% 
  distinct(genre) %>% 
  arrange(genre) %>% 
  pull()

platforms <- game_sales %>% 
  distinct(platform) %>% 
  arrange(platform) %>% 
  pull()