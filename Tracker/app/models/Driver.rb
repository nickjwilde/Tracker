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
worker.create_home_table
worker.create_package_table

person = Builder.new

person.set_name_of_builder("Bob the Builder")
person.set_phone_number("1-801-555-5555")

person2 = Builder.new

person2.set_name_of_builder("Beth")
person2.set_phone_number("1-123-123-1234")

choice = 'C'
person = worker.interact_with_builder(choice,person)

person2 = worker.interact_with_builder(choice,person2)

person3 = Builder.new
person3.set_builder_id("1")

temp = worker.interact_with_builder('r',person2)

temp2 = worker.interact_with_builder('r',person3)

person2.set_name_of_builder("Beth Woolston")

worker.interact_with_builder('u',person2)

temp = worker.interact_with_builder("L")

print temp

photo_person = Photographer.new

photo_person.set_name("Wild Bill")
photo_person.set_email("12345$hotmail.com")

first_package = Package.new("temp","10","none",photo_person)

hippy = first_package.get_photographer

print (hippy.get_name())


temp = worker.interact_with_builder("L")

photo_person = worker.interact_with_photographer('C',photo_person)

first_package = worker.interact_with_package('C',first_package)

second_package = Package.new

second_package.set_num_of_photos('15')

second_package = worker.interact_with_package('C',second_package)

temp = worker.interact_with_package('R',second_package)

temp = worker.interact_with_package('L')

first_package.set_notes("This is the test for the change")

worker.interact_with_package('U',first_package)

photo_person2 = Photographer.new
photo_person2.set_name("Photy")
photo_person2.set_notes("This person is a terrible photo person")

second_package.set_photographer(photo_person2)

worker.interact_with_package('U',second_package)

photo_person3 = Photographer.new
photo_person3.set_name("Rose")
photo_person3.set_notes("This person is better then Photoy and has replaced him")


second_package.set_photographer(photo_person3)

worker.interact_with_package('U',second_package)

second_package.set_photographer(photo_person)
second_package.set_notes("3rd person")

worker.interact_with_package('U',second_package)

second_package.set_photographer("empty")

worker.interact_with_package('U',second_package)

salt_lake = Parade.new

salt_lake.set_parade_name("Salt Lake Fall Parade")
salt_lake.set_start_date("10/24/2012")
salt_lake.set_end_date("11/01/2012")

salt_lake = worker.interact_with_parade('C',salt_lake)

temp = worker.interact_with_parade('r',salt_lake)

pleasent_grove = Parade.new

pleasent_grove.set_parade_name("Pleasant Grove")
pleasent_grove.set_notes("Test Notes")
pleasent_grove.set_start_date("11/12/12")
pleasent_grove.set_end_date("12/01/2015")

pleasent_grove = worker.interact_with_parade('C',pleasent_grove)

temp = worker.interact_with_parade('L')

print(first_package)




print 'here'
