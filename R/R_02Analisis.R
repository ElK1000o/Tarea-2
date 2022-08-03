#Cargar paquetes y llamar datos procesados--------------------------------------

pacman::p_load(haven, tidyverse, sjmisc, sjPlot, kableExtra)

#paquete tinytex para pasar el .Rmd a pdf

JJA_proc = readRDS("output/data/datos_proc.rds")

#Analisis Univariado 3.1 -------------------------------------------------------

#Tabla de Frecuencias sexo/edad en tramos/nivel educacional
JJA_proc %>%
  select(sexo, edad_tr, cine) %>%
  frq(show.na = F,
      out = "viewer",
      encoding = "UTF-8",
      sort.frq = "asc") %>% 
  kable(caption = "Distribución de sexo/edad en tramos/nivel educacional",
        format = "html", 
        col.names = c("Valor", "Etiqueta", "F. absoluta", "F. relativa", 
                      "F. relativa (valida)", "F. rel. acumulada"),
        position = "center") %>% 
  kable_classic(full_width = F, 
                html_font = "Cambria") %>% 
  footnote("Elaboración propia en base a ENE jun-ago (2021)", 
           general_title = "Fuente: ")

#Histograma Edad
ggplot(JJA_proc, aes(x=edad)) +
  geom_histogram(breaks=seq(18, 100),
                 col="plum2",
                 fill="orange")+
  labs(title="Histograma Edad", x="Edad", y="Frecuencia", show.summary = TRUE)

#Analisis Univariado 3.2 -------------------------------------------------------

#Tabla de Frecuencias Ocupaciones
JJA_proc %>%
  select(activ, ocup_form, b1, b14_rev4cl_caenes) %>%
  frq(show.na = F,
      out = "viewer",
      encoding = "UTF-8",
      sort.frq = "asc") %>% 
  kable(caption = "Distribución de Ocupaciones",
        format = "html", 
        col.names = c("Valor", "Etiqueta", "F. absoluta", "F. relativa", 
                      "F. relativa (valida)", "F. rel. acumulada"),
        position = "center") %>% 
  kable_classic(full_width = F, 
                html_font = "Cambria") %>% 
  footnote("Elaboración propia en base a ENE jun-ago (2021)", 
           general_title = "Fuente: ")

#Graficos sobre Ocupaciones

plot_frq(JJA_proc, activ,
         geom.colors = "red",
         title = "Distribucion Condicion Actividad",
         type = "bar")

save_plot("output/fig/Condicion-Actividad.png", fig = last_plot())

plot_frq(JJA_proc, ocup_form,
         geom.colors = "green",
         title = "Distribucion Informalidad",
         type = "bar")

save_plot("output/fig/Distribucion-Informalidad.png", fig = last_plot())

plot_frq(JJA_proc, b1,
         geom.colors = "black",
         title = "Distribucion Grupo Ocupacional (CIUO)",
         type = "bar")

plot_frq(JJA_proc, b14_rev4cl_caenes,
         geom.colors = "lightblue",
         title = "Distribucion Rama de Actividad (CIIU)",
         type = "bar")

#Analisis Univariado 3.3 -------------------------------------------------------

#Graficos Variables Covid

plot_frq(JJA_proc, e22,
         geom.colors = "blue",
         title = "Distribucion Desocupacion",
         type = "bar")

plot_frq(JJA_proc, e22_covid,
         geom.colors = "blue",
         title = "Distribucion Desocupacion covid/no covid",
         type = "bar")

plot_frq(JJA_proc, e12_otro_covid,
         geom.colors = "purple",
         title = "Distribucion Inactividad",
         type = "bar")

plot_frq(JJA_proc, e23,
         geom.colors = "black",
         title = "Distribucion Despidos",
         type = "bar")

plot_frq(JJA_proc, e23_covid,
         geom.colors = "blue",
         title = "Distribucion Desocupacion",
         type = "bar")

plot_frq(JJA_proc, c9_otro_covid,
         geom.colors = "yellow",
         title = "Distribucion Subempleo",
         type = "bar")

#Analisis Bivariado ------------------------------------------------------------

#Edad por categoria Informalidad y Tipo de Jornada

sjt.xtab(JJA_proc$edad_tr, JJA_proc$ocup_form,
         show.col.prc=TRUE,
         show.row.prc=TRUE,
         show.summary=FALSE, 
         encoding = "UTF-8", 
         title = "Tabla Edad segun Informalidad")

sjt.xtab(JJA_proc$edad_tr, JJA_proc$c2_1_3,
         show.col.prc=TRUE,
         show.row.prc=TRUE,
         show.summary=FALSE, 
         encoding = "UTF-8", 
         title = "Tabla Edad segun Tipo de Jornada")

#Activ segun sexo
plot_grpfrq(JJA_proc$sexo, JJA_proc$activ,
            type = "bar", title = "SEXO/ACTIV")

################################################################################
#Grupo Ocupacional y Razones de Desocupacion **************

plot_grpfrq(JJA_proc$b1, JJA_proc$e22_covid, #SIN NA
            type = "bar", title = "Grupo ocupacional y Razones de despido") 

table(JJA_proc$b1, JJA_proc$e22_covid) #SIN NA
table(JJA_proc$b1, JJA_proc$e22_covid, exclude=F) #CON NA

table(JJA_proc$b1, JJA_proc$e22) #SIN NA
table(JJA_proc$b1, JJA_proc$e22, exclude=F) #CON NA

#Rama de Actividad y Motivos de Despido ***************

sjt.xtab(JJA_proc$e23, JJA_proc$b14_rev4cl_caenes,
         show.col.prc=TRUE,
         show.row.prc=TRUE,
         show.summary=FALSE, 
         encoding = "UTF-8", 
         title = "Tabla Edad segun Informalidad covid/no covid") #SIN NA

sjt.xtab(JJA_proc$e23, JJA_proc$b14_rev4cl_caenes,
         show.col.prc=TRUE,
         show.row.prc=TRUE,
         show.summary=FALSE,
         show.na = TRUE,   #CON NA
         encoding = "UTF-8", 
         title = "Tabla Edad segun Informalidad covid/no covid")

table(JJA_proc$b14_rev4cl_caenes, JJA_proc$e23_covid) #SIN NA
table(JJA_proc$b14_rev4cl_caenes, JJA_proc$e23_covid, exclude=F) #CON NA

table(JJA_proc$b14_rev4cl_caenes, JJA_proc$e23) #SIN NA
table(JJA_proc$b14_rev4cl_caenes, JJA_proc$e23, exclude=F) #CON NA
################################################################################
###En las tablas y gráficos anteriores las respuestas contenidas en cada variable###
###calzan con los NA de la otra variable --no se visualizan valores--###

#Motivo Despido según Sexo

plot_grpfrq(JJA_proc$e23_covid, JJA_proc$sexo,
            type = "bar", title = "Despido segun sexo covid/no covid")

plot_grpfrq(JJA_proc$e23, JJA_proc$sexo,
            type = "bar", title = "Despido segun sexo")

sjt.xtab(JJA_proc$sexo, JJA_proc$e23_covid,
         show.col.prc=TRUE,
         show.row.prc=TRUE,
         show.summary=FALSE, 
         encoding = "UTF-8", 
         title = "Tabla Edad segun Informalidad covid/no covid")

sjt.xtab(JJA_proc$sexo, JJA_proc$e23,
         show.col.prc=TRUE,
         show.row.prc=TRUE,
         show.summary=FALSE, 
         encoding = "UTF-8", 
         title = "Tabla Edad segun Informalidad")
