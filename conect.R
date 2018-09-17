connectMySQL<-function(){
  # Seleccionar driver de trabajo
  m = dbDriver("MySQL")
  # Informacion de la DB
  myHost <- "10.10.100.192"
  myUsername = "root"
  myDbname = "db_emple_general"
  myPort = 3306
  myPassword = "Sysserver02"
  #Creacion del obj. de conexion
  con = dbConnect(m, user= myUsername, host= myHost, password= myPassword, dbname= myDbname, port= myPort)
  return(con)}