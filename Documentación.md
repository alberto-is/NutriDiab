# Decisión de tema
El sistema experto a desarrollar es un basado en el conocimiento, más concretamente un **sistema experto de ayuda a la decisión en \_\_\_\_**. Como todavía somos estudiantes, y tenemos un acceso limitado a expertos, el alance de este sistema no tiene que ser muy amplio. Por lo tanto algo genérico como "Sistema de diagnostico medico" no serviría. Pero algo referente a una enfermedad especifica que sea  borrosa si. Es decir si la enfermedad es le covid-19, al ser una prueba booleana como un test (meterte un palo por la nariz y que este se ponga de un color determinado si es positivo u otro si es negativo) no serviría.
En mi caso personal los expertos que tengo son personas asociadas a trabajos modestos como agricultores, ganaderos y panaderos. Esto no es malo, por ejemplo, podría hacer un sistema experto que te diga que panes o bollería hacer según la fecha, el tiempo, etc. Pero además de estos mi padre es medico por lo tanto algo relacionado con la medicina (enfermedades, problemas alimenticios, etc.) sería bastante útil.

Después de pensarlo decidí hacerlo sobre algo de la alimentación y dietas. Como he indicado antes el alcance tiene que ser limitado, y una dieta puede tener en cuenta muchas variables, y muchos tipos de alimentaciones diferentes. Para reducir el alcance de este proyecto he decidido centrarme en dietas para personas con diabetes tipo 2 y personas prediabéticas.
## NutriDiab: Sistema de experto en Nutrición para la ayuda en la toma de decisiones alimenticias en personas con  Diabetes Tipo 2 y personas prediabeticas
La diabetes tipo 2 es una enfermedad crónica que afecta la manera en que el cuerpo procesa el azúcar en la sangre. Un sistema experto podría emplear lógica borrosa para personalizar recomendaciones dietéticas y de ejercicio basándose en lecturas de glucosa en sangre, peso, y otros factores personales, teniendo en cuenta la variabilidad y la imprecisión de las respuestas individuales a diferentes tratamientos.
### Justificación de la necesidad de lógica borrosa
El uso de la lógica borrosa en el sistema experto "NutriDiab" para la gestión personalizada de dietas en personas con diabetes tipo 2, y prediabéticas, se justifica por varias razones clave, relacionadas con la naturaleza de la diabetes, las necesidades dietéticas individuales y la gestión de la enfermedad. 
##### 1 Manejo de la Incertidumbre y Subjetividad
La lógica borrosa es ideal para manejar la incertidumbre y la subjetividad inherentes en la evaluación de los estados de salud individuales y las respuestas a diferentes dietas. Las personas con diabetes tipo 2 están sujetas a múltiples factores, como niveles de glucosa en sangre, sensibilidad a la insulina, peso corporal, y actividad física, que no siempre son precisos o constantes.  Además de estar sujeto a gustos personajes y alergias, no todas las personas diabéticas tendrán las mismas necesidades, ni los mismos gustos.
La lógica borrosa permite modelar estas variables de manera más natural y flexible que los enfoques binarios tradicionales.
##### 2. Mejora en la Toma de Decisiones
La gestión de la diabetes tipo 2 requiere tomar decisiones complejas sobre la alimentación y el estilo de vida. La lógica borrosa ayuda a simular el razonamiento humano en la toma de estas decisiones, proporcionando recomendaciones que pueden ajustarse a situaciones ambiguas o a información parcial, mejorando así la calidad de las decisiones dietéticas.
##### 4. Flexibilidad en el Manejo de Reglas
El sistema puede incorporar un amplio rango de reglas nutricionales y médicas que reflejen el conocimiento experto en la gestión de la diabetes tipo 2. La lógica borrosa permite que estas reglas se apliquen de manera flexible, reconociendo que la importancia y la aplicación de las recomendaciones pueden variar entre individuos. Además de que permite una adaptación y ampliación del sistema en un futuro.
##### 5. Interpretación Intuitiva
Los resultados generados por un sistema basado en lógica borrosa son fáciles de interpretar para los usuarios finales (pacientes, cuidadores, profesionales de la salud), ya que se presentan en términos de grados de pertenencia o probabilidad, en lugar de respuestas sí/no absolutas. Esto facilita la comunicación de recomendaciones dietéticas complejas de una manera comprensible.

## Alcance, Restricciones y limitaciones
### Alcance
- **Personalización de Dietas:** Proporcionar recomendaciones de dieta personalizadas basadas en los perfiles individuales de los usuarios, incluyendo sus niveles de glucosa, preferencias alimenticias, objetivos de peso y condiciones de salud coexistentes.
  Permitirá encontrar una dieta en base a datos específicos que se pueden obtener bedenita analíticas, como glucosa en sangre, pero también mediante información superficial como el peso actual, las comidas recientes, etc.
- **Base de Datos de Alimentos:** Contar con una base de datos relativamente amplia, el objetivo inicial son 50 alimentos pero tengo la intención de extenderlo a 100 o más. La base de datos incluirá información nutricional para ayudar a los usuarios a tomar decisiones informadas.
- **Interfaz Interactiva:** Proporcionar una interfaz de usuario amigable que facilite la interacción con el sistema y la comprensión de la información.
### Limitaciones
- **Diagnóstico Médico:** La aplicación NO SUSTITUIRÁ la necesidad de consultas médicas regulares ni proporcionará diagnósticos médicos.
- **Emergencias Médicas:** NO está diseñada para manejar emergencias médicas o situaciones de atención médica aguda.
- **Interacciones Medicamentosas:** NO proporcionará información sobre medicamentos. Está aplicación solo sirve como una guía alimentaría, NADA más.
- **Actualizaciones en Tiempo Real:** NO se garantiza que las recomendaciones dietéticas se actualicen en tiempo real con respecto a los avances en la investigación de la diabetes. Por lo que la información almacenada, dietas y alimentos recomendados pueden quedar desfasados.
### Restricciones
Las restricciones se van a basar en tres partes importantes, el conocimiento del experto, el tiempo de desarrollo y los recursos disponibles. 
#### Restricciones técnicas
- **Compatibilidad:** La aplicación, por ahora, estará limitada al ordenador y será compatible con los sistemas operativos Windows y Linux. 
#### Restricciones de Datos
- **Privacidad y Seguridad:** El manejo de la información de salud del usuario debe cumplir con las regulaciones de privacidad y protección de datos.
- **Actualización de la Base de Datos:** La información nutricional y las recomendaciones estarán basados en unos datos limitados que, muy seguramente, no serán actualizados.
#### Restricciones de Recursos
- **Presupuesto:** El financiamiento disponible, casi nulo, limita las características que se pueden desarrollar y la velocidad a la que la aplicación puede ser mejorada o ampliada.
- **Tiempo:** Las restricciones de tiempo, especialmente en un entorno académico, afectarán  la profundidad de desarrollo y el nivel de pruebas que se pueden realizar.
#### Restricciones del Experto
- **Conocimiento del Experto**: Aunque el experto es un médico con más de 25 años de experiencia, no está especializado en el ámbito de la nutrición específica para la diabetes tipo 2. Por lo tanto, el alcance de su aporte se centra en el conocimiento general de la enfermedad y su manejo, sin profundizar en detalles dietéticos avanzados que requerirían la experiencia de un dietista o nutricionista clínico especializado en diabetes.
- **Tiempo disponible del Experto**: El experto dispone de un tiempo limitado para contribuir al desarrollo de la aplicación, lo que puede restringir la cantidad de conocimiento detallado que puede ser transferido al sistema y la frecuencia de actualización de la información basada en las últimas investigaciones o prácticas clínicas
- **Involucramiento en el Desarrollo**: La participación del experto en el proceso de desarrollo está limitada a consultas periódicas y revisiones, en lugar de una colaboración continua y en tiempo real. Esto significa que el flujo de información y conocimiento será en gran parte unidireccional y posiblemente espaciado a lo largo del tiempo, lo que puede influir en la dinámica del desarrollo y la iteración del sistema.
# Evaluación de la aplicación candidata
![[Pasted image 20240304154812.png]]
[[SISTEMAS BASADOS TABLA.pdf]]

|   |   |   |   |   |   |
|---|---|---|---|---|---|
|**categoría**|**identificador**|**Peso (P)**|**Valor (V)**|**DENOMINACIÓN DE LA CARACTERÍSTICA**|**TIPO**|
|**EX**|**P1**|**10**|**8**|Existen expertos.|**E**|
|**EX**|**P2**|**10**|**10**|El experto asignado es genuino.|**E**|
|**EX**|**P3**|**8**|**8**|El experto es cooperativo.|**D**|
|**EX**|**P4**|**7**|**7**|El experto es capaz de articular sus métodos, pero no categoriza.|**D**|
|**TA**|**P5**|**10**|**8**|Existen suficientes casos de prueba; normales, típicos, ejemplares, correosos, etc.|**E**|
|**TA**|**P6**|**10**|**10**|La tarea está bien estructurada y se entiende.|**D**|
|**TA**|**P7**|**10**|**10**|Sólo requiere habilidad cognoscitiva (no pericia física).|**D**|
|**TA**|**P8**|**9**|**9**|No se precisan resultados óptimos sino sólo Satisfactorios, sin comprometer el proyecto.|**D**|
|**TA**|**P9**|**9**|**8**|La tarea no requiere sentido común.|**D**|
|**DU**|**P10**|**7**|**10**|Los directivos están verdaderamente comprometidos con el proyecto.|**D**|
|**EX**|**J1**|**10**|**7**|El experto NO está disponible.|**E**|
|**EX**|**J2**|**10**|**6**|Hay escasez de experiencia humana.|**D**|
|**TA**|**J3**|**8**|**8**|Existe necesidad de experiencia simultánea en muchos lugares.|**D**|
|**TA**|**J4**|**10**|**10**|Necesidad de experiencia en entornos hostiles, penosos y/o poco gratificantes.|**E**|
|**TA**|**J5**|**8**|**7**|No existen soluciones alternativas admisibles.|**E**|
|**DU**|**J6**|**7**|**7**|Se espera una alta tasa de recuperación de la inversión.|**D**|
|**DU**|**J7**|**8**|**8**|Resuelve una tarea útil y necesaria.|**E**|
|**EX**|**A1**|**5**|**6**|La experiencia del experto está poco organizada.|**D**|
|**TA**|**A2**|**6**|**8**|Tiene valor práctico.|**D**|
|**TA**|**A3**|**7**|**7**|Es una tarea más táctica que estratégica.|**D**|
|**TA**|**A4**|**7**|**10**|La tarea da soluciones que sirvan a necesidades a largo plazo.|**E**|
|**TA**|**A5**|**5**|**6**|La tarea no es demasiado fácil, pero es de conocimiento intensivo, tanto propio del dominio, como de manipulación de la información.|**D**|
|**TA**|**A6**|**6**|**8**|Es de tamaño manejable, y/o es posible un enfoque gradual y/o, una descomposición en subtareas independientes.|**D**|
|**EX**|**A7**|**7**|**10**|La transferencia de experiencia entre humanos es factible (experto a aprendiz).|**E**|
|**TA**|**A8**|**6**|**10**|Estaba identificada como un problema en el área y los efectos de la introducción de un SE pueden planificarse.|**D**|
|**TA**|**A9**|**9**|**8**|No requiere respuestas en tiempo real “inmediato”.|**E**|
|**TA**|**A10**|**9**|**8**|La tarea no requiere investigación básica.|**E**|
|**TA**|**A11**|**5**|**4**|El experto usa básicamente razonamiento simbólico que implica factores subjetivos.|**D**|
|**TA**|**A12**|**5**|**6**|Es esencialmente de tipo heurístico.|**D**|
|**EX**|**E1**|**8**|**9**|No se sienten amenazados por el proyecto, son capaces de sentirse intelectualmente unidos al proyecto.|**D**|
|**EX**|**E2**|**6**|**6**|Tienen un brillante historial en la realización de esta tarea.|**D**|
|**EX**|**E3**|**5**|**10**|Hay acuerdos en lo que constituye una buena solución a la tarea.|**D**|
|**EX**|**E4**|**5**|**10**|La única justificación para dar un paso en la solución es la calidad de la solución final.|**D**|
|**EX**|**E5**|**6**|**10**|No hay un plazo de finalización estricto, ni ningún otro proyecto depende de esta tarea.|**D**|
|**TA**|**E6**|**7**|**10**|No está influenciada por vaivenes políticos.|**E**|
|**TA**|**E7**|**8**|**8**|Existen ya SS.EE. que resuelvan esa o parecidas tareas.|**D**|
|**TA**|**E8**|**8**|**8**|Hay cambios mínimos en los procedimientos habituales.|**D**|
|**TA**|**E9**|**5**|**9**|Las soluciones son explicables o interactivas.|**D**|
|**TA**|**E10**|**7**|**8**|La tarea es de I+D de carácter práctico, pero no ambas cosas simultáneamente.|**E**|
|**DU**|**E11**|**6**|**8**|Están mentalizados y tienen expectativas realistas tanto en el alcance como en las limitaciones.|**D**|
|**DU**|**E12**|**7**|**8**|No rechazan de plano esta tecnología.|**E**|
|**DU**|**E13**|**6**|**9**|El sistema interactúa inteligente y amistosamente con el usuario.|**D**|
|**DU**|**E14**|**9**|**9**|El sistema es capaz de explicar al usuario su razonamiento.|**D**|
|**DU**|**E15**|**8**|**9**|La inserción del sistema se efectúa sin traumas; es decir, apenas se interfiere en la rutina cotidiana de la empresa.|**D**|
|**DU**|**E16**|**6**|**8**|Están comprometidos durante toda la duración del proyecto, incluso después de su implantación.|**D**|
|**DU**|**E17**|**8**|**9**|Se efectúa una adecuada transferencia tecnológica.|**E**|
## Calculo de viabilidad en función de la tabla
Para ser viable tiene que ser mayor que un 80%.
[[sistema experto python code]] -> código de Sergio (no comprueba que sea mayor que 7, pero hace el resto de las siguientes formulas).

$$
VC1 = \prod_{i=1,2,5} \left( \frac{V_{pi}}{V_{ui}} \right) \left[ \left( \prod_{i=1}^{10} P_{pi} * V_{pi} \right)^{10} \right]
$$
$$
VC2 = \prod_{i=1,4,5,7} \left( \frac{V_{ji}}{V_{ui}} \right) \left[ \left( \prod_{i=1}^{7} P_{ji} * V_{ji} \right)^7 \right]
$$
$$
VC3 = \prod_{i=4,7,9,10} \left( \frac{V_{ai}}{V_{ui}} \right) \left[ \left( \prod_{i=1}^{12} P_{ai} * V_{ai} \right)^{12} \right]
$$
$$
VC4 = \prod_{i=6,10,12,17} \left( \frac{V_{ei}}{V_{ui}} \right) \left[ \left( \prod_{i=1}^{17} P_{ei} * V_{ei} \right)^{17} \right]
$$
$$
VC =
\begin{cases}
    \frac{1}{4} \sum_{i=1}^{4} VC_i, & \text{si } \prod_{i=1}^{4} VC_i \neq 0 \\
    0, & \text{en otro caso}
\end{cases}

$$
VC = Valor total de una aplicación candidata.
Luego una "regla de tres" entre el valor obtenido VC y el valor máximo posible VC máximo.
**VALORES OBTENIDOS**
**VC1** = 77.8658
**VC2** = 64.65029
**VC3** = 46.13250
**VC4** = 57.503471

**VC sin normalizar** =  61.5380
**VC máximo** = 76.2129
**VC normalizado** = 80.7448% (tras aplicar la regla de tres)


# Advertencia Legal y Descargo de Responsabilidad

Por favor, lea detenidamente la siguiente advertencia legal antes de utilizar la aplicación **NutriDiab**.

El contenido y las funcionalidades proporcionadas por NutriDiab están diseñados con el propósito de apoyar, no reemplazar, la relación que existe entre pacientes y sus médicos o proveedores de salud. La información proporcionada a través de esta aplicación se ofrece únicamente con fines educativos y de apoyo general.

NutriDiab no ofrece consejos médicos personalizados, diagnósticos o planes de tratamiento. Las recomendaciones ofrecidas por este sistema experto están basadas en directrices generales y no deben ser interpretadas como consejos médicos específicos. La gestión de su salud debe ser siempre supervisada por un profesional de la salud calificado. Nunca ignore el consejo profesional ni demore la búsqueda de asesoramiento médico debido a algo que haya leído o utilizado en esta aplicación.

El uso deNutriDiab es completamente voluntario y a discreción del usuario. No nos hacemos responsables de cualquier daño directo, indirecto, incidental, consecuente, especial, ejemplar, punitivo o de otro tipo que resulte de la mala utilización de la aplicación, o por la confianza en la información proporcionada a través de la misma.

Al utilizarNutriDiab, usted reconoce y acepta que la responsabilidad de las decisiones o acciones que tome en base a la información proporcionada es suya. Se recomienda encarecidamente que toda decisión médica o de salud sea tomada en consulta con su médico o profesional de la salud.

La responsabilidad del uso adecuado de NutriDiab recae exclusivamente en el usuario.
