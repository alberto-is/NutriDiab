(defrule Read-Name
 =>
    (printout t "Por favor, introduce algo: ")
    (bind ?entrada (read))
    (printout t "Has introducido: " ?entrada crlf)
    (assert (entrada ?entrada))
)