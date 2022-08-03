---
title: "README"
author: "Eugenio Ortega y Camilo Riquelme"
date: '2022-05-25'
output: html_document
Universidad: "Alberto Hurtado"
Carrera: "Sociología" 
Docente: "Valentina Andrade" 
Ayudantes: "Nicolas Godoy y Dafne Jaime"
---

## Explicaciones generales

Los datos utilizados en esta investigación, corresponden a la Encuesta Nacional de Empleo, para el trimestre de junio, julio y agosto del año 2021. Estos datos fueron recuperados de: *https://www.ine.cl/estadisticas/sociales/mercado-laboral/ocupacion-y-desocupacion*
<Siguiendo el proceso de: Bases de datos>2021>Formato STATA>ENE 2021 07 JJA>

De igual forma, el siguiente link es de descarga directa de los datos
*https://www.ine.cl/docs/default-source/ocupacion-y-desocupacion/bbdd/2021/stata/ene-2021-07-jja.dta?sfvrsn=30b8fbc9_12&download=true*


En el repositorio de datos, ubicado en la carpeta 02-tarea-ghjsf1234, se encuentra el .Rproj (02-tarea.Rproj) que se debe abrir para realizar procesamiento y análisis de los datos. 

Está organizado en 5 carpetas especificas:

Instrucciones Tarea 2: Contiene README.md con instrucciones para la presente tarea.
Carpeta Input: contiene los datos utilizados durante la tarea 1 *(datos_proc(formato .RData) y ene_unida (formato .rds))*, además de JJA-2021 *(datos descargados desde el link anterior, pero pasados a formato .rds)* que corresponde a la Encuesta Nacional de Empleo trimestre junio, julio y agosto del año 2021. 
Carpeta output: contiene los datos procesados.
Carpeta R: conteniendo dos archivos.R, correspondientes al procesamiento de datos *(R_01-proc)*y el análisis de las variables solicitadas*(R_02Analisis)*.
Y por último, la carpeta .github generada automáticamente por la plataforma de GitHub.

Para la correcta ejecución de la tarea, debe abrirse primero el archivo R_01-proc.R ubicado en la carpeta R, Ejecutar el código completo y guardar los datos procesados. Luego, abrir el archivo R_02Analisis.R, ubicado también en la carpeta R. llamar los datos ya procesados de la carpeta output *(output/data/datos_proc.rds)* y ejecutar los códigos para el análisis.

También se puede revisar el .Rmd/.pdf (Tarea02_Análisis) con el respectivo análisis, descripción e interpretación de los datos obtenidos.
