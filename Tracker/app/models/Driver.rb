# External Files
require 'pg'

# Internal Files
require '../models/builder.rb'
require '../models/Photographer.rb'
require '../models/package.rb'
require '../models/factory.rb'
require '../models/parade.rb'
require '../models/order.rb'
require '../models/home.rb'


worker = Factory.new
# This should be your password, utilize this
pw = "Ln53gi8N"
user_name = "nick"
database = "postgres"

worker.connect_to_db(user_name, pw, database)

## Create Tables
worker.create_builder_table
worker.create_photographer_table
worker.create_parade_table
worker.create_package_table
worker.create_order_table


### dependency tables
worker.create_home_table
#worker.create_order_table

# Creating testing people
## Builder
build_person1 = Builder.new
build_person1.set_name_of_builder("Bob the builder")
build_person1.set_phone_number("1-801-375-5555")
build_person1.set_email("1234@asdf.com")
build_person1.set_contact("Tommy Thorn")

build_person2 = Builder.new
build_person2.set_name_of_builder("Dora wonder")
build_person2.set_phone_number("1-597-589-5698")
build_person2.set_email("asdfasd@234")

### Create Builders
build_person1 = worker.interact_with_builder('c',build_person1)
build_person2 = worker.interact_with_builder('c',build_person2)

### Update a Builder
build_person2.set_email("aaaaaaaaaaaaaaaa")
build_person2.set_contact("Crowy conner")
worker.interact_with_builder('u',build_person2)

### Delete a Builder
worker.interact_with_builder('D',build_person2)

### List Builders
temp = worker.interact_with_builder('l')

### Recreate a builder
build_person2 = Builder.new
build_person2.set_name_of_builder("Dora wonder")
build_person2.set_phone_number("1-597-589-5698")
build_person2.set_email("aaaaaaaaaaaaaaaa")
build_person2.set_contact("Crowy conner Two")
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
photo_person1.set_swag("Y")

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
photo_person2.set_swag("Y")
worker.interact_with_photographer('u',photo_person2)

### Delete a Photographer
worker.interact_with_photographer('D',photo_person2)

### List Photographer
temp = worker.interact_with_photographer('l')

### Recreate a Photographer
photo_person2 = Photographer.new
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
parade2.set_notes("Hello world, I am the second parade")


parade3 = Parade.new
parade3.set_parade_name("Utah County Parade")
parade3.set_start_date("12/14/2016")
parade3.set_end_date("12/20/2016")
parade3.set_state("Utah")
parade3.set_city("Highland")
parade3.set_notes("Hello world, I am the third parade")

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


## Create Order
### Create order with all fields filled
order1 = Order.new
order1.set_photo_received("Y")
order1.set_received_date("12/14/1988")
order1.set_photos_usable(30)
order1.set_notes("These are the notes for order 1")
order1.set_photos_approved_date("01/01/2016")
order1.set_photographer_paid("Y")
order1.set_photographer_paid_date("01/05/2106")
order1.set_initial_client_upload("Y")
order1.set_initial_client_upload_date("01/06/2016")
order1.set_sent_to_philippines("Y")
order1.set_sent_to_philippines_date("01/10/2016")
order1.set_approve_philippines("Y")
order1.set_approve_philippines_date("01/11/2016")
order1.set_cropping("Y")
order1.set_cropping_date("01/12/2016")
order1.set_final_client_upload("Y")
order1.set_final_client_upload_date("01/16/2016")
order1.set_verify_photo_replacement("Y")
order1.set_verify_photo_replacement_date("01/17/2016")
order1.set_home(home1)
order1.set_photographer(photo_person1)
order1.set_package(package1)

order1 = worker.interact_with_order('C',order1)

### Order number two has all new members that will need to be created
### Build Person
build_person3 = Builder.new
build_person3.set_name_of_builder("Zooey buildings")
build_person3.set_phone_number("1-597-589-1111")
build_person3.set_email("asdf97868765764@234")

### New parade that needs to be created
parade3 = Parade.new
parade3.set_parade_name("Saint George")
parade3.set_start_date("12/31/2015")
parade3.set_end_date("10/12/2016")
parade3.set_state("Utah")
parade3.set_city("St. Goerge")
parade3.set_notes("Hello world I am parade 3")

### New home that needs to be created
home3 = Home.new
home3.set_city("Salt Lake City")
home3.set_state("UT")
home3.set_builder(build_person3)
home3.set_notes("THis is a home that has all the examples")
home3.set_home_address("10256 n 489 e")
home3.set_home_name("Candle Home 1")
home3.set_parade(parade3)

### New package that needs to be created
package3 = Package.new
package3.set_num_of_photos("90")
package3.set_notes("This is the notes about package three")

### New photographer that needs to be created
photo_person3 = Photographer.new
photo_person3.set_name("Billy Bobs Photographer")
photo_person3.set_phone("1-555-101-1010")
photo_person3.set_email("a@IamTheBest.com")
photo_person3.set_notes("This person is really odd")


