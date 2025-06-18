# Hello World Application

This is a simple Java application that prints "Hello World" to the console every two seconds.

## Project Structure

```
hello-world-app
├── src
│   └── main
│       └── java
│           └── HelloWorld.java
├── build.gradle
├── Dockerfile
├── docker-compose.yml
└── README.md
```

## Requirements

- Java Development Kit (JDK) 8 or higher
- Gradle 6.0 or higher
- Docker (for running with Docker)
- Docker Compose (for running with Docker Compose)

## Building the Application

To build the application, navigate to the project directory and run the following command:

```
gradle build
```

## Running the Application

To run the application, use the following command:

```
gradle run
```

The application will print "Hello World" to the console every two seconds.

## Running with Docker Compose

To build and run the application using Docker Compose, use the following commands:

```
docker-compose build
docker-compose up
```

This will start the application in a Docker container. The output will be visible in your terminal.