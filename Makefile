#
# VacciBody CLI
# Makefile
# 

all: build run
	
build:
	docker build . -t vaccibody --no-cache
	docker cp vaccibody:/build/bin/VacciBody ./Resources/.

run:
	docker run -it --name vaccibody vaccibody /build/bin/VacciBody match "Resources/peptides.fasta" "Resources/proteome.fasta"
	docker cp vaccibody:result.json ./Resources/.
	
mac:
	swift package update
	swift package generate-xcodeproj
	open *.xcodeproj