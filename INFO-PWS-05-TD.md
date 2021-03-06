# At Home

```
# edit /etc/dnf/dnf.conf
sudo vim /etc/dnf/dnf.conf
# remove the line `proxy=http://proxy:3128/`

# remove UFR Blois yum repo
sudo mv /etc/yum.repos.d/utfr_st_diblois_centos8s.repo ~/
```

---

# At the university

Add proxy to be use by gem package 

```
# ~/.gemrc
http_proxy: http://proxy:3128
```

---

# Toolings

```
sudo snap install postman
sudo snap install rubymine --classic
sudo snap install gitkraken --classic
```

---

# Rails - Installation

```
# add ruby development package (require by some gem)
sudo dnf install -y ruby-devel

# add rails gem
gem install rails -v 5.2 --user-install
```

---

# Create a new Rails App

```
# create a ~/Developer directory
cd ~
mkdir Developer
cd Developer

# create a new Rails App in the developer Directory
rails new messenger --api --skip-bundle
cd messenger
bundle install --path bundle/vendor

# start rails
bin/rails server
```

Test your new Rails app using
> http://localhost:3000

--- 

# Create your first Rails Controller/Model

```
# generate files for the model
bin/rails generate scaffold Message text:string

# migrate the database (generated by the scaffold)
bin/rake db:migrate
```

---

# Test messages

## Add a new message

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"text":"text"}' \
  http://localhost:3000/messages
```

## Get the messages list via HTTP

```
curl --request GET http://localhost:3000/messages
```

## Get the messages list via the console

```
bin/rails console
> Message.all
```

--- 

# Create your second Controller/Model

```
# remove the table in the database
bin/rake db:rollback

# remove the previously generated message scaffold
bin/rails destroy scaffold Message

# generate a new user scaffold
bin/rails generate scaffold User name:string

# generate a new message scaffold (link to user)
bin/rails generate scaffold User name:string
bin/rails generate scaffold Message text:string user:references
bin/rake db:migrate

# migrate the database
bin/rake db:migrate
```

---

# Test your first relational model

## create a new user

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"name":"Hugues"}' \
  http://localhost:3000/users
```

## create a new message link to the user

```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"text":"text", "user_id": 1}' \
  http://localhost:3000/messages
```

--- 

# Update the generated code

```
# app/models/message.rb
class Message < ApplicationRecord
  belongs_to :user

  def as_json(options = {})
    super(only: [:id, :text, :created_at], include: { user: { only: [:id, :name] } })
  end
end
```

```
# app/models/user.rb
class User < ApplicationRecord
  def as_json(options = {})
    super(only: [:id, :name])
  end
end
```

# More console

```
```

# SQLite

```
# https://www.sqlite.org/cli.html
bin/rails dbconsole
sqlite> select * from messages;
sqlite> select * from users;
sqlite> .exit
```