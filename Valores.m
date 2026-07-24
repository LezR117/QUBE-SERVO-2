% 1. CONFIGURACIÓN DEL TIEMPO
Ts = 0.01;  % "Time Step" o Tamaño de paso. El simulador calculará la física cada 0.01 segundos.
Tf = 10;    % "Time Final". La simulación durará exactamente 10 segundos en total.

% 2. PREPARACIÓN DE LOS ARCHIVOS
cd 'C:\Users\usuario\Desktop\Quarc-Quanser\upload\'

% Carga parametros
qube2_rotpen_param; 

% 3. FÍSICA Y MEDIDAS DE LA MÁQUINA
% Estas variables de medicion y peso de las piezas físicas.
l = 0.129 / 2; % Distancia al centro de masa del péndulo (la mitad de su largo en metros).
L = 0.129;     % Longitud total del péndulo (0.129 metros).
mp = 0.024;    % Masa (peso) del péndulo en kilogramos (24 gramos).
mr = 0.095;    % Masa (peso) del brazo rotatorio en kilogramos (95 gramos).

% 4. POSICIÓN INICIAL
% Define en qué posición arranca el péndulo. 0.5 radianes es un poco inclinado 
ic_alpha0 = 0.5;  

% 5. EJECUCIÓN DEL SIMULADOR
% Imprime en la consola el texto entre comillas para avisarte qué está haciendo.
disp('Ejecutando Simulink...');

% Guarda el nombre de tu archivo de Simulink en una variable llamada "mdl" (modelo) 
% para no tener que escribir el nombre largo completo después.
mdl = 's_qube2_bal_rl';

% Obliga a MATLAB a abrir la ventana visual con el diagrama de bloques.
open_system(mdl);

% Hace que el código se detenga y espere 2 segundos. 
pause(2);

% El comando más importante: "simula". Toma el modelo (mdl) y lo pone a correr.
sim(mdl); 
