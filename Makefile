#
# VacciBody CLI
# Makefile
# 

init: build run
	
build:
	docker build . -t vaccibody --no-cache
	docker cp vaccibody:/build/bin/VacciBody ./Resources/.

run:
	docker run -it --name vaccibody vaccibody /build/bin/VacciBody match "Resources/peptides.fasta" "Resources/proteome.fasta"
	docker cp vaccibody:result.json ./Resources/.
	
start:
	docker start vaccibody
	docker logs -f --since=1s vaccibody
	docker cp vaccibody:result.json ./Resources/.
	
mac:
	swift package resolve
	swift package generate-xcodeproj
	open *.xcodeproj