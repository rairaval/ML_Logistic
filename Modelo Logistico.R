# Regresion logistica para predecir #

# La regresiones logisticas sirven para explorar las relaciones entre una variable dependiente binaria (si/no, aprobado/rechazado...)
# y otras variables (regresores) que pueden o no ser binarias, por ejemplo sexo, edad, nivel de ingreso, entre otras. 
# vamos a utilizad el paquete de R visreg para explorar esta relación http://pbreheny.github.io/visreg/index.html
# El conjunto de datos CPS85 del paquete mosaicData contiene datos de 1985 sobre salarios y otras características de los trabajadores.


# marital status: married/single

#install.packages("CPS85")

data(CPS85, package = "mosaicData")

#Exploro las variables: Es de esperarse que no haya que realizar algun tiempo (a priori) de preporcesado ya que se trata de un deta set de CRAN
str(CPS85)

#Estado civil: casado/soltero. Realizo el modelo para predecir la probabilidad de estar casado, dado el sexo, edad, raza y sector de empleo de la persona. 

cps85_glm <- glm(married ~ sex + age + race + sector, 
                 family="binomial", 
                 data=CPS85)

#Impirmo el modelo para obervar los resultados:
cps85_glm

#la edad, la raza y todos los sectores de actividad economica salvo el sector servicios tienen un efecto negrativo en la probabilidad de contraer matrimonio. 

#Usando el modelo ajustado, visualicemos la relación entre la edad y la probabilidad de estar casado, manteniendo constantes las otras variables. 
#Nuevamente, la función visreg toma el modelo y la variable de interés y traza la relación condicional, controlando las otras variables. 
#La opción gg = TRUE se usa para producir un gráfico ggplot2.
#La opción scale = "response" crea una gráfica basada en una escala de probabilidad (en lugar de log-odds).

# Imprimir los resultados
library(ggplot2)
library(visreg)

visreg(cps85_glm, "age", 
       gg = TRUE, 
       scale="response") +
  labs(y = "Prob(Married)", 
       x = "Age",
       title = "Relacion entre la edad y el estado civil",
       subtitle = "controlling for sex, race, and job sector",
       caption = "source: Current Population Survey 1985")

visreg(cps85_glm, "age",
       by = "sex",
       gg = TRUE, 
       scale="response") +
  labs(y = "Prob(Casado)", 
       x = "Edad",
       title = "Relacion entre la edad y el estado civil: separado por sexo",
       subtitle = "Contralando por raza y sector de trabajo",
       caption = "source: Current Population Survey 1985")

#En estos datos, la probabilidad de matrimonio es muy similar para hombres y mujeres.
#Se estima que la probabilidad de contraer matrimonio es aproximadamente de 0,5 a los 20 años y disminuye a 0,1 a los 60 años, controlando las otras variables.
