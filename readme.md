stupid_data
===========

A stupid ORM for Ruby and Postgres. 

Why?
----

ActiveRecord is awesome but I wondered what a super simple ORM might look like. Nothing clever, just really basic and stupid.

How to query for data
---------------------

To get a collection of dynamic objects with attributes that match the columns returned by the select statement:

```
db = StupidData.new("dbname=my_cool_database")
users = db.query("select name from users")

users.each do |user|
  puts user.name
end
```

To get a collection of objects of a specific type, setting the attributes that match columns in the returned records:

```
class User
  attr_accessor :name
end

db = StupidData.new("dbname=my_cool_database")
users = db.query("select name from users", User)

users.each do |user|
  puts user.name
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

TODO

How to update existing records
------------------------------

TODO

How to delete existing records
------------------------------

TODO
