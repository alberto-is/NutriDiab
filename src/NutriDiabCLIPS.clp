
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


(defrule imprimir-hechos
    (declare (salience 4))
  =>
   (facts)
   )