FROM golang:1.22.5 as base

# It will land and start from this directory
WORKDIR /app

# go.mod is like the requirement.txt
COPY go.mod .

# This is like pip install
RUN go mod download

COPY . .

RUN go build -o main .


# Final stage - Distroless image
FROM gcr.io/distroless/base

#If you see line 1, we have created the base
COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD [ "./main" ]

#Github Co-pilot helps to write docker image