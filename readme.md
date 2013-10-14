stupid_data
===========

A stupid ORM for Ruby and Postgres. 

Why?
----

ActiveRecord is awesome but I wondered what a super simple ORM might look like. Nothing clever, just really basic and stupid.

Stupid means it's not that flexible
-----------------------------------

Here are some limitations:

* Only works with Postgres.
* Table names must be plural of the class.
* There is no query DSL, just use SQL.
* There are no association loading (and so no select n+1 issues)
* Tables/classes must have an integer id field/attribute that the db increments
* Objects that are inserted/updated must have an id attribute

How to query for data
---------------------

To get a collection of dynamic objects with attributes that match the columns returned by the select statement:

```
db = StupidData.new("dbname=my_cool_database")
users = db.query("select name from users")

users.each do |user|
  puts user.name  # => "Andy"
end
```

To get a collection of objects of a specific type, setting the attributes that match columns in the returned records, other attributes will be nil:

```
class User
  attr_accessor :id, :name
end

db = StupidData.new("dbname=my_cool_database")
users = db.query("select name from users", User)

users.each do |user|
  puts user.name  # => "Andy"
  puts user.id    # => nil
end
```

When retrieving data from queries, types are converted based on the database column types.

How use count queries
---------------------

```
db = StupidData.new("dbname=my_cool_database")
num_of_users = db.count("select count(*) from users")
```

How to insert new records
-------------------------

This will insert a new record in a table matching the plural of the class name. Attributes that have matching fields in this table will be stored. The class/table must have an id attribute/field.

```
class User
  attr_accessor :id, :name
end

user = User.new
user.name = "Andy"

db = StupidData.new("dbname=my_cool_database")
db.insert(user)

puts user.id # => 1
```

How to update existing records
------------------------------

This will update a record in a table matching the plural of the class name by it's id. All attributes that match fields in the table will be overwritten.

```
class User
  attr_accessor :id, :name
end

user = User.new
user.id = 2
user.name = "Andy"

db = StupidData.new("dbname=my_cool_database")
db.update(user)
```

How to delete existing records
------------------------------

TODO
