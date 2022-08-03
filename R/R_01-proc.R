#TAREA 2 -----------------------------------------------------------------------

#Camilo Riquelme y Eugenio Ortega

#cargar y llamar paquetes

pacman::p_load(haven, tidyverse, sjmisc)

#Llamar datos: ENE jun-jul-ago 2021
data = readRDS("input/data/JJA-2021.rds")

#Exploracion Inicial de Variables

table(data$cine)
frq(data$cine)
table(data$sexo)
frq(data$sexo)
class(data$cine)
class(data$edad)
table(data$e23)
frq(data$e23)
table(data$e22)
frq(data$e23)
table(data$b14_rev4cl_caenes)
frq(data$b14_rev4cl_caenes)
frq(data$c9_otro_covid)
frq(data$e12_otro_covid)

#Filtrar, codificar y modificar los datos --------------------------------------

#Codificación de sexo, selección variables tarea 1 + tarea 2, filtros tarea 1+2, clasificación de
#nivel educacional, asignación de etiquetas y NA correspondientes, Indice de horas, 
#creacion variable cae_corregido, edad_tr (edad por tramos) y e22_covid (variable covid/no covid) 
#--junio-agosto ENE (2021)--

data$sexo = factor(data$sexo, levels = c(1:2), labels = c("Hombre", "Mujer"))
JJA_proc = data%>%
  mutate(cine = case_when(cine>=1 & cine<=3~"Basica o menos incompleta",
                          cine>=4 & cine<=5~"Media y basica completa",
                          cine>=6 & cine<=9~"Superior completa", 
                          TRUE ~NA_character_),
         e7 = case_when(e7==1 ~"Jornada Completa", e7==2 ~"Jornada Parcial", 
                        TRUE ~NA_character_),
         e12_otro_covid = case_when(e12_otro_covid==1 ~"No disponible por motivo de COVID", 
                                    e12_otro_covid==0 ~"No disponible por motivo distinto de COVID", 
                                    TRUE ~NA_character_),)%>%
  select(ano_trimestre, id_identificacion, sexo, edad, region, cine, cae_general, 
         cae_especifico, activ, c2_1_1, c2_1_3, b1, b14_rev4cl_caenes, b15_1, 
         c9_otro_covid, e7, e12, e12_otro_covid, e22, e23, ocup_form)%>%
  rowwise() %>% 
  mutate(indice_c2 = sum(c2_1_1, c2_1_3, na.rm = T)) %>% 
  ungroup()%>%
  mutate_at(vars(b14_rev4cl_caenes), ~(car::recode(., recodes = c("c(21, 999) = NA"))))%>%
  mutate_at(vars(e22), ~(car::recode(., recodes = c("c(88, 99) = NA"))))%>%
  mutate_at(vars(e23), ~(car::recode(., recodes = c("c(88, 99) = NA"))))%>%
  mutate_at(vars(c2_1_1), ~(car::recode(., recodes = c("c(888, 8888, 999, 9999) = NA"))))%>%
  mutate_at(vars(indice_c2), ~(car::recode(., recodes = c("c(888, 999) = NA"))))%>%
  mutate(edad_tr = case_when(edad>=18 & edad<=39~"18 a 39 años",
                             edad>=40 & edad<=59~"40 a 59 años",
                             edad>=60~"60+", 
                             TRUE ~NA_character_),
         c2_1_3 = case_when(c2_1_3<=30 ~"Jornada Parcial", c2_1_3>=31 & 
                            c2_1_3<=45 ~"Jornada Completa", 
                            TRUE ~NA_character_),
         e22_covid = case_when(e22>=1 & e22<=7 ~"No tiene empleo por motivo distinto de COVID", 
                               e22>=8 & e22<=9 ~"No tiene empleo por motivo de COVID", 
                               TRUE ~NA_character_),
         e23_covid = case_when(e23>=1 & e23<=9 ~"Despedido sin relación COVID",
                               e23== 10~"Despedido por COVID", 
                               TRUE ~NA_character_),
         cae_corregido = ifelse(cae_especifico %in% c(1), "Ocupado",
                                ifelse(cae_especifico %in% c(2), "Desocupado", 
                                ifelse(activ %in% c(3), "Fuera de la fuerza de trabajo", 
                                NA_character_))))%>%
  filter(edad>=18)%>%mutate_if(is.labelled, ~(forcats::as_factor(.)))

#Asignar NA

JJA_proc$b1 = na_if(JJA_proc$b1, "Sin clasificación")

#revision de variables nuevas y codificadas ------------------------------------

frq(JJA_proc$cine)
frq(JJA_proc$b14_rev4cl_caenes)
frq(JJA_proc$c2_1_1)
frq(JJA_proc$c2_1_3)
frq(JJA_proc$edad_tr)
frq(JJA_proc$indice_c2)
frq(JJA_proc$e7)
frq(JJA_proc$e12_otro_covid)
frq(JJA_proc$e23)
frq(JJA_proc$e22)
frq(JJA_proc$cae_corregido)
frq(JJA_proc$sexo)
frq(JJA_proc$b1)

#Variables colapsadas

frq(JJA_proc$e22_covid)
frq(JJA_proc$e23_covid)

#Guardar datos procesados ------------------------------------------------------

saveRDS(JJA_proc, file = "output/data/datos_proc.rds")
