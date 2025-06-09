(defun c:ETIQUETTE ( / layers layer ss i ent txt pt type outputfile mleaderObj)
  (vl-load-com)

  ;; Calques concernés
  (setq layers '(("R_EP_Cotations_ADRÉ" . "EP")
                 ("R_EU_Cotations_ADRÉ" . "EU")))

  ;; Ouvrir fichier CSV
  (setq outputfile (open "C:\\Users\\liege\\Downloads\\Etiquette_EU_EP.csv" "w"))
  (write-line "Type;Calque;Texte;X;Y" outputfile)

  ;; Parcourir les calques
  (foreach pair layers
    (setq layer (car pair))
    (setq type (cdr pair))

    ;; Sélectionner les MLEADERs sur ce calque
    (setq ss (ssget "X" (list (cons 0 "MULTILEADER") (cons 8 layer))))

    (if ss
      (progn
        (setq i 0)
        (while (< i (sslength ss))
          (setq ent (ssname ss i))
          (setq mleaderObj (vlax-ename->vla-object ent))

          ;; Extraire le texte
          (setq txt (vla-get-TextString mleaderObj))

          ;; Vérifie si Ø est présent
          (if (and txt (not (wcmatch (strcase txt) "*Ø*")))
            (progn
              ;; Récupère le point de flèche (leader)
              (setq pt (vlax-safearray->list
                         (vlax-variant-value
                           (vla-GetLeaderLineVertices mleaderObj 0))))

              ;; pt est une liste de points, on prend le PREMIER (extrémité côté symbole)
              (if pt
                (write-line
                  (strcat type ";" layer ";" "\"" txt "\";"
                          (rtos (car pt) 2 2) ";" (rtos (cadr pt) 2 2))
                  outputfile)
              )
            )
          )
          (setq i (1+ i))
        )
      )
    )
  )

  (close outputfile)
  (prompt "\n✅ Export terminé avec coordonnées des FLÈCHES. Fichier : Etiquette_EU_EU.csv")
  (princ)
)
