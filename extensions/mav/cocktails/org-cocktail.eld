(org-cocktail-recipe
 "* " (p "Cocktail name: " name) n
 ":PROPERTIES:" n
 ":ID: neo-cocktail-" (s name) n
 ":SPIRIT: " (p "Spirit: ") n
 ":METHOD: " (p "Method (stirred/shaken/etc): ") n
 ":GLASS: " (p "Glass: ") n
 ":ICE: " (p "Ice: ") n
 ":ABV: " (p "ABV (low/med/high): ") n
 ":ORIGIN: " (p "Origin: ") n
 ":END:" n n
 "** Ingredients" n
 "- " p n n
 "** Method" n
 p n n
 "** Notes" n
 p n n
 "** History" n
 p)
