# Last week TD

```
bundle install --path="vendor/bundle"

# generate a new user scaffold
bin/rails generate scaffold User name:string

# generate a new message scaffold (link to user)
bin/rails generate scaffold Message text:string user:references

# migrate the database
bin/rake db:migrate
```

---

## test the Rails App

```
# in a new terminal
cd ~/Developer/messenger
bin/rails server
```

---

## launch an IDE

Sublime

---

## show logs

```
# in a new terminal
cd ~/Developer/messenger
tail -f log/development.log
```

---

## disable proxy for localhost

```
export no_proxy=localhost,127.0.0.1
export NO_PROXY=localhost,127.0.0.1
```

---

## create a new user

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"name":"Hugues"}' \
  http://localhost:3000/users
```

---

## create a new message link to the user

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"text":"text", "user_id": 1}' \
  http://localhost:3000/messages
```

---

## get messages

```
curl --request GET http://localhost:3000/messages
```

> http://localhost:3000/messages

---

# Chat message

> We want our messages to belongs to a chat

```
# generate scaffold for our new message
bin/rails generate scaffold Chat name:string user:references

# generate a migration to associate message with chat
bin/rails generate migration AddChatToMessage chat:references

# drop/create the db before applying all the migration
bin/rake db:migrate:reset
```

---

## (re)create a user

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"name":"Hugues"}' \
  http://localhost:3000/users
```

---

## create a chat

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"name":"Chat", "user_id": 1}' \
  http://localhost:3000/chats
```

---

## create a message link to a chat

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"text":"Hello", "user_id": 1, "chat_id": 1}' \
  http://localhost:3000/messages
```

> `{"chat":["must exist"]}`
> update message controller

---

## create another chat

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"name":"Another Chat", "user_id": 1}' \
  http://localhost:3000/chats
```

---

## create another message

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"text":"Hello", "user_id": 1, "chat_id": 2}' \
  http://localhost:3000/messages
```

---

## fetch all messages

```
curl --request GET http://localhost:3000/messages
```

> http://localhost:3000/messages

---


## fetch messages of a specific chat

> update message controller to fetch only the message of a specific chat

```
curl --request GET http://localhost:3000/messages?chat_id=1
```

> http://localhost:3000/messages?chat_id=1

---

## RESTful
~~~~
> update message controller to be more RESTful

> http://localhost:3000/chats/1/messages
