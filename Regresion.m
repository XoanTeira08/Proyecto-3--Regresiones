%Regresiones
fprintf('Regresion lineal, polinomica y exponencial \n')
fprintf(' \n');
fprintf('Ejemplo de como ingresar los valores [0;0;0;0;0] / [0 0 0 0 0]\n')
%Ingresar los datos 
x=input("\nIngrese los valores de x dentro de corchetes: ");
y=input("\nIngrese los valores de y dentro de corchetes: ");

%Cantidad de datos
cant=length(x);

%Calculos - Multiplicaciones
for(i=1:length(x))
xy(i)=x(i)*y(i);
xx(i)=x(i)*x(i);
lny(i)=log(y(i));
endfor
for(i=1:length(x))
xxy(i)=xx(i)*y(i);
xxx(i)=xx(i)*x(i);
xlny(i)=x(i)*lny(i);
endfor 
for(i=1:length(x))
xxxx(i)=xxx(i)*x(i);
endfor
%Calculos - Sumas
totX=0, totY=0, totXY=0, totXX=0, totXXY=0, totXXX=0, totXXXX=0,totLNY=0, totXLNY=0;
for(i=1:length(x))
totX=totX+x(i);
totY=totY+y(i);
totXY=totXY+xy(i);
totXX=totXX+xx(i);
totXXY=totXXY+xxy(i);
totXXX=totXXX+xxx(i);
totXXXX=totXXXX+xxxx(i);
totLNY=totLNY+lny(i);
totXLNY=totXLNY+xlny(i);
endfor

%MATRICES
%Matriz lineal
matrizLineal=[cant, totX; totX, totXX];
coeficientesLineal=[totY; totXY];
%Matriz polinomica
matrizPoli=[cant, totX, totXX; totX, totXX, totXXX; totXX, totXXX, totXXXX];
coeficientesPoli=[totY; totXY; totXXY];
%Matriz exponencial
matrizExp=[cant, totX; totX, totXX];
coeficientesExp=[totLNY;totXLNY];

%COEFICIENTES
%Calculo de coeficientes LINEAL 
inversaLineal=matrizLineal^-1;
resultadoLineal=inversaLineal*coeficientesLineal;
%Calculo de coeficientes POLINOMICA 
inversaPoli=matrizPoli^-1;
resultadoPoli=inversaPoli*coeficientesPoli;
%Calculo de coeficientes EXPONENCIAL 
inversaExp=matrizExp^-1;
resultadoExp=inversaExp*coeficientesExp;
resultadoAlfa=exp(resultadoExp(1));

%CALCULO CORRELACION

%(y-ymedia)^2
totYmedia=0;
ymedia=totY/cant;
for(i=1:length(y))
ymediaVec(i)=(y(i)-ymedia)^2;
totYmedia=totYmedia+ymediaVec(i);
endfor
%(lny -lny media)^2
totYmediaLn=0;
lnymedia=totLNY/cant;
for(i=1:length(y))
ymediaVecLn(i)=(lny(i)-lnymedia)^2;
totYmediaLn=totYmediaLn+ymediaVecLn(i);
endfor

%CALCULANDO SR
%Sr=(y-a0-a1x)^2
totSrLineal=0;
for(i=1:length(x))
vecSrLineal(i)=(y(i)-resultadoLineal(1)-resultadoLineal(2)*x(i))^2;
totSrLineal=totSrLineal+vecSrLineal(i);
endfor
%Sr=(y-a0-a1*x-a2*x^2)^2
totSrPoli=0;
for(i=1:length(x))
vecSrPoli(i)=(y(i)-resultadoPoli(1)-resultadoPoli(2)*x(i)-resultadoPoli(3)*xx(i))^2;
totSrPoli=totSrPoli+vecSrPoli(i);
endfor
%Sr=(lny-(lna +bx))^2
totSrExp=0;
for(i=1:length(x))
vecSrExp(i)=(lny(i)-resultadoExp(1)-resultadoExp(2)*x(i))^2;
totSrExp=totSrExp+vecSrExp(i);
endfor

%CALCULO Sy/x=Error
SyxLineal=sqrt(totSrLineal/(cant-(2)));
SyxPoli=sqrt(totSrPoli/(cant-(2+1)));


%Coeficiente de correlacion y determinacion
%Coeficiente Lineal
coeDeterminacionLineal=((totYmedia-totSrLineal)/totYmedia);
coeCorrelacionLineal=sqrt(coeDeterminacionLineal);
%Coeficiente Polinomica
coeDeterminacionPoli=((totYmedia-totSrPoli)/totYmedia);
coeCorrelacionPoli=sqrt(coeDeterminacionPoli);
%Coeficiente Exponencial
coeDeterminacionExp=((totYmediaLn-totSrExp)/totYmediaLn);
coeCorrelacionExp=sqrt(coeDeterminacionExp);
%Impresion de resultados
fprintf(' \n');
fprintf("---------------------------------\n");
fprintf('Ecuacion del modelo de regresion Lineal\n');
fprintf("---------------------------------\n");
fprintf('y=%i+%ix\n', resultadoLineal(1),resultadoLineal(2));
fprintf("---------------------------------\n");
fprintf(' \n');
fprintf("---------------------------------\n");
fprintf('Ecuacion del modelo de regresion Polinomica\n');
fprintf("---------------------------------\n");
fprintf('y=%i+%i*x+%i*x^2\n', resultadoPoli(1),resultadoPoli(2), resultadoPoli(3));
fprintf("---------------------------------\n");
fprintf(' \n');
fprintf("---------------------------------\n");
fprintf('Ecuacion del modelo de regresion Exponencial\n');
fprintf("---------------------------------\n");
fprintf('y=%i*e^%i\n', resultadoAlfa,resultadoExp(2));
fprintf("---------------------------------\n");
fprintf(' \n');
fprintf("---------------------------------------------\n");
fprintf('El coeficiente de determinacion de la Ecuacion Lineal es: %i\n',coeDeterminacionLineal);
fprintf('El coeficiente de correlacion de la Ecuacion Lineal es: %i\n',coeCorrelacionLineal);
fprintf("---------------------------------------------\n");
fprintf('El coeficiente de determinacion de la Ecuacion Polinomica es: %i\n',coeDeterminacionPoli);
fprintf('El coeficiente de correlacion de la Ecuacion Polinomica es: %i\n',coeCorrelacionPoli);
fprintf("---------------------------------------------\n");
fprintf('El coeficiente de determinacion de la Ecuacion Exponencial es: %i\n',coeDeterminacionExp);
fprintf('El coeficiente de correlacion de la Ecuacion Exponencial es: %i\n',coeCorrelacionExp);
fprintf("---------------------------------------------\n");
if(coeDeterminacionLineal>coeCorrelacionPoli && coeDeterminacionLineal>coeCorrelacionPoli)
fprintf(' \n');
fprintf('Dado que se obtuvo un coeficiente de determinacion de %i se puede concluir\nque el metodo de regresion Lineal se adapta de forma excelente a los datos\n', coeDeterminacionLineal);
fprintf(' \n');
elseif(coeCorrelacionPoli>coeCorrelacionLineal && coeCorrelacionPoli>coeCorrelacionExp)
fprintf('Dado que se obtuvo un coeficiente de determinacion de %i se puede concluir\nque el metodo de regresion Polinomica se adapta de forma excelente a los datos\n', coeDeterminacionPoli);
fprintf(' \n');
else
fprintf('Dado que se obtuvo un coeficiente de determinacion de %i se puede concluir\nque el metodo de regresion Exponencial se adapta de forma excelente a los datos\n', coeDeterminacionExp);
fprintf(' \n');
endif
fprintf(' \n');
fprintf("---------------------------------------------\n");
fprintf('El error estandar es de la regresion lineal es: %i\n',SyxLineal);
fprintf("---------------------------------------------\n");
fprintf(' \n');
fprintf("---------------------------------------------\n");
fprintf('El error estandar es de la regresion polinomica es: %i\n',SyxPoli);
fprintf("---------------------------------------------\n");
%Grafica
plot(x,y,'ro-', 'markersize', 4, 'linewidth', 2);grid;

xlabel('X');
ylabel('Y');
title('Y vs X');
