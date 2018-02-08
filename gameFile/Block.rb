
#Un block est définie par son symbole ainsi que sa probabilitée d'apparition

class Block
    def initialize
        @symbole = "."
        @proba = 0 
    end

    def symbole
        @symbole
    end

    def proba
        @proba
    end

    def penaliteeNiveau(niveau, palier)
        @proba -= niveau
    end
end

class BlockPierre < Block
    def initialize
        @symbole = "P"
        @proba = 100
    end
end

class BlockBronze < Block
    def initialize
        @symbole = "B"
        @proba = 15
    end
    def penaliteeNiveau(niveau, palier)
        @proba -= 5*(niveau-palier) if niveau - palier >= 0
    end
end

class BlockFert < Block
    def initialize
        @symbole = "F"
        @proba = 8
    end

    def penaliteeNiveau(niveau, palier)
        @proba -= 5*(niveau-palier) if niveau - palier >= 0
    end
end

class BlockDiamant < Block

    def initialize
        @symbole = "D"
    end
    
end

class BlockOr < Block
    def initialize
        @symbole = "O"
        @proba = 4
    end
    def penaliteeNiveau(niveau, palier)
        @proba -= 1*(niveau-palier) if niveau - palier >= 0
    end
end

class BlockDiamant < Block

    def initialize
        @symbole = "D"
        @proba = 3
    end
    
end

class BlockRuby < Block

    def initialize
        @symbole = "R"
        @proba = 1
    end
    
end
