FROM golang:1.18-alpine

# nah adi di sistme lpine nya, ini sya instll curl ya, ini emamng harus di download jadi ga langusng ada
# buat ngecekaja pake cmd 
RUN apk --no-cache add curl
RUN mkdir app
WORKDIR /app
COPY main.go app

EXPOSE 8080

HEALTHCHECK --interval=5s --start-period=5s 


CMD curl -f http://localhost:8080/health
CMD go run main.go