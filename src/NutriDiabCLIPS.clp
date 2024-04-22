
(deftemplate hecho-1
   (slot atributo1)
   (slot atributo2))
(deftemplate persona
   (slot edad)
   (slot sexo)
   (slot peso)
   (slot altura)
   (slot intolerancia)
   (slot actividad))

(defrule leer_archivo_Persona
    (declare (salience 10))
  =>
   (open "C:\\Users\\alber\\OneDrive\\Escritorio\\Gallego Sistema Experto\\NutriDiab\\data\\datos.txt" data "r")
   (bind ?data (readline data)) ; Persona
         ;(printout t ?data crlf)  ;;;
   (bind ?data (readline data)) ; Edad
         ;(printout t ?data crlf)  ;;;
   (bind ?data (readline data)) ; integer
      (bind ?data1 (integer(string-to-field(str-cat ?data)))) ; convierte data1 a entero
         (printout t ?data1 crlf) ;;;
   (bind ?data (readline data)) ; Sexo
         ;(printout t ?data crlf)  ;;;
   (bind ?data (readline data)) ; string
      (bind ?data2(str-cat(string-to-field ?data))) ; convierte data2 a string
         (printout t ?data2 crlf)  ;;;
   (bind ?data (readline data)) ; Peso
         ;(printout t ?data crlf)  ;;;
   (bind ?data (readline data)) ; integer   
      (bind ?data3 (integer(string-to-field(str-cat ?data)))) ; convierte data3 a entero
         (printout t ?data3 crlf) ;;;  
   (bind ?data (readline data)) ; Altura
         ;(printout t ?data crlf)  ;;;
   (bind ?data (readline data)) ; integer
      (bind ?data4  (integer(string-to-field(str-cat ?data)))) ; convierte data5 a entero 
         (printout t ?data4 crlf) ;;;
   (bind ?data (readline data)) ; Intoleracia
         ;(printout t ?data crlf)  ;;;
   (bind ?data (readline data)) ; string
      (bind ?data5 (str-cat(string-to-field ?data))) ; convierte data6 a string
         (printout t ?data5 crlf)  ;;;
   (bind ?data (readline data)) ; Actividad
         ;(printout t ?data crlf)  ;;;
   (bind ?data (readline data)) ; string
      (bind ?data6 (str-cat(string-to-field ?data))) ; convierte data7 a string
         (printout t ?data6 crlf)  ;;;
   (assert (persona (edad ?data1) (sexo ?data2) (peso ?data3) (altura ?data4) (intolerancia ?data5) (actividad ?data6)))
   (close data)
)


; VERIFICACIÓN DE LOS PACIENTES
(defrule verificar_paciente
    (declare (salience 9))
    ?persona <- (persona (edad ?edad) (sexo ?sexo) (peso ?peso) (altura ?altura) (intolerancia ?intolerancia) (actividad ?actividad))
    =>
      (if (and (>= ?edad 3) (<= ?edad 100) (>= ?peso 25) (<= ?peso 200) 
            (>= ?altura 50) (<= ?altura 200) (or (eq ?sexo "Masculino") (eq ?sexo "Femenino")) 
            (or (eq ?actividad "Baja") (eq ?actividad "Media") (eq ?actividad "Alta"))) ; Alta = Avtiava, Media = Moderada, Baja = Sedentaria
      then
         (printout t "Paciente verificado" crlf)
      else
         (printout t "Paciente no verificado" crlf)
         (retract ?persona))

)

(defrule imprimir-hechos
    (declare (salience 1))
  =>
   (facts)
   )