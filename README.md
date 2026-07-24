## PROYECTO TERMINAL 1.5: Control de Péndulo Invertido en QUBE-Servo 2
Este repositorio contiene la documentación, los scripts de simulación y los modelos de control desarrollados para el Proyecto Terminal 1 / Tesis 1. El propósito principal de este proyecto consiste en investigar, instalar y configurar el entorno de software requerido para el equipo QUBE-Servo 2 de Quanser, modelar matemáticamente el sistema de péndulo rotatorio, analizar el desempeño de controladores modernos (como el aprendizaje por refuerzo y control clásico) y validar su funcionamiento tanto en simulación como en hardware físico o virtual.

<img width="1543" height="2000" alt="image" src="https://github.com/user-attachments/assets/75a184ff-c86f-48b5-acd2-c0c10607a455" />


# Propósito del Proyecto
El objetivo central es lograr que, mediante cálculos matemáticos y algoritmos de control, el brazo del motor de corriente continua (DC Motor) aplique un voltaje preciso para balancear una varilla de péndulo acoplada en su extremo, de tal forma que esta se eleve (swing-up) y se mantenga en posición vertical (inverted pendulum balance control).

Para cumplir con este propósito, el desarrollo del proyecto se divide en las siguientes etapas clave:

Investigación Teórica y del Modelo: Estudiar las características físicas del motor y del péndulo para comprender el comportamiento dinámico del sistema.
Instalación y Configuración: Instalar los paquetes de software necesarios de MATLAB/Simulink y herramientas de Quanser en la computadora de trabajo.
Análisis de Simulación: Estudiar y simular el modelo no lineal a través del diagrama s_qube2_bal_rl.slx provisto por Quanser.
Validación Experimental: Probar el control del balanceo utilizando el gemelo virtual de Quanser Interactive Labs (QLabs) y, finalmente, el equipo físico real QUBE-Servo 2.
Aplicaciones Tecnológicas: Identificar y proponer casos de uso futuros de esta tecnología en industrias de vanguardia.

# Características Físicas y Parámetros del Motor
El sistema QUBE-Servo 2 es una plataforma de control rotatoria de arquitectura abierta que consta de un motor de CC con escobillas de accionamiento directo (direct-drive) y dos encoders de alta resolución para medir la posición del brazo y del péndulo.

De acuerdo con el archivo de configuración física del equipo (qube2_rotpen_param.m), los parámetros del motor, el brazo y el péndulo son los siguientes:

1. Parámetros del Motor de Corriente Continua (DC Motor)
Resistencia de la armadura ($R_m$): $8.4\ \Omega$
Constante de fuerza electromotriz ($k_m$): $0.042\ ext{V}\cdot ext{s}/ ext{rad}$
Constante de torque del motor ($k_t$): $0.042\ ext{N}\cdot ext{m}/ ext{A}$
2. Parámetros del Brazo Rotatorio (Rotary Arm - $ heta$)
Masa del brazo horizontal ($M_r$): $0.095\ ext{kg}$ (95 gramos)
Longitud total del brazo ($L_r$): $0.085\ ext{m}$ (8.5 cm)
Momento de inercia del brazo ($J_r$): $5.7 imes 10^{-5}\ ext{kg}\cdot ext{m}^2$
Coeficiente de fricción viscosa ($b_r$): $1.5 imes 10^{-3}\ ext{N}\cdot ext{m}\cdot ext{s}/ ext{rad}$
3. Parámetros del Péndulo Invertido (Inverted Pendulum - $lpha$)
Masa de la varilla del péndulo ($M_p$): $0.024\ ext{kg}$ (24 gramos)
Longitud total de la varilla ($L_p$ o $L$): $0.129\ ext{m}$ (12.9 cm)
Distancia al centro de masa ($l$): $0.0645\ ext{m}$ ($L_p/2$, mitad de la varilla)
Momento de inercia respecto al centro de masa ($J_p$): $3.3 imes 10^{-5}\ ext{kg}\cdot ext{m}^2$
Coeficiente de fricción viscosa ($b_p$): $5.0 imes 10^{-4}\ ext{N}\cdot ext{m}\cdot ext{s}/ ext{rad}$
Adicionalmente, se utiliza la constante de aceleración de la gravedad estándar $g = 9.81\ ext{m}/ ext{s}^2$

