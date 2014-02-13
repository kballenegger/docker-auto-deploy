# docker-auto-deploy

This is a simple web-app whose reponsability it is to respond to a GitHub
web-hook, and automatically deploy the application on a commit.

This was built in the development of [Quoth][]

## Usage

A YAML config file is assumed to be present at the path `/auto-deploy-conf.yml`

## Configuration

```yml
secret: 1af182f0bd16bd6f77c0160b030d452ff7270c01
mailto: ['kenneth@ballenegger.com', 'adammork@gmail.com']
script: |
    echo 'Stopping server'
    docker kill app-1
    docker rm app-1
    cd /docker/app
    echo 'Updating code'
    git fetch &&\
    git checkout origin/master &&\
    git submodule update --init
    echo 'Restarting server'
    cd /docker
    docker run -d \
        -v /app/app:/app \
        -e "env=$env" \
        -expose 80 \
        -name app-1 \
        ruby \
        bash -c -l 'export MONGODB_URI="mongodb://mongo-1.mongo.live.docker:27017"; cd /app && bundle --deployment && bundle exec thin -R config.ru -p 80 start'

smtp:
    address: 'smtp.mailgun.org'
    port: 587
    domain: 'quothapp.com'
    user_name: 'user'
    password: 'pass'
    authentication: 'plain'
    enable_starttls_auto: true
```


[Quoth]: https://quothapp.com