order2 = Order.new
order2.set_photo_received("N")
order2.set_received_date(nil)
order2.set_photos_usable(30)
order2.set_notes("These are the notes for order 2")
order2.set_photos_approved_date(nil)
order2.set_photographer_paid("N")
order2.set_photographer_paid_date(nil)
order2.set_initial_client_upload("N")
order2.set_initial_client_upload_date(nil)
order2.set_sent_to_philippines("N")
order2.set_sent_to_philippines_date(nil)
order2.set_approve_philippines("N")
order2.set_approve_philippines_date(nil)
order2.set_cropping("N")
order2.set_cropping_date(nil)
order2.set_final_client_upload("N")
order2.set_final_client_upload_date(nil)
order2.set_verify_photo_replacement("N")
order2.set_verify_photo_replacement_date(nil)
order2.set_home(home3)
order2.set_photographer(photo_person3)
order2.set_package(package3)

order2 = worker.interact_with_order('C',order2)

## Order 3 has empty everything and will be updated later
order3 = Order.new
order3.set_photo_received("N")
order3.set_received_date(nil)
order3.set_photos_usable(30)
order3.set_notes("These are the notes for order 3")
order3.set_photos_approved_date(nil)
order3.set_photographer_paid("N")
order3.set_photographer_paid_date(nil)
order3.set_initial_client_upload("N")
order3.set_initial_client_upload_date(nil)
order3.set_sent_to_philippines("N")
order3.set_sent_to_philippines_date(nil)
order3.set_approve_philippines("N")
order3.set_approve_philippines_date(nil)
order3.set_cropping("N")
order3.set_cropping_date(nil)
order3.set_final_client_upload("N")
order3.set_final_client_upload_date(nil)
order3.set_verify_photo_replacement("N")
order3.set_verify_photo_replacement_date(nil)
# Did not set home/Photographer/package on purpose

order3 = worker.interact_with_order('C',order3)


## List all orders in the database and return basic attributes
temp = worker.interact_with_order('L')

## Read a specific Order
orderTemp = Order.new
orderTemp.set_order_id(1)

orderTemp = worker.interact_with_order('R',orderTemp)

order3.set_photo_received("Y")
order3.set_received_date("01/21/2015")
order3.set_photos_usable(15)
order3.set_notes("These are the notes for order 3, UPDATED")
order3.set_photos_approved_date("12/15/2015")
order3.set_photographer_paid("Y")
order3.set_photographer_paid_date("07/28/2015")
order3.set_initial_client_upload("Y")
order3.set_initial_client_upload_date("09/08/2017")
order3.set_sent_to_philippines("Y")
order3.set_sent_to_philippines_date("08/07/1956")
order3.set_approve_philippines("Y")
order3.set_approve_philippines_date("06/02/1987")
order3.set_cropping("Y")
order3.set_cropping_date("12/12/2016")
order3.set_final_client_upload("Y")
order3.set_final_client_upload_date("08/08/1598")
order3.set_verify_photo_replacement("Y")
order3.set_verify_photo_replacement_date("07/07/2016")

worker.interact_with_order('U',order3)

order3.set_home(home1)
order3.set_photographer(photo_person2)
order3.set_package(package2)


worker.interact_with_order('U',order3)


### Build Person
build_person4 = Builder.new
build_person4.set_name_of_builder("Build Person 4")
build_person4.set_phone_number("1-597-666-1111")
build_person4.set_email("66666@234")

### New parade that needs to be created
parade4 = Parade.new
parade4.set_parade_name("Cedar CIty")
parade4.set_start_date("12/17/2222")
parade4.set_end_date("12/31/2223")
parade4.set_state("Utah")
parade4.set_city("Cedar CIty")
parade4.set_notes("Hello world, I am parade 4")

### New home that needs to be created
home4 = Home.new
home4.set_city("Cedar City")
home4.set_state("UT")
home4.set_builder(build_person4)
home4.set_notes("THis is a home that has all the examples, this is home 4")
home4.set_home_address("10256 n 14587562 E")
home4.set_home_name("Candle Home 72")
home4.set_parade(parade4)

### New package that needs to be created
package4 = Package.new
package4.set_num_of_photos("0")
package4.set_notes("This is the notes about package four")

### New photographer that needs to be created
photo_person4 = Photographer.new
photo_person4.set_name("Rosy Frost")
photo_person4.set_phone("1-555-891-1010")
photo_person4.set_email("a@IamTheBestAndBetter.com")
photo_person4.set_notes("This person should not be used")

order2.set_home(home4)
order2.set_photographer(photo_person4)
order2.set_package(package4)


worker.interact_with_order('U',order2)



# Getting all orders from a single parade, Parade_id =1 is out example as it has two orders associated with it
results = Array.new
paradeTemp = Parade.new
paradeTemp.set_parade_id(1)

results = worker.list_all_orders_for_parade(paradeTemp)

# Access the results
results.each do |value|
  orderTemp = Order.new
  orderTemp = value
end
