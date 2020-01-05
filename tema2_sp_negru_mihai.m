%Numar de ordine: 19
P = 40; %Perioada semnalului
f=1/P;
t=-3*P:0.2:3*P;
D=19;   %durata semnalului
duty = 25;      %factorul de umplere duty=D/40*100
N = 50;       %numarul de coeficienti
w0 = 2*pi/P; 
x_dr = square(w0*t,duty);        %semnalul dreptunghiular
f=@(t)square(w0*t,duty);
CC=1/P*integral(f,0,P);
Ck=zeros(1,N);
Ak=zeros(1,N);
x_modificat=0;
for (k=1:1:N)
   f=@(t)square(w0*t,duty).*exp(-w0*t*1j*(k-25));
   Ck(k)=1/P*integral(f,0,P);             %coeficientii SFC
   Ak(k+1)=2*abs(Ck(k));
   x_modificat=x_modificat+Ck(k).*exp(w0*t*1j*(k-25));
end
figure(1);
plot(t,x_modificat,t,x_dr);
figure(2)
Ak(26)=abs(CC);
Ak(1)=Ak(51);                    %Amplitudinea Ak
stem([0:N],Ak);                     %se afiseaza spectrul de valori
%semnal periodic poate fi aproximat printr-o suma infinita de sinusuri si
%cosinusuri de diferite frecvente