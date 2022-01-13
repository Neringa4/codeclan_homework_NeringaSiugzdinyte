library(shiny)
library(tidyverse)
library(CodeClanData)
library(shinythemes)

publishers <- game_sales %>% 
  distinct(publisher) %>% 
  arrange(publisher) %>% 
  pull()

ui <- fluidPage(
  
  theme = shinytheme("superhero"),
  
  titlePanel(h1("Average Game Ratings Over Time",
                align = "center")),
  
  HTML("<br>"),
  
  fluidRow(
    selectInput(
      inputId = "publisher",
      label = h3("Publisher"),
      choices = publishers
    ),
    align = "center",
    style = "font-size:15px;"
  ),
  
  HTML("<br>"),
  
  
  fluidRow(
    column(
      width = 1
    ),
    column(
      width = 10,
      plotOutput("games_Plot")
    ),
    column(
      width = 1,
    )
  ),
  
  HTML("<br>")
  
)


server <- function(input, output) {
  
  output$games_Plot <- renderPlot({
    
    game_sales %>%
      mutate(user_score = user_score*10) %>% 
      pivot_longer(critic_score:user_score, 
                   names_to = "score_type", 
                   values_to = "score") %>% 
      group_by(year_of_release, publisher, score_type) %>% 
      summarise(avg_score = mean(score)) %>% 
      filter(publisher == input$publisher) %>% 
      
      ggplot(aes(x = year_of_release, y = avg_score, colour = score_type)) +
      geom_line(size = 1) +
      labs(x = "\nYear of Release",
           y = "Average Score\n",
           colour = "",
           title = "") +
      scale_colour_discrete(labels = c("Critic Rating", "User Rating")) +
      ylim(0, 100) +
      theme_light() +
      theme(text = element_text(size = 20))
    
  })
}


shinyApp(ui = ui, server = server)
