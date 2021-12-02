https://1.101.fr

Follow the instruction at
https://github.com/huguesbr/ufr-blois-development-web-messenger.git

---

Our Chat now have users, chats, messages and memberships.
The current user's is faked by passing a `?current_user_id=123` where `123` is the id of the desired current user.

| Action | Users        | Chats        | Messages                         | Membership   |
|--------|--------------|--------------|----------------------------------|--------------|
| list   | anybody      | any user     | user with an accepted membership | any user     |
| create | anybody      | any user     | user with an accepted membership | any user     |
| update | current user | chat's owner | message's owner                  | chat's owner |
| delete | current user | chat's owner | message's owner                  | chat's owner |
| show   | anybody      | any user     | user with an accepted membership | any user     |

---

At the end of this TD we want authenticate user via a session and requiring a valid session token for the current user.

| Action | Users        | Chats        | Messages                         | Membership   | Session                |
|--------|--------------|--------------|----------------------------------|--------------|------------------------|
| list   | anybody      | any user     | user with an accepted membership | any user     | nobody                 |
| create | anybody      | any user     | user with an accepted membership | any user     | valid user credentials |
| update | current user | chat's owner | message's owner                  | chat's owner | nobody                 |
| delete | current user | chat's owner | message's owner                  | chat's owner | session's owner        |
| show   | anybody      | any user     | user with an accepted membership | any user     | nobody                 |

---

# Session

> In our previous implementation, user where identied by simply passing a `?current_user_id=123`.
> We now want to create a session table to store identied user.

- Create a session scaffold with a user (`references`) and a token (`string`)
- Any body can create a session for any user for now
- Auto generate a random string for the session token

```ruby
# app/models/session.rb
class Session < ApplicationRecord
  belongs_to :user

  before_create do |session|
    session.token = SecureRandom.hex(32)
  end
end
```

--- 

# Verify user's session  

> We now want to verify the current user via a session token instead of `current_user_id`

- Update the `application_controller.rb` to lookup the user by checking the param `?current_session_token=ABC`

--- 

# User credentials

> We want to add a new password field to user

- Create a migration to add a password (string) field to user table
- Add a default password to user created in your `seeds.rb`
- Allow user to pass `password` on creation/update
- Reset your database

---

# Check user credentials on session creation

> We now want to lock our session creation to check user credentials in order to create a session
> We also want to remove listing/updating/showing any session record

- update `sessions_controller.rb`
- update `routes.rb`

---

# User uniqueness

> Now that our user can login, we want each user name to be unique

- Update `user.rb` to add a uniqueness validation