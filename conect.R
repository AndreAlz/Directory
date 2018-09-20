connectMySQL<-function(){
  # Seleccionar driver de trabajo
  m = dbDriver("MySQL")
  # Informacion de la DB
  myHost <- "YOUR IPP"
  myUsername = "USER"
  myDbname = "DBNAME"
  myPort = "PORT"
  myPassword = "PASSWORD"
  #Creacion del obj. de conexion
  con = dbConnect(m, user= myUsername, host= myHost, password= myPassword, dbname= myDbname, port= myPort)
  return(con)}
