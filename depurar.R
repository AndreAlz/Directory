depurar<-function(fileb,conne){
  duplicados=matrix(nrow = 0, ncol = 6)
  conn=conne
  consultaquery="select anexo from catalogo"
  filei=t(as.numeric(unlist(fileb[,3])));
  i=1
  flag=0
  for (i in i:length(filei)) {
    resu = dbSendQuery(conn, consultaquery)
    sqlb = dbFetch(resu,n=-1)
    j=1
    for (j in j:length(sqlb[,1])) {
      if(toString(filei[1,i])==toString(sqlb[j,1])){
        duplicados=rbind(duplicados,fileb[i,])
        flag=1
        break
      }}
      if(flag==0){
        consulta1="insert into catalogo(nombre, campa, anexo, cel, sede,cargo) value ('"
        consulta2="', '"
        consulta3="')"
        query=paste(consulta1,
                            fileb[i,1],consulta2,fileb[i,2],
                            consulta2,fileb[i,3],consulta2,fileb[i,4],
                            consulta2,fileb[i,5],consulta2,fileb[i,6],
                            consulta3,sep = "")
        res=dbSendQuery(conn,query)
        dbClearResult(res)
      }else{
        flag=0
      }
    dbClearResult(resu)
  }
  return(duplicados)
}