clear all
close all


% Le moteur

kg=1;
T=0.1;
num=[kg];
den=[T 1 0];
G=tf(num,den);

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% PRELIMINAIRES %%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Etude de stabilit�
F = feedback(G,1);
eig(F);%Eigenvalues = valeurs propres
% margin(G) ou rlocus(G)
rlocus(G);%d�passement

% Bode de l'asservissement
bode(F);%r�ponce fr�quentielle


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% ECHANTILLONNAGE %%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Période d'échantillonnage
Te=[1 0.1 0.5 2 3];


b1=exp(-Te(2)/T)
a1=Te(2)+T*(b1-1)
a2=(T-b1*(Te(2)+T))/a1

sysdB0G = c2d(G,Te(2))



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% ECHANTILLONNAGE CORRECTEUR CONTINU %%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = 2.68
Ti = 1.39

Cp = tf([K*Ti K],[Ti 0])
C1 = c2d(Cp, Te(2), 'tustin');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% RETOUR D'ETAT DISCRET %%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%D�passement de 25% soit :
d = sqrt(log(0.25)^2/(pi^2+log(0.25)^2))