# Análisis del Diagrama de MATLAB/Simulink s_qube2_bal_rl
El modelo de simulación principal provisto para el aprendizaje por refuerzo (Reinforcement Learning) es s_qube2_bal_rl.slx. Este diagrama se basa en la interacción entre un Agente de RL y un Entorno de Simulación que representa dinámicamente las ecuaciones no lineales de movimiento del péndulo rotatorio.

1. Funcionamiento del Entorno y la Acción de Control
El agente de RL toma decisiones basadas en el estado del sistema y aplica una acción de control directa:

Acción de control (Voltaje de entrada $V_m$): Voltaje aplicado al motor de CC, limitado en un rango continuo de $[-5 ext{ V}, 5 ext{ V}]$ para prevenir daños en el hardware y modelar de forma realista los límites físicos.
Espacio de Estados / Observaciones: Consiste en un vector de 4 elementos ($4 imes 1$) que describe el estado instantáneo del péndulo [35]: $$\mathbf{x} = egin{bmatrix} heta \ lpha \ \dot{ heta} \ \dot{lpha} \end{bmatrix}$$ Donde:
$ heta$: Ángulo de la posición del brazo rotatorio.
$lpha$: Ángulo de la posición del péndulo (donde $lpha_{bal_threshold} = 10^\circ pprox 0.1745\ ext{rad}$ define la región donde se activa el control de balanceo).
$\dot{ heta}$: Velocidad angular del brazo rotatorio.
$\dot{lpha}$: Velocidad angular del péndulo.
2. Función de Recompensa (Reward)
El agente es entrenado bajo una formulación de recompensa cuadrática diseñada para penalizar las desviaciones de la vertical y los esfuerzos excesivos de voltaje:

Pesos de penalización asignados:
$q_{11} = 10$: Penalización por desviación angular del brazo rotatorio ($ heta$).
$q_{22} = 20$: Penalización por desviación angular del péndulo respecto a la vertical ($lpha$).
$q_{33} = 0$: Penalización de la velocidad del brazo (en este caso es cero, permitiendo al brazo moverse ágilmente para balancear el péndulo).
$q_{44} = 1$: Penalización de la velocidad angular del péndulo ($\dot{lpha}$).
$r = 0.1$: Penalización por el uso de energía o voltaje de control ($V_m$).
$B = -100$: Penalización de frontera aplicada si el sistema sale de los rangos seguros, como cuando el brazo excede el ángulo máximo permitido ($ heta_{max} = 60^\circ$).
Este esquema asegura que el agente aprenda a estabilizar el péndulo consumiendo la menor cantidad de energía eléctrica y sin rebasar los límites del hardware.

# Aplicaciones Futuras de esta Tecnología
El péndulo invertido es el problema clásico de control de mayor relevancia académica e industrial, debido a que es un sistema inherentemente inestable y no lineal. Dominar esta tecnología permite extrapolar los conocimientos hacia aplicaciones de vanguardia como:

Sistemas Aeroespaciales: Control de actitud y estabilidad durante el despegue de cohetes y vectores espaciales (que funcionan esencialmente como un péndulo invertido empujado desde su base por los propulsores).
Drones y Vehículos Autónomos: Estabilización de cuadricópteros y drones de entrega ante perturbaciones del viento, así como el control de balanceo de vehículos de transporte personal de dos ruedas (como Segways).
Robótica Humanoide: Algoritmos de locomoción y control de balance de robots bípedos que imitan la marcha humana (donde el centro de masa del torso actúa como un péndulo invertido respecto a los pies de apoyo).
Grúas de Alta Velocidad y Carga: Control de oscilación en grúas portuarias o de construcción para transportar cargas suspendidas masivas de forma rápida y segura sin generar péndulos peligrosos.
Control Inteligente con IA: Integración de Inteligencia Artificial en sistemas físicos dinámicos reales mediante Aprendizaje por Refuerzo (Reinforcement Learning), logrando que la maquinaria industrial se auto-ajuste adaptándose al desgaste de componentes en tiempo real.



