stupid_data
===========

A stupid ORM for Ruby and Postgres. 

Why?
----

ActiveRecord is awesome but I wondered what a super simple ORM might look like. Nothing clever, just really basic and stupid.

How to use to get data
----------------------

To get a collection of dynamic objects with attributes that match the columns returned by the select statement:

```
database = StupidData.new("dbname=my_cool_database")
users = database.query("select name from users")

users.each do |user|
  puts user.name
end
```

To get a collection of objects of a specific type, setting the attributes that match columns in the returned records:

```
class User
  attr_accessor :name
end

database = StupidData.new("dbname=my_cool_database")
users = database.query("select name from users", User)

users.each do |user|
  puts user.name
end
```

When retrieving data from queries, types are converted based on the database column types.

How to insert new records
-------------------------

TODO

How to update existing records
------------------------------

TODO

How to delete existing records
------------------------------

TODO

How use count queries
---------------------

TODO
