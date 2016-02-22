require_relative 'Builder.rb'
require_relative 'Photographer.rb'
require_relative '../models/package.rb'
require 'pg'
require'../models/factory.rb'



person = Builder.new



#begin

# conn = PG::Connection.open(:dbname => 'postgres',:user =>'postgres', :password =>'B$t1m3RUN50uT')
# temp = person.get_phone_number.to_s
# conn.exec("INSERT INTO Builder (nameofbuilder,phoneNumber) VALUES($1,$2)",[person.get_name_of_builder,temp])
#
#   rs = conn.exec("SELECT * FROM Builder")
#
#   rs.each do |row|
#     puts "%s %s %s" % [ row['id'], row['name'], row['phoneNumber'] ]
#   end
#
# rescue PG::Error => e
#
# puts e.message
#
# ensure
#
#   conn.close if conn
#
# end


person.set_name_of_builder("Bob the Builder")
person.set_phone_number("1-801-555-5555")

person2 = Builder.new

person2.set_name_of_builder("Beth")
person2.set_phone_number("1-123-123-1234")

stringArrayTest = Array.new(3)

stringArrayTest[0] = person.get_builder_id
stringArrayTest[1] = person.get_name_of_builder
stringArrayTest[2] = person.get_phone_number

worker = Factory.new

pw = 'B$t1m3RUN50uT'

worker.connect_to_db(pw)

worker.create_builder_table
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

worker.create_photographer_table

worker.create_package_table
photo_person = Photographer.new

photo_person.set_name("Wild Bill")
photo_person.set_email("12345$hotmail.com")

first_package = Package.new("temp","10","none",photo_person)

hippy = first_package.get_photographer

print (hippy.get_name())


temp = worker.interact_with_builder("L")



photo_person = worker.interact_with_photographer('C',photo_person)

first_package = worker.interact_with_package('C',first_package)

print(first_package)

print 'here'
