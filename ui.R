library(shiny)

shinyUI(bootstrapPage(
    uiOutput("login"),
    uiOutput("admin"),
    uiOutput("usr")
))