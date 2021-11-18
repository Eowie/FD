Programa Plano de Voo - 57541 - Silvia Mourao - Mestrado Engenharia Geoespacial

O programa para plano de voo utiliza os seguintes módulos no python:
tkinter
mathplotlib
math
utm
simplekml
shapely

Os três primeiros módulos são normalmente incluídos com o python, os outros
três podem ser instalados seguindo as instruções nas paginas seguintes:
https://pypi.org/project/Shapely/
https://pypi.org/project/utm/
https://pypi.org/project/simplekml/


Existem algumas restrições ao funcionamento do programa:
Camara Leica ADS
	A sobreposição longitudinal será sempre =0. (Esta restrição esta incluída no programa)
	Esta camara não funciona para ortofotos
	A definição de margem de segurança especifica da camara Leica no GUI
	diz respeito à distância antes e depois do inicio da área a fotografar
	para inicio de tomada de foto e conclusão da tomada de foto
	(exemplo no plot em anexo)
Geral
	O programa não funciona para poligonos com grande diferença entre
	comprimentos de lados opostos (lado1≈lado3, lado2≈lado4)
	(nesses casos faz uma aproximacao a um rectangulo)