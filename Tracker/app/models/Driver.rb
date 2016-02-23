require_relative 'Builder.rb'
require_relative 'Photographer.rb'
require_relative '../models/package.rb'
require 'pg'
require'../models/factory.rb'
require '../models/parade.rb'


worker = Factory.new

pw = 'B$t1m3RUN50uT'

worker.connect_to_db(pw)

## Create Tables
worker.create_builder_table
worker.create_photographer_table
worker.create_parade_table
worker.create_package_table


### dependency tables
worker.create_home_table
#worker.create_order_table

# Creating testing people
## Builder
build_person1 = Builder.new
build_person1.set_name_of_builder("Bob the builder")
build_person1.set_phone_number("1-801-375-5555")
build_person1.set_email("1234@asdf.com")

build_person2 = Builder.new
build_person2.set_name_of_builder("Dora wonder")
build_person2.set_phone_number("1-597-589-5698")
build_person2.set_email("asdfasd@234")

### Create Builders
build_person1 = worker.interact_with_builder('c',build_person1)
build_person2 = worker.interact_with_builder('c',build_person2)

### Update a Builder
build_person2.set_email("aaaaaaaaaaaaaaaa")
worker.interact_with_builder('u',build_person2)

### Delete a Builder
worker.interact_with_builder('D',build_person2)

### List Builders
temp = worker.interact_with_builder('l')

### Recreate a builder
build_person2.set_name_of_builder("Dora wonder")
build_person2.set_phone_number("1-597-589-5698")
build_person2.set_email("aaaaaaaaaaaaaaaa")
build_person2 = worker.interact_with_builder('c',build_person2)

### Read a Builder
temp = worker.interact_with_builder('R',build_person1)

### List Builders
temp = worker.interact_with_builder('l')


print 'here'