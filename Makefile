#
# VacciBody CLI
# Makefile
# 

init: build run
	
build:
	docker build . -t vaccibody

run: clean 
	docker run -it --name vaccibody vaccibody /build/bin/VacciBody match "Resources/peptides.fasta" "Resources/proteome.fasta"
	docker logs -f --since=1s vaccibody
	docker cp vaccibody:/app/result.json ./Resources/.
	docker cp vaccibody:/build/bin/VacciBody ./Resources/.
	
clean:
	docker rm vaccibody
	
mac:
	swift package resolve
	swift package generate-xcodeproj
	open *.xcodeproj
