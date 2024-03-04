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
