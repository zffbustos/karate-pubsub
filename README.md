# karate-pubsub POC

This project is the counter part of the `venom-api-poc` project for the evaluation of Venom vs Karate automation frameworks. The main goal is to define what framework is the most appropriate to cover our needs.

## Purpose

This project defines a Karate module which contains one test with multiple scenarios to test the behavior of AWS SQS on a local AWS server (using `Localstack` for it) which was set up as an image in a Docker container. The main goal is to verify different SQS operations to be performed in this server.

## Requirements

This project was creates using the following:

- Docker Compose version v2.23.0
- Openjdk version "21.0.1" 2023-10-17
- OpenJDK Runtime Environment (build 21.0.1+12-29)
- OpenJDK 64-Bit Server VM (build 21.0.1+12-29, mixed mode, sharing)
- Apache Maven 3.9.6
- VS Code

It is recommended to use the same versions or newer.

## Test Configuration

To run any of the pubsub test cases in this project, first you need to run docker compose.

On the root of this project, run this command:

`% docker-compose up`

This will enable docker-compose to set the localstack server where we can emulate our AWS microservices. Please do not try to kill this command as the tests will not work otherwise. It is recommendable to use another terminal to run the project commands.

## Maven

To run the test cases first you need to compile the project and bring all the required dependencies. To do so, you need to run the following command:

`% mvn install`

## Run tests

To run the test cases, you need to use Maven

`% mvn clean test -Dtest=PubSubTest`

Once run, the tests cases will execute and you will be able to see its results on the console. 

## Test visualization

The `target` directory contains the outputs of the latest executions. If you want to keep your previous executions, simply remove the parameter `clean` from the command above.

To find the outputs, you can go to the `target/karate-reports_{timestamp}` directory, where `timestamp` refers to the moment your tests were run. The reports are sorted by date, so if you need the most recent report, simply choose the last directory in your list.

The file `karate.log` in the `target` root contains the logs for all the executions as well.
Several HTML reports are generated in each `karate-reports_*` directory, you can refer to them for specific information like step results, timelines, etc.