postgres:
	docker run --name postgres14 -p 5432:5432 -e POSTGRES_USER=dias -e POSTGRES_PASSWORD=secret -d postgres:14.5

createdb:
	docker exec -it postgres14 createdb --username=dias --owner=dias simple_bank

dropdb:
	docker exec -it postgres14 dropdb --username=dias simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://dias:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://dias:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown