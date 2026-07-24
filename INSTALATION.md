PROYECTO TERMINAL 1.5 Guía de Instalación, Estructura del Repositorio y Pruebas
Esta guía detalla los pasos para configurar el software necesario, comprender la organización de las carpetas en tu repositorio de GitHub y realizar las primeras pruebas del controlador del QUBE-Servo 2 tanto en simulación interactiva como en el equipo físico.

# Requisitos de Software y Herramientas
Para poder simular, interactuar y controlar el QUBE-Servo 2, es imperativo contar con MATLAB y un conjunto de toolboxes y programas específicos de Quanser:

MATLAB & Simulink: Versión compatible R2021a o superior.
Toolboxes de MathWorks:
Reinforcement Learning Toolbox: Necesario para diseñar, entrenar y cargar los agentes de aprendizaje por refuerzo.
Deep Learning Toolbox: Obligatorio si deseas desplegar políticas entrenadas en el hardware real, ya que el bloque de agente de RL utiliza funciones de predicción neuronal optimizadas.
Compiladores de C/C++: Como MinGW-w64 C/C++ para realizar la generación de código y compilar los ejecutables de tiempo real en Simulink.
Software Quanser:
Quanser Interactive Labs (QLabs): Software que aloja el gemelo virtual e interactivo del QUBE-Servo 2, ideal para pruebas seguras previas al hardware físico.
QUARC Real-Time Control Software: Software de Quanser que permite compilar los diagramas de Simulink en ejecutables de Windows de 64 bits para control de hardware en tiempo real (External Mode).

# Estructura Recomendada del Repositorio de GitHub
Para mantener un orden riguroso durante el desarrollo del Proyecto Terminal, se sugiere estructurar el repositorio en GitHub con las siguientes carpetas:

├── README.md                   <-- Documentación principal y descripción general
├── INSTALL.md                  <-- Esta guía de instalación y pruebas de software
├── /docs                       <-- Manuales, hojas de datos PDF y reportes escritos
├── /models                     <-- Archivos de redes neuronales y agentes entrenados (.mat)
│   └── QubeIPBalDDPG09.mat     <-- Agente DDPG pre-entrenado para balanceo
└── /src                        <-- Scripts de MATLAB y diagramas de Simulink
    ├── qube2_rotpen_param.m    <-- Script con los parámetros físicos oficiales del equipo
    ├── valores.m               <-- Script de inicialización y simulación automatizada
    ├── s_qube2_bal_rl.slx      <-- Modelo de Simulink para simulación no lineal pura
    ├── qlabs_qube2_bal_rl.slx  <-- Modelo de Simulink para interfaz con el gemelo virtual QLabs
    └── q_qube2_bal_rl_hw.slx   <-- Modelo de Simulink para control del hardware físico mediante QUARC

# Descarga de Archivos Base
Puedes iniciar descargando los recursos desarrollados por Quanser directamente de la comunidad oficial de MathWorks:

Enlace de Descarga: Quanser QUBE-Servo 2 Pendulum Control Reinforcement Learning en MATLAB File Exchange.
Alternativamente, puedes clonar este repositorio una vez que agregues estos archivos a tu carpeta /src y /models.

# Guía de Pruebas Paso a Paso
Prueba 1: Simulación No Lineal Pura (Ideal para revisar los cálculos matemáticos)
Esta prueba corre 100% dentro de MATLAB sin requerir hardware ni gemelos virtuales adicionales.

Abre MATLAB y dirígete a la carpeta /src en tu explorador.
Ejecuta el script de configuración física para cargar las variables del motor y del péndulo a tu Workspace ejecutando.
run('qube2_rotpen_param.m')
Carga el agente de Reinforcement Learning pre-entrenado que se encuentra en la carpeta /models.
load('QubeIPBalDDPG09.mat', 'agent')
Abre y ejecuta el modelo de simulación:
open('s_qube2_bal_rl.slx')
Prueba de Estabilidad: Modifica el ángulo inicial en el bloque IC0 a, por ejemplo, $0.96 imes ic_alpha0$ (unos $172.8^\circ$, es decir, a $7.2^\circ$ de la vertical) y dale a correr. Observarás cómo el agente aplica voltajes precisos para corregir la posición y balancear el péndulo de forma estable.

Prueba 2: Conexión con el Gemelo Virtual (QLabs).
Permite validar visualmente cómo se comporta el motor en un render 3D de alta fidelidad antes de usar el equipo de laboratorio.

Abre el software Quanser Interactive Labs (QLabs) en tu computadora.
Inicia sesión y carga el espacio de trabajo Pendulum Workspace desde el menú QUBE 2 - Pendulum.
En MATLAB, ejecuta el comando para abrir el archivo preparado para el gemelo virtual.
open('qlabs_qube2_bal_rl.slx')
Presiona el botón de Run en Simulink.
En la ventana 3D de QLabs, haz clic en el botón "Lift pendulum" en la esquina superior derecha para elevar la varilla. El controlador de balanceo se activará automáticamente cuando la varilla esté a menos de $\pm 10^\circ$ de la posición vertical.

Prueba 3: Implementación en Hardware Físico Real
Sigue estas instrucciones estrictamente en el laboratorio una vez verifiques las pruebas en software.

Coloca el equipo QUBE-Servo 2 en una mesa nivelada y despejada.
Conecta el cable USB del QUBE-Servo 2 a la computadora de trabajo y enchufa el eliminador de corriente. Asegúrate de que el LED de encendido del equipo se ilumine.
En MATLAB, abre el modelo de conexión física.
open('q_qube2_bal_rl_hw.slx')
En la pestaña de herramientas de Simulink, localiza y haz clic en el botón "Monitor and Tune" (Monitorizar y Sintonizar) para compilar el software con QUARC y cargarlo al procesador del equipo.
Una vez que la compilación termine y el LED del QUBE-Servo 2 se torne verde, levanta de manera manual y cuidadosa la varilla del péndulo hasta la vertical.
Liberación: En cuanto sientas que el motor del brazo rotatorio se activa para sostener la varilla (al estar a $\pm 10^\circ$ de la vertical), suéltala de inmediato.
Para detener la prueba, simplemente presiona el botón Stop en Simulink.




# Matlab caracteristicas del motor Qube-Servo2:
<img width="431" height="401" alt="image" src="https://github.com/user-attachments/assets/c4705681-671c-441f-bb2c-512f22ccdcad" />

<img width="546" height="316" alt="image" src="https://github.com/user-attachments/assets/c3ac7501-beaa-4d3e-85d3-9b5b7231dc57" />

# Matlab pruebas del funcionamiento del motor:
<img width="446" height="386" alt="image" src="https://github.com/user-attachments/assets/1a85a3a2-4f44-4c73-a3b1-89eb4143ce09" />



