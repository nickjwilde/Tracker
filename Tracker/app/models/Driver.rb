# External Files
require 'pg'

# Internal Files
require_relative 'Builder.rb'
require_relative 'Photographer.rb'
require_relative '../models/package.rb'
require '../models/factory.rb'
require '../models/parade.rb'
require '../models/order.rb'
require '../models/home.rb'


worker = Factory.new
# This should be your password, utilize this
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

## Photographer
photo_person1 = Photographer.new
photo_person1.set_name("Beauty Beth")
photo_person1.set_phone("1-234-567-8910")
photo_person1.set_email("asdfasdfasdf")

photo_person2 = Photographer.new
photo_person2.set_name("wonder woman")
photo_person2.set_phone("1-101-101-1010")
photo_person2.set_email("a")
photo_person2.set_notes("This person is not really wonder woman")

### Create Photographer
photo_person1 = worker.interact_with_photographer('c',photo_person1)
photo_person2 = worker.interact_with_photographer('c',photo_person2)

### Update a Photographer
photo_person2.set_email("aaaaaaaaaaaaaaaa")
worker.interact_with_photographer('u',photo_person2)

### Delete a Photographer
worker.interact_with_photographer('D',photo_person2)

### List Photographer
temp = worker.interact_with_photographer('l')

### Recreate a Photographer
photo_person2.set_name("wonder woman")
photo_person2.set_phone("1-101-101-1010")
photo_person2.set_email("a")
photo_person2.set_notes("This person is not really wonder woman")
photo_person2 = worker.interact_with_photographer('c',photo_person2)

### Read a Photographer
temp = worker.interact_with_photographer('R',photo_person1)

### List Photographer
temp = worker.interact_with_photographer('l')


## Package
package1 = Package.new
package1.set_num_of_photos("10")
package1.set_notes("This is the notes about package one")

package2 = Package.new
package2.set_num_of_photos("15")
package2.set_notes("THese are the notes for package two")

### Create Package
package1 = worker.interact_with_package('c',package1)
package2 = worker.interact_with_package('c',package2)

### Update a Package
package2.set_notes("These are the new notes for package 2")
worker.interact_with_package('u',package2)

### Delete a Package
worker.interact_with_package('D',package2)

### List Package
temp = worker.interact_with_package('l')

### Recreate a Package
package2.set_num_of_photos("5")
package2.set_notes("These are the notes for package two, that are reentered")
package2 = worker.interact_with_package('c',package2)

### Read a Package
temp = worker.interact_with_package('R',package1)

### List Package
temp = worker.interact_with_package('l')

## Parade
parade1 = Parade.new
parade1.set_parade_name("Pleasant Grove Parade")
parade1.set_start_date("10/01/2015")
parade1.set_end_date("10/31/2016")
parade1.set_state("Utah")
parade1.set_city("PG")
parade1.set_notes("Hello world")

parade2 = Parade.new
parade2.set_parade_name("Salt Lake Parade")
parade2.set_start_date("10/15/2015")
parade2.set_end_date("11/24/2016")
parade2.set_state("Utah")
parade2.set_city("SLC")
parade2.set_notes("Hello world, I am the second package")

### Create Parade
parade1 = worker.interact_with_parade('c',parade1)
parade2 = worker.interact_with_parade('c',parade2)

### Update a Parade
parade2.set_notes("These are the updated notes for package 2")
worker.interact_with_parade('u',parade2)

### Delete a Parade
worker.interact_with_parade('D',parade2)

### List Parade
temp = worker.interact_with_parade('l')

### Recreate a Parade
parade2 = Parade.new
parade2.set_parade_name("Salt Lake Parade")
parade2.set_start_date("10/15/2015")
parade2.set_end_date("11/24/2016")
parade2.set_state("Utah")
parade2.set_city("SLC")
parade2.set_notes("Hello world, I am the second package")
parade2 = worker.interact_with_parade('c',parade2)

### Read a Parade
temp = worker.interact_with_parade('R',parade1)

### List Parade
temp = worker.interact_with_parade('l')

## Home

home1 = Home.new
home1.set_city("Salt Lake City")
home1.set_state("UT")
home1.set_builder(build_person1)
home1.set_notes("THis is a home that has all the examples")
home1.set_home_address("10256 n 489 e")
home1.set_home_name("Candle Home 1")
home1.set_parade(parade1)

home2 = Home.new
home2.set_city("Salt Lake City")
home2.set_state("UT")
home2.set_home_name("Candle Home 2")
home2.set_notes("This is the second set of notes")

### Create Home
home1 = worker.interact_with_home('c',home1)
home2 = worker.interact_with_home('c',home2)

temp = worker.interact_with_home('l')

### Read a Home
temp = worker.interact_with_home('R',home1)

### Update a Home
home2.set_builder(build_person1)
worker.interact_with_home('u',home2)

build_person1.set_email("1234123512341234")
# home2.set_builder(build_person1)
home2.set_notes("These are the test notes to see the two changes")
worker.interact_with_home('U',home2)

# Create a new parade and then assign it to home2
parade3 = Parade.new
parade3.set_parade_name("Kaysville")
# parade3 = worker.interact_with_parade('C',parade3)
home2.set_parade(parade3)
worker.interact_with_home('U',home2)

home1.set_builder("empty")
worker.interact_with_home('u',home1)


### List Home
temp = worker.interact_with_home('l')


### Delete a Home
worker.interact_with_home('D',home1)

### List Home
temp = worker.interact_with_home('l')

### Recreate a Home
home1 = Home.new
home1.set_city("Salt Lake City")
home1.set_state("UT")
home1.set_builder(build_person1)
home1.set_notes("THis is a home that has all the examples")
home1.set_home_address("10256 n 489 e")
home1.set_home_name("Candle Home 1")
home1.set_parade(parade1)
home1 = worker.interact_with_home('c',home1)

### Read a Home
temp = worker.interact_with_home('R',home1)

### List Home
temp = worker.interact_with_home('l')

home2.set_parade("empty")
worker.interact_with_home('U',home2)

print 'here'