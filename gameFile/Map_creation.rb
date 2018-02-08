require_relative "Block"
MAP_SIZE_L = 80
MAP_SIZE_H = 140 #Attention la hauteur de la map doit dépasser les paliers
PALIERS = [20, 50, 90, 140] #4 paliers, inférieurs ou égale à la taille de la map

#Déclarion des différents blocks possible
#########################################################
blockDePierre = BlockPierre.new()
blockDeBronze = BlockBronze.new()
blockDeFert = BlockFert.new()
blockDeOr = BlockOr.new()
blockDeDiamant = BlockDiamant.new()
blockDeRuby = BlockRuby.new()
#########################################################

#Fonction permettant de fabriquer une grotte d'une certainte taille, matrix doit représenter la map
#et donc correspondre au taille des contantes ci-dessus
def creationGrotte(matrix, ligne, colonne)
    puts "Insertion d'une grotte en " + ligne.to_s + "," + colonne.to_s
    numGrotte = 1 + rand(3)
    grotte = contents = File.read('grottes/grotte'+numGrotte.to_s+'.txt')
    numChar = 0
    tailleGrotte = ""
    colonneDepart = colonne
    grotte.each_char do |char|
        if numChar == 0 
            tailleGrotte = char
            numChar += 1
        elsif numChar == 1
            tailleGrotte += char
            if MAP_SIZE_L - (ligne + tailleGrotte.to_i) < 0
                decrement = tailleGrotte.to_i + rand(MAP_SIZE_L - tailleGrotte.to_i)
                colonne = MAP_SIZE_L - decrement
                colonneDepart = colonne
            end
            numChar += 1
        elsif numChar == 2
            numChar += 1
        else
            unless char == "\n"
                #puts "insertion de #{char} en #{ligne}, #{colonne}" 
                matrix[[ligne, colonne]] = char
            else
                ligne += 1
                colonne = colonneDepart
            end
            colonne += 1
        end
    end
    return matrix
end

#########################################################


#Ouverture du fichier, creation d'une matrice représentant la map
fichierMap = open('./map.txt', 'w')
map = "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n"
mapMatrix = Hash.new

#On remplie la map de pierre
for i in (0...MAP_SIZE_H) do
    for k in (0...MAP_SIZE_L) do
        mapMatrix[[i,k]] = blockDePierre.symbole
    end
end

#On gère l'appariton des différents minerais
for i in (0...MAP_SIZE_H) do
    for k in (0...MAP_SIZE_L) do
        if i <= 1
            mapMatrix[[i,k]] = "#"
        elsif i > 1 && i <= PALIERS[0] 
            random = 1 + rand(100);
            intervalFert = blockDeBronze.proba..blockDeBronze.proba + blockDeFert.proba #calcul de la proba d'avoir un block de fert
            case random
            when 1..blockDeBronze.proba
                mapMatrix[[i,k]] = blockDeBronze.symbole
            end

        elsif i > PALIERS[0] && i <= PALIERS[1]
            random = 1 + rand(100)
            intervalFert = blockDeBronze.proba..blockDeBronze.proba + blockDeFert.proba #calcul de la proba d'avoir un block de fert
            intervalOr = blockDeBronze.proba + blockDeFert.proba..blockDeBronze.proba + blockDeFert.proba + blockDeOr.proba
            case random
            when 1..blockDeBronze.proba
                mapMatrix[[i,k]] = blockDeBronze.symbole
            when intervalFert
                mapMatrix[[i,k]] = blockDeFert.symbole
            when intervalOr
                mapMatrix[[i,k]] = blockDeOr.symbole
            end
        elsif i > PALIERS[1] && i <= PALIERS[2]
            random = 1 + rand(100)
            intervalOr = blockDeFert.proba..blockDeFert.proba + blockDeOr.proba
            intervalDiamant = blockDeFert.proba + blockDeOr.proba..blockDeFert.proba + blockDeOr.proba + blockDeDiamant.proba
            case random
            when 1..blockDeFert.proba
                mapMatrix[[i,k]] = blockDeFert.symbole
            when intervalOr
                mapMatrix[[i,k]] = blockDeOr.symbole
            when intervalDiamant
                mapMatrix[[i,k]] = blockDeDiamant.symbole
            end
        elsif i > PALIERS[2] && i <= PALIERS[3]
            random = 1 + rand(100)
            intervalDiamant = blockDeOr.proba..blockDeOr.proba + blockDeDiamant.proba
            intervalRuby = blockDeOr.proba + blockDeDiamant.proba..blockDeOr.proba + blockDeDiamant.proba + blockDeRuby.proba
            case random
            when 1..blockDeOr.proba
                mapMatrix[[i,k]] = blockDeOr.symbole
            when intervalDiamant
                mapMatrix[[i,k]] = blockDeDiamant.symbole
            when intervalRuby
                mapMatrix[[i,k]] = blockDeRuby.symbole
            end
        else
            random = 1 + rand(100)
            intervalDiamant = blockDeOr.proba..blockDeOr.proba + blockDeDiamant.proba
            intervalRuby = blockDeOr.proba + blockDeDiamant.proba..blockDeOr.proba + blockDeDiamant.proba + blockDeRuby.proba
            case random
            when 1..blockDeOr.proba
                mapMatrix[[i,k]] = blockDeOr.symbole
            when intervalDiamant
                mapMatrix[[i,k]] = blockDeDiamant.symbole
            when intervalRuby
                mapMatrix[[i,k]] = blockDeRuby.symbole
            end
        end
    end
end

#On insert des grottes
randomGrotte = 3000
for i in (PALIERS[0]...MAP_SIZE_H) do
    for k in (0...MAP_SIZE_L) do
        if rand(randomGrotte) == 1
            puts randomGrotte
            uneLigne = i 
            uneColonne = k
            creationGrotte(mapMatrix,uneLigne,uneColonne)
            randomGrotte -= 500 if randomGrotte - 500 > 1
        end 
    end
end

#On redéfinie la dernière ligne en block incassable

for i in (MAP_SIZE_H-1...MAP_SIZE_H) do
    for k in (0...MAP_SIZE_L) do
        mapMatrix[[i,k]] = "$"
    end
end

#On transforme la matrice en chaine de caractère
for i in (0...MAP_SIZE_H) do
    for k in (0...MAP_SIZE_L) do
        map += mapMatrix[[i,k]]
    end
    map += "\n"
end



#On écrit
fichierMap.write(map)

fichierMap.close