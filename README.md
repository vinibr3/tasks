# README

## Requirements

This README would normally document whatever steps are necessary to get the
application up and running.
For server:

Things you may want to cover:
* Docker version >= 24.0.2
* Docker Compose version >= v2.18.1

* Ruby version
For application:

* System dependencies
* Ruby version 3.4.4
* Rails version 8.0.3
* Bundler 2.6.9

* Configuration

### Settings

## Running API

Now, you need to create and start the containers to run the API. So you can do that.

```
docker-compose up -d
```

When executed the command above, your api service can be to access on your browser with url `http://localhost:3000`.

### Health of Application

Once the api is running you can check the health of your them through the url `http://localhost:3000/up`. So you'll see a green screen indicate which everything ready.
