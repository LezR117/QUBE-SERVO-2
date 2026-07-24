## Proyecto Terminal 1: Control del Péndulo Invertido con QUBE-Servo 2
Este repositorio contiene la documentación y los archivos correspondientes al Proyecto Terminal 1 (o Tesis 1) enfocado en la instalación, configuración, prueba y control del sistema electromecánico Quanser QUBE-Servo 2.

# ¿Qué es el QUBE-Servo 2?
El QUBE-Servo 2 de Quanser es un sistema servo rotatorio compacto e integrado diseñado para la enseñanza e investigación en sistemas de control y mecatrónica. Es un sistema de arquitectura abierta que permite a los usuarios diseñar y probar sus propios controladores.

Características Clave del Sistema:
Motor de CC con escobillas de accionamiento directo (direct-drive brushed DC motor).
Dos encoders ópticos de alta resolución para medir la posición del brazo rotatorio (el ángulo del motor de CC) y del péndulo.
Amplificador de voltaje integrado con sensores de corriente y tacómetro integrados.
Dispositivo de adquisición de datos (DAQ) integrado.
Tecnología de interfaz de computación QFLEX 2, que ofrece flexibilidad para conectar el sistema a través de USB o interfaces SPI/QBus usando una PC o microcontroladores (como Arduino, Raspberry Pi o NI myRIO).
LED tricolor controlable por el usuario para retroalimentación visual del estado del sistema.
Conexiones rápidas sin herramientas para cambiar fácilmente entre sus módulos.
Módulos Disponibles:
Módulo de Disco de Inercia (Inertia Disk Module): Utilizado para estudiar conceptos básicos como modelado de respuesta al escalón, fricción, análisis de estabilidad, control PD, compensadores de adelanto, etc.
Módulo de Péndulo (Pendulum Module): Utilizado para el clásico experimento del péndulo invertido, permitiendo el estudio de modelado en espacio de estados, control de balance, control de levantamiento (swing-up), y controladores LQR o por asignación de polos.

# Especificaciones del Motor y Componentes
De acuerdo con la documentación oficial del fabricante:

Tipo de Motor: Motor de corriente continua (CC) con escobillas, acoplado directamente (direct-drive) para evitar las holguras de los engranajes.
Sensores de Medición: El sistema incorpora sensores integrados de corriente y tacómetro, además del codificador (encoder) óptico de alta resolución para medir el ángulo de rotación.
Amplificación: Cuenta con un amplificador de potencia analógico de voltaje incorporado en la base que alimenta directamente al motor de CC.
Nota: Los valores numéricos específicos (como torque nominal, corriente máxima o constantes de fuerza del motor) deben consultarse directamente en la Hoja de Datos provista en la sección de Enlaces Útiles, ya que dependen de la revisión exacta del hardware.

# Requerimientos de Software e Instalación
Para interactuar con el hardware real o con el gemelo virtual del QUBE-Servo 2, es necesario contar con la siguiente infraestructura de software (compatible con sistemas de 64 bits en Windows):

Software Base:
MATLAB & Simulink: Compatible con las versiones R2021a o posteriores.
Compilador C/C++: Se requiere un compilador compatible para la generación de código en tiempo real (por ejemplo, MinGW-w64 C/C++ para MATLAB).
Para Pruebas con el Hardware Real:
Quanser QUARC Real-Time Control Software: Este software de tiempo real es indispensable para que Simulink pueda comunicarse directamente con el hardware del QUBE-Servo 2 [11]. Genera un ejecutable para Windows de 64 bits a partir de los diagramas de bloques de Simulink.
MATLAB Coder & Simulink Coder: Requeridos por QUARC para la traducción de bloques de Simulink a código C/C++ ejecutable en tiempo real.
Deep Learning Toolbox & Reinforcement Learning Toolbox (MathWorks): (Opcional) Necesarios en caso de implementar algoritmos avanzados basados en políticas neuronales o aprendizaje por refuerzo en el hardware real.
Para Pruebas Virtuales (Sin Hardware):
Quanser Interactive Labs (QLabs): Software que proporciona un entorno virtual interactivo ("Virtual Twin") del QUBE-Servo 2 para realizar simulaciones realistas antes de pasar al hardware.

# Guía de Inicio Rápido (Pruebas del Sistema)
A. Prueba en Entorno Virtual (Simulink + QLabs)
Inicie la aplicación Quanser Interactive Labs (QLabs) y cargue el espacio de trabajo Pendulum Workspace dentro de la sección QUBE 2 - Pendulum.
Abra el script o modelo virtual correspondiente en Simulink (por ejemplo, qlabs_qube2_bal_rl.slx).
Ejecute el modelo de Simulink para iniciar la simulación en tiempo real con el gemelo virtual.
En la interfaz de QLabs, haga clic en el botón "Lift pendulum" para levantar virtualmente el péndulo y enganchar el lazo de control una vez que se encuentre a ±10 grados de la vertical.
B. Prueba en Hardware Real
Asegúrese de que el hardware del QUBE-Servo 2 esté conectado a un puerto USB de la computadora.
Conecte el cable de alimentación del QUBE-Servo 2 y verifique que el LED indicador de encendido esté iluminado.
Abra el modelo de Simulink diseñado para comunicarse con el hardware de Quanser (por ejemplo, q_qube2_bal_rl_hw.slx).
En la barra de herramientas de Simulink, localice y presione el botón "Monitor and Tune" (Monitorear y Sintonizar) para compilar el archivo a través de QUARC y cargarlo en el hardware en modo externo.
Una vez que el LED de control cambie a verde, levante manualmente el péndulo con suavidad hasta la vertical. Suéltelo inmediatamente en cuanto sienta que el controlador se activa (sucede automáticamente al estar a ±10 grados del punto de equilibrio vertical).
Presione el botón "Stop" en Simulink para detener el controlador y apagar el motor de manera segura.

# Enlaces Útiles y Documentación de Referencia
Para expandir la documentación de tu repositorio, puedes utilizar los siguientes recursos de los fabricantes:

Enlaces de Quanser (Hardware y Soporte)
Página de Información Oficial del QUBE-Servo 2
Ficha Técnica del Producto / Hoja de Datos (Info Sheet - PDF)
Mapeo Temático de Libros de Control (Textbook Mapping)
Portal de Soporte de Quanser (QLabs e Instalación)
Blog Oficial de Quanser - Control de Péndulos con Aprendizaje por Refuerzo
Enlaces de MathWorks (Simulación y Control)
MATLAB Central File Exchange - QUBE-Servo 2 Pendulum RL
E-Book sobre Aprendizaje por Refuerzo con MATLAB
Videos de "Tech Talks" sobre Aprendizaje por Refuerzo
Página Oficial del Reinforcement Learning Toolbox

# Configuración de Matlab:
<img width="546" height="316" alt="image" src="https://github.com/user-attachments/assets/c3ac7501-beaa-4d3e-85d3-9b5b7231dc57" />

