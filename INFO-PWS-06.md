# Rails (3/3)

- ActiveRecord

> Active Record is the M in MVC - the model - which is the layer of the system responsible for representing business data and logic
-- https://guides.rubyonrails.org/active_record_basics.html

---

- naming convention
- schema convention
- action!

---

# Create

- new/save
- create

---

# Read/Find

- find
- find_by
- where
- order/limit/group_by/...

## Scope

- https://guides.rubyonrails.org/active_record_querying.html#scopes

```ruby
class Message < ActiveRecord::Base
  scope :orphan, -> { left_joins(:chats).where(chat: { id: nil }) }
end
```

## Association

- https://guides.rubyonrails.org/association_basics.html

- has_many
  - `dependent: :destroy`
- belongs_to
- has_one

```ruby
```

## Joins

```ruby
Message.joins(:chat).where(chats: { name: 'Development' })
```

## Include

```ruby
Message.includes(:chat).first.chat
```

--- 

# Update

- update
- update_all
- update_column

---

# Delete

- destroy

--- 

# Validations

- https://edgeguides.rubyonrails.org/active_record_validations.html

```ruby
class Message < ActiveRecord::Base
  validates :text, presence: true
end
```

