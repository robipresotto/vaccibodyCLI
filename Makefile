all: build run copy
	
build:
	docker build . -t vaccibody --no-cache

run:
	docker run -it --name vaccibody vaccibody /build/bin/VacciBody match "Resources/peptides.fasta" "Resources/proteome.fasta"

copy:
	docker cp vaccibody:/build/bin/VacciBody ./Resources/.
	docker cp vaccibody:result.json ./Resources/.