## 起動方法

```
$ docker-compose up --build
```

別のターミナルで
```
$ docker-compose run app db:create
$ docker-compose run app db:migreate
$ docker-compose run app db:seed
```
