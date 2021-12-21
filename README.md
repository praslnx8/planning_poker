# Planning Poker
A Flutter project for Agile Story point estimation tool.

## Setup
- Create a firebase web app with realtime database and hosting enabled
- Create a new file `env` using the template `env.example` with the values for the firebase app
- Run the command `flutter run` to run this application locally.

## To deploy it to Firebase for release
- Run the command `flutter build web --release` to generate release build
- Run `firebase deploy --only hosting` to deploy the application

For Live Demo: https://tw-planning-poker.web.app/

## Tech Details
This project has modules categorized as
- UI: Contains all UI related logics such as page, widgets etc
- Models: Contains Actual Domain models of Planning Poker
- adapters: Adapter classes to communicate to External endpoints(Currently it is Firebase Database now)
- DTOs: Data transfer classes consumed by adapters.

The business logic of Planning Poker should reside in the domain model classes.

## Server side
Right now this app uses firebase realtime database as the primary source as backend.
We have server side validation added in `database.rules.json`
