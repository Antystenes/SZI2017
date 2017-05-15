(defrule input
  (input-string)
  =>
  (assert (made-of read))
  (assert (color read))
  (assert (size read)))

(defrule 1
  (made-of glass)
  (color colorful)
  (size average)
  =>
  (printout t "put-into color-glass")
  (assert (put-into color-glass)))

(defrule 2
  (made-of glass)
  (color plain)
  (size average)
  =>
  (printout t "put-into plain-glass")
  (assert (put-into plain-glass)))

(defrule 3
  (made-of cardboard)
  (color colorful)
  (size small)
  =>
  (printout t "put-into cardboard")
  (assert (put-into cardboard)))

(defrule 4
  (made-of cardboard)
  (color colorful)
  (size average)
  =>
  (printout t "put-into cardboard")
  (assert (put-into cardboard)))

(defrule 5
  (made-of cardboard)
  (color colorful)
  (size big)
  =>
  (printout t "bust put-into cardboard")
  (assert (bust put-into cardboard)))

(defrule 6
  (made-of steel)
  (color colorful)
  (size small)
  =>
  (printout t "grind put-into metal")
  (assert (grind put-into metal)))

(defrule 7
  (made-of steel)
  (color colorful)
  (size average)
  =>
  (printout t "grind put-into metal")
  (assert (grind put-into metal)))

(defrule 8
  (made-of steel)
  (color colorful)
  (size big)
  =>
  (printout t "grind put-into metal")
  (assert (grind slice put-into metal)))

(defrule 9
  (made-of steel)
  (color plain)
  (size small)
  =>
  (printout t "put-into metal")
  (assert (put-into metal)))

(defrule 10
  (made-of steel)
  (color plain)
  (size average)
  =>
  (printout t "put-into metal")
  (assert (put-into metal)))

(defrule 11
  (made-of steel)
  (color plain)
  (size big)
  =>
  (printout t "slice put-into metal")
  (assert (slice put-into metal)))

(defrule 12
  (made-of zinc)
  (color colorful)
  (size small)
  =>
  (printout t "grind put-into metal")
  (assert (grind put-into metal)))

(defrule 13
  (made-of zinc)
  (color colorful)
  (size average)
  =>
  (printout t "grind put-into metal")
  (assert (grind put-into metal)))

(defrule 14
  (made-of zinc)
  (color colorful)
  (size big)
  =>
  (printout t "grind slice put-into metal")
  (assert (grind slice put-into metal)))

(defrule 15
  (made-of zinc)
  (color plain)
  (size small)
  =>
  (printout t "put-into metal")
  (assert (put-into metal)))

(defrule 16
  (made-of zinc)
  (color plain)
  (size average)
  =>
  (printout t "put-into metal")
  (assert (put-into metal)))

(defrule 17
  (made-of zinc)
  (color plain)
  (size big)
  =>
  (printout t "slice put-into metal")
  (assert (slice put-into metal)))

(defrule 18
  (made-of tin)
  (color colorful)
  (size small)
  =>
  (printout t "grind put-into metal")
  (assert (grind put-into metal)))

(defrule 19
  (made-of tin)
  (color colorful)
  (size average)
  =>
  (printout t "grind put-into metal")
  (assert (grind put-into metal)))

(defrule 20
  (made-of tin)
  (color colorful)
  (size big)
  =>
  (printout t "grind put-into metal")
  (assert (grind slice put-into metal)))

(defrule 21
  (made-of tin)
  (color plain)
  (size small)
  =>
  (printout t "put-into metal")
  (assert (put-into metal)))

(defrule 22
  (made-of tin)
  (color plain)
  (size average)
  =>
  (printout t "put-into metal")
  (assert (put-into metal)))

(defrule 23
  (made-of tin)
  (color plain)
  (size big)
  =>
  (printout t "slice put-into metal")
  (assert (slice put-into metal)))

(defrule 24
  (made-of plastic)
  (color colorful)
  (size small)
  =>
  (printout t "put-into plastic")
  (assert (put-into plastic)))

(defrule 25
  (made-of plastic)
  (color colorful)
  (size average)
  =>
  (printout t "put-into plastic")
  (assert (put-into plastic)))

(defrule 26
  (made-of plastic)
  (color colorful)
  (size big)
  =>
  (printout t "break-into-pieces put-into plastic")
  (assert (break-into-pieces put-into plastic)))

(defrule 27
  (made-of plastic)
  (color plain)
  (size small)
  =>
  (printout t "put-into plastic")
  (assert (put-into plastic)))

(defrule 28
  (made-of plastic)
  (color plain)
  (size average)
  =>
  (printout t "put-into plastic")
  (assert (put-into plastic)))

(defrule 29
  (made-of plastic)
  (color plain)
  (size big)
  =>
  (printout t "break-into-pieces put-into plastic")
  (assert (break-into-pieces put-into plastic)))
