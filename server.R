library(shiny)
library(DBI)
library(RMySQL)
library(DT)
library(data.table)
library(readxl)
library(stringr)
source("conect.R")
source("depurar.R")

shinyServer(function(input, output, session) {
  ####FUNCION DE LOGIN####
  output$login=renderUI({
    fluidPage(
      includeScript("entre.js"),
      mainPanel(
        titlePanel("DIRECTORIO DE ANEXOS"),
        textInput("usuario", "USUARIO"),
        passwordInput("pw", "CLAVE"),
        actionButton("entrar", "ENTRAR")
      ))
  })
  ####LOGIN ADMIN####
  observeEvent(input$entrar,{
    output$admin=renderUI({
      if (toString(input$usuario)=="admin" && toString(input$pw)=="mdy12345") {
        removeUI(selector = "#login")
        fluidPage(
          includeScript("entre.js"),
          tags$header(
            titlePanel("DIRECTORIO")),
          column(3,
                 wellPanel(
                   tags$h5("BUSQUEDA!"),
                   # nombre
                   textInput("nombre",label = "Nombre Completo"),
                   actionButton("bnombre",label = "BUSCAR NOMBRE"),
                   # campaña
                   textInput("campa",label = "campa"),
                   actionButton("bcampa",label = "BUSCAR CAMPA"),
                   # anexo
                   textInput("anexo",label = "Anexo"),
                   actionButton("banexo",label = "BUSCAR ANEXO"),
                   # cel
                   textInput("cel",label = "Celular"),
                   actionButton("bcel",label = "BUSCAR CELULAR"),
                   # SEDE
                   selectInput("sede", label = "Sede", choices = list("LINCE","MAGDALENA","COLONIAL")),
                   actionButton("bsede",label = "BUSCAR SEDE"),
                   # cargo
                   textInput("cargo",label = "Cargo"),
                   actionButton("bcargo",label = "BUSCAR CARGO")
                   
                 )
          ),
          column(7,
                 uiOutput("confir"),
                 wellPanel(
                   tags$h3("DATA!"),
                   DT::dataTableOutput("resultado"))
          ),
          column(1,
                 tags$h5("ACCIONES!"),
                 actionButton("bmostrar",label = "MOSTRAR"),
                 actionButton("binsert",label = "INGRESA"),
                 actionButton("bdelete",label = "BORRA"),
                 hr(),
                 tags$h6("Ingresa el archivo a cargar"),
                 fileInput("datax", label = "ARCHIVO", accept = ".xlsx"),
                 actionButton("bmasiva",label = "CARGA"),
                 actionButton("bingrem", label = "INGRESA")
                 # actionButton("blogout",label = "LOG OUT")
                 # hr(),
                 # tags$h6("Descarga la plantilla!"),
                 # downloadButton("bplantilla", label = "PLANTILLA")
          )
        )
      }
    })
  })
  ####LOGIN USER####
  observeEvent(input$entrar,{
    output$usr=renderUI({
      if (toString(input$usuario)=="mdyuser" && toString(input$pw)=="12345") {
        removeUI(selector = "#login")
        fluidPage(
          includeScript("entre.js"),
          tags$header(
            titlePanel("DIRECTORIO")
          ),
          column(3,
                 wellPanel(
                   tags$h5("BUSQUEDA!"),
                   # nombre
                   textInput("nombre",label = "Nombre Completo", value = ""),
                   actionButton("bnombre",label = "BUSCAR NOMBRE"),
                   # campaña
                   textInput("campa",label = "campa", value = ""),
                   actionButton("bcampa",label = "BUSCAR CAMPA"),
                   # anexo
                   textInput("anexo",label = "Anexo", value = ""),
                   actionButton("banexo",label = "BUSCAR ANEXO"),
                   # cel
                   textInput("cel",label = "Celular"),
                   actionButton("bcel",label = "BUSCAR CELULAR"),
                   # SEDE
                   selectInput("sede", label = "Sede", choices = list("LINCE","MAGDALENA","COLONIAL")),
                   actionButton("bsede",label = "BUSCAR SEDE"),
                   # cargo
                   textInput("cargo",label = "Cargo"),
                   actionButton("bcargo",label = "BUSCAR CARGO")
                   
                 )
          ),
          column(7,
                 wellPanel(
                   tags$h3("DATA!"),
                   DT::dataTableOutput("resultado"))
          ),
          column(1,
                 tags$h5("ACCIONES!"),
                 actionButton("bmostrar",label = "MOSTRAR")
                 
          )
          
        )
      }
    })
  })
  
  
  ####Variable en la que se guarda los libros de excel a cargar####
  tabledata=0
  
  
  ####Coneccion para mostrar el directorio apenas se abre la pagina####
  conn=connectMySQL()
  res = dbSendQuery(conn, "select * from catalogo")
  datafinal = dbFetch(res,n=-1)
  dbClearResult(res)
  dbDisconnect(conn)
  output$resultado=DT::renderDataTable(datafinal[,2:7],server = FALSE)
  
  
  #####FUNCIONES DE BUSQUEDA####
  observeEvent(input$bnombre,{
    conn=connectMySQL()
    consulta1="Select * From catalogo ca where ca.nombre LIKE '%"
    consulta2="%'"
    consultaquery=paste(consulta1,toString(input$nombre),consulta2,sep = "")
    res = dbSendQuery(conn, consultaquery)
    result = dbFetch(res,n=-1)
    datafinal<<-result
    output$resultado=DT::renderDataTable(datafinal[,2:7],server = FALSE)
    updateTextInput(session,inputId = "nombre", value = "")
    dbClearResult(res)
    dbDisconnect(conn)
  })
  observeEvent(input$bcampa,{
    conn=connectMySQL()
    consulta1="Select * From catalogo ca where ca.campa LIKE '%"
    consulta2="%'"
    consultaquery=paste(consulta1,toString(input$campa),consulta2,sep = "")
    res = dbSendQuery(conn, consultaquery)
    result = dbFetch(res,n=-1)
    datafinal<<-result
    output$resultado=DT::renderDataTable(datafinal[,2:7],server = FALSE)
    updateTextInput(session,inputId = "campa", value = "")
    dbClearResult(res)
    dbDisconnect(conn)
  })
  observeEvent(input$banexo,{
    conn=connectMySQL()
    consulta1="Select * From catalogo ca where ca.anexo LIKE '%"
    consulta2="%'"
    consultaquery=paste(consulta1,toString(input$anexo),consulta2,sep = "")
    res = dbSendQuery(conn, consultaquery)
    result = dbFetch(res,n=-1)
    datafinal<<-result
    output$resultado=DT::renderDataTable(datafinal[,2:7], server=FALSE)
    updateTextInput(session,inputId = "anexo", value = "")
    dbClearResult(res)
    dbDisconnect(conn)
  })
  observeEvent(input$bcel,{
    conn=connectMySQL()
    consulta1="Select * From catalogo ca where ca.cel LIKE '%"
    consulta2="%'"
    consultaquery=paste(consulta1,toString(input$cel),consulta2,sep = "")
    res = dbSendQuery(conn, consultaquery)
    result = dbFetch(res,n=-1)
    datafinal<<-result
    output$resultado=DT::renderDataTable(datafinal[,2:7],server=FALSE)
    updateTextInput(session,inputId = "cel", value = "")
    dbClearResult(res)
    dbDisconnect(conn)
  })
  observeEvent(input$bsede,{
    conn=connectMySQL()
    consulta1="Select * From catalogo ca where ca.sede LIKE '%"
    consulta2="%'"
    consultaquery=paste(consulta1,toString(input$sede),consulta2,sep = "")
    res = dbSendQuery(conn, consultaquery)
    result = dbFetch(res,n=-1)
    datafinal<<-result
    output$resultado=DT::renderDataTable(datafinal[,2:7],server=FALSE)
    dbClearResult(res)
    dbDisconnect(conn)
  })
  observeEvent(input$bcargo,{
    conn=connectMySQL()
    consulta1="Select * From catalogo ca where ca.cargo LIKE '%"
    consulta2="%'"
    consultaquery=paste(consulta1,toString(input$cargo),consulta2,sep = "")
    res = dbSendQuery(conn, consultaquery)
    result = dbFetch(res,n=-1)
    datafinal<<-result
    output$resultado=DT::renderDataTable(datafinal[,2:7],server=FALSE)
    updateTextInput(session,inputId = "cargo", value = "")
    dbClearResult(res)
    dbDisconnect(conn)
  })
  
  
  #####FUNCION DE INGRESO DE DATOS####
  observeEvent(input$binsert,{
    conn=connectMySQL()
    flag=0
    if(input$nombre=="" || input$campa=="" ||  input$anexo==""){
      flag=1
    }
    if (flag==0) {
    
    consulta1="insert into catalogo(nombre, campa, anexo, cel, sede,cargo) value ('"
    consulta2="', '"
    consulta3="')"
    consultaquery=paste(consulta1,
                        toString(input$nombre),consulta2,toString(input$campa),
                        consulta2,toString(input$anexo),consulta2,toString(input$cel),
                        consulta2,toString(input$sede),consulta2,toString(input$cargo),
                        consulta3,sep = "")
      existe=match(as.numeric(input$anexo),datafinal[,4],nomatch=0)
      if (existe==0 && flag==0) {
        dbSendQuery(conn,consultaquery)
        updateTextInput(session,inputId = "nombre", value = "")
        updateTextInput(session,inputId = "campa", value = "")
        updateTextInput(session,inputId = "anexo", value = "")
        updateTextInput(session,inputId = "cel", value = "")
        updateTextInput(session,inputId = "cargo", value = "")
      }else{
        output$confir=renderUI("INGRESASTE UN ANEXO YA EXISTENTE!")
      }
    }else{
      output$confir=renderUI("INGRESA LOS VALORES NECESARIOS")
    }
    
    consultaquery2="select * from catalogo"
    res = dbSendQuery(conn, consultaquery2)
    result = dbFetch(res,n=-1)
    datafinal<<-result
    output$resultado=DT::renderDataTable(datafinal[,2:7], server = FALSE)
    dbClearResult(res)
    dbDisconnect(conn)
  })
  
  
  ####Indice del directorio usado para el borrado####
  selevalor=eventReactive(input$resultado_rows_selected,{
    datafinal[as.numeric(input$resultado_rows_selected),1]})
  
  
  ####FUNCION PARA CONFIRMACION DE BORRADOS####
  observeEvent(input$bdelete,{
    output$confir=renderUI({
      wellPanel(
        tags$h5("ALERTA!, ESTAS APUNTO DE BORRAR INFORMACION."),
        tags$h5("Estas seguro?"),
        actionButton("afirma",label = "SI"),
        actionButton("niega",label = "NO"))})
  })
  observeEvent(input$afirma,{output$confir=renderUI(tags$p("Maneja la informacion con cuidado"))})
  observeEvent(input$niega,{output$confir=renderUI(tags$p("Maneja la informacion con cuidado"))})
  
  
  ####FUNCION PARA  BORRAR REGISTROS####
  observeEvent(input$afirma,{
    conn=connectMySQL()
    consulta="delete from catalogo where id="
    data=selevalor()
    
    for(i in 1:length(data)){
      consultaquery=paste(consulta,toString(data[i]))
      dbSendQuery(conn,consultaquery)
    }
    consultaquery2="select * from catalogo"
    res = dbSendQuery(conn, consultaquery2)
    result = dbFetch(res,n=-1)
    datafinal<<-result
    output$resultado=DT::renderDataTable(datafinal[,2:7], server = FALSE)
    dbClearResult(res)
    dbDisconnect(conn)
  })
  
  
  ####FUNCION PARA MOSTRAR TODOS LOS REGISTROS####
  observeEvent(input$bmostrar,{
    conn=connectMySQL()
    consultaquery="select * from catalogo"
    res = dbSendQuery(conn, consultaquery)
    result = dbFetch(res,n=-1)
    datafinal<<-result
    output$resultado=DT::renderDataTable(datafinal[,2:7], server=FALSE)
    dbClearResult(res)
    dbDisconnect(conn)
  })
  
  
  ####FUNCION PARA INGRESO MASIVO DE DATOS####
  observeEvent(input$bingrem,{
    output$confir=renderUI({
      wellPanel(
        tags$h5("ALERTA!, ESTAS APUNTO DE REALIZAR UNA CARGA MASIVA."),
        tags$h5("Estas seguro?"),
        actionButton("afirmaM",label = "SI"),
        actionButton("niega",label = "NO"))})
  })
  observeEvent(input$bmasiva,{
    if(toString(input$datax)!=""){
    file=input$datax
    tabledata<<-read_excel(file$datapath,1)
    output$resultado=DT::renderDataTable({
      tabledata
    })
    }else{
      output$confir=renderUI("INGRESA UN ARCHIVO")
    }
  })
  
  
  ####FUNCIONES PARA CONFIRMACION DE INGRESO MASIVO####
  observeEvent(input$afirmaM,{output$confir=renderUI(tags$p("Estos son los ANEXOS duplicados"))})
  observeEvent(input$afirmaM,{
    if (tabledata!=0) {
      conn=connectMySQL()
      duplicados=depurar(tabledata,conn)
      output$resultado=DT::renderDataTable({
        duplicados
      })
      tabledata<<-0
    }
  })
  
})