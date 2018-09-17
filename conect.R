connectMySQL<-function(){
  # Seleccionar driver de trabajo
  m = dbDriver("MySQL")
  # Informacion de la DB
  myHost <- "IP"
  myUsername = "USER"
  myDbname = "DB NAME"
  myPort = "PORT"
  myPassword = "PASSWORD"
  #Creacion del obj. de conexion
  con = dbConnect(m, user= myUsername, host= myHost, password= myPassword, dbname= myDbname, port= myPort)
  return(con)}
