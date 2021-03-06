#L? as tabelas OBS:Alterar o diret?rio 

Taxonomic <- read.delim("coral_taxonomic_metagenomes.tsv")
functional <- read.delim("coral_function_metagenomes.tsv")

#Busca e armazena as colunas de interesse

metagenome <- Taxonomic[,c('metagenome')]
domain <- Taxonomic[,c('domain')]
species <- Taxonomic[,c('species')]
abundance <- Taxonomic[,c('abundance')]
phylum <- Taxonomic[,c('phylum')]
class <- Taxonomic[,c('class')]
order <- Taxonomic[,c('order')]
family <- Taxonomic[,c('family')]
genus <- Taxonomic[,c('genus')]

#Verifica o tamanho das tabelas

tamanho1 <- length(metagenome)
tamanho2 <- length(functional[,c('metagenome')])

#Preenche os vetores necessarios

occurenceid <- seq(1,tamanho1)
basisofrecord <- rep('HumanObservation', tamanho1) 
eventdate <- rep('2011-02-09', tamanho1) 
decimalLatitude <- rep('-20.485', tamanho1)
decimalLongitude <- rep('-36.130', tamanho1)

#Cria a tabela Occurence

occurence <- data.frame(OcurrenceID = occurenceid , BasisOfRecord = basisofrecord, EventDate = eventdate, EventID = metagenome, kingdom =domain, Phylum = phylum, Class = class, Order = order, Family = family, Genus = genus, TaxonRank = species, IndividualCount = abundance, OrganismQuantity = abundance) #, DecimalLatitude = decimalLatitude  , #DecimalLongitude = decimalLongitude)
write.csv(occurence, "Occurence.csv", row.names = FALSE)

#Cira a tabela Event
event <- data.frame(EventID = metagenome, EventDate = eventdate, DecimalLatitude = decimalLatitude, DecimalLongitude = decimalLongitude)
write.csv(event, "Event.csv", row.names = FALSE)

#Parametros para o l?o

z <- 1
y <- 1

#Cria um vetor com as nomeclaturas necessarias

measurementtype <- c('Level 1', 'Level 2', 'Level 3', 'Function', 'Abundance', 'Avg eValue', 'Avg Ident', 'Avg Align Len', '# hits')

#Cria um vetor com meansurementid

vet1 <- c(rep(y, 9))

#Cria um vetor com os respectivos eventid

vet2 <- c(rep (c(t(functional [y:y, c('metagenome')])),9)) 

#Cria um vetor com os respectivos meansurmentevalue
measurementvalue <- c(t(functional [y:y, c('level.1','level.2', 'level.3','function.', 'abundance', 'avg.eValue', 'avg...ident', 'avg.align.len','X..hits')])) 


while (z <= tamanho2 ) {

  y = y + 1
  z = z + 1
  
  measurementvalue <- c(measurementvalue, t(functional [y:y, c('level.1','level.2', 'level.3','function.', 'abundance', 'avg.eValue', 'avg...ident', 'avg.align.len','X..hits')])) 
  vet1 <- c(vet1, rep(y , 9))
  vet2 <- c(vet2, rep (c(t(functional [y:y, c('metagenome')])),9)) 
  
} 

#Cria um vetor auxiliar que preenche de acordo com o numero de vezes de execu?ao do la?o
names <- rep(measurementtype, z)

#Cria a tabela meansurementorfacts
meansurementorfacts <- data.frame( EventID= vet2, measurementID = vet1, MeasurementType = names, MeasurementValue = measurementvalue) 
write.csv(meansurementorfacts, "MeasurementsOrFacts.csv", row.names = FALSE)

