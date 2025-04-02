FROM cirrusci/flutter:latest

WORKDIR /app

COPY . .

RUN flutter pub get
RUN flutter build web

CMD ["flutter", "run", "-d", "web-server"]
