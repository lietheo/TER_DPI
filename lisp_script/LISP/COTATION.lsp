(defun c:EXPORT_COTATIONS_CSV ( / doc ms csvfile file ent layerName attList att tag val
                                  nom zreseau prof pos x y blockName type r1 r2 length-type)

  (vl-load-com)
  (setq doc (vla-get-ActiveDocument (vlax-get-acad-object)))
  (setq ms (vla-get-ModelSpace doc))
  (setq csvfile "C:\\Users\\liege\\Downloads\\cotations_points_export.csv")

  ;; Ouvre le fichier en écriture
  (setq file (open csvfile "w"))
  (if (not file)
    (progn
      (prompt "\nErreur : Impossible d'ouvrir le fichier pour écriture.")
      (exit)
    )
  )

  ;; Écrit l'entête CSV
  (write-line "Nom,TYPE,Zreseau,PROF,X,Y,Layer" file)

  ;; Parcourt toutes les entités dans ModelSpace
  (vlax-for ent ms
    ;; Filtre uniquement les blocs
    (if (eq "AcDbBlockReference" (vla-get-ObjectName ent))
      (progn
        (setq layerName (vla-get-Layer ent))
        (setq blockName (vla-get-EffectiveName ent))

        ;; Condition : calque contenant "Cotations" et nom du bloc commençant par "TC"
        (if (and (wcmatch layerName "*Cotations*") (wcmatch blockName "TC*"))
          (progn
            (setq zreseau "" prof "" type "")

            ;; Extraction du TYPE entre "R_" et "_Cotations"
            (setq r1 (vl-string-search "R_" layerName))
            (setq r2 (vl-string-search "_Cotations" layerName))
            (if (and r1 r2 (> r2 r1))
              (progn
                (setq length-type (- r2 (+ r1 2))) ; longueur entre R_ (2 chars) et _Cotations
                (setq type (substr layerName (+ r1 3) length-type))
              )
            )

            ;; Récupère les attributs du bloc
            (if (vlax-method-applicable-p ent 'GetAttributes)
              (progn
                (setq attList (vlax-invoke ent 'GetAttributes))
                (foreach att attList
                  (setq tag (strcase (vla-get-TagString att)))
                  (setq val (vla-get-TextString att))
                  (cond
                    ((= tag "ZRESEAU") (setq zreseau val))
                    ((= tag "PROF") (setq prof val))
                  )
                )
              )
            )

            ;; Coordonnées du point d'insertion
            (setq pos (vlax-get ent 'InsertionPoint))
            (setq x (rtos (car pos) 2 3))
            (setq y (rtos (cadr pos) 2 3))

            ;; Écrit la ligne dans le fichier CSV
            (write-line (strcat blockName "," type "," zreseau "," prof "," x "," y "," layerName) file)
          )
        )
      )
    )
  )

  ;; Ferme le fichier
  (if file (close file))

  (prompt (strcat "\nExport terminé : " csvfile))
  (princ)
)
