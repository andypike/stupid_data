stupid_data
===========

A stupid ORM for Ruby and Postgres. 

How to use
----------

```
database = StupidData.new("dbname=my_cool_database")
users = database.query("select name from users")

users.each do |user|
  puts user.name
end
```
