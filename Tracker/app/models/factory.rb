require 'pg'

class Factory

  # Overall connection to db done here
  def initialize
    @conn =""
    @feedBack =""
  end

  def connect_to_db(pw)
    @conn = PG::Connection.open(:dbname => 'postgres',:user =>'postgres', :password =>pw)
  end

  # Builder Table information
  def create_builder_table
    @conn.exec("DROP TABLE IF EXISTS Builder")

    @conn.exec ("CREATE TABLE Builder(
                    builder_id		SERIAL 		PRIMARY KEY
                    , name_of_builder		VARCHAR(100)	NOT NULL
                    , phone_number		VARCHAR(14)
             );")
  end

  def interact_with_builder(choice,object="empty")
    choice = choice.upcase
    case choice
      when 'C'
        results = Array.new
        @conn.exec("INSERT INTO Builder (name_of_builder,phone_number) VALUES($1,$2)",[object.get_name_of_builder,object.get_phone_number])
        results = @conn.exec("SELECT builder_id FROM Builder WHERE name_of_builder=$1 AND phone_number=$2",[object.get_name_of_builder,object.get_phone_number])
        object.set_builder_id(results.getvalue 0,0)
        results = nil
        return object
      when 'R'
        results = Array.new
        results = @conn.exec("SELECT * FROM Builder WHERE builder_id=$1",[object.get_builder_id])
        object.set_name_of_builder(results.getvalue 0,1)
        object.set_phone_number(results.getvalue 0,2)
        results = nil
        return object
      when 'U'
        results = Array.new
        results = @conn.exec("SELECT * FROM Builder WHERE builder_id=$1",[object.get_builder_id])
        compare_value = results.getvalue 0,1
        if !compare_value.eql? object.get_name_of_builder
          @conn.exec("UPDATE Builder SET name_of_builder=$2 WHERE builder_id=$1",[object.get_builder_id,object.get_name_of_builder])
        end
        compare_value = results.getvalue 0,2
        if !compare_value.eql? object.get_phone_number
          @conn.exec("UPDATE Builder SET phone_number=$2 WHERE builder_id=$1",[object.get_builder_id,object.get_phone_number])
        end
        results = nil
      when 'D'
          @conn.exec("DELETE FROM Builder WHERE builder_id = $1",[object.get_builder_id])
      when 'L'
        @feedBack = Array.new
        @conn.exec "SELECT builder_id, name_of_builder FROM Builder" do |results|
          results.each do |row|
              object = Builder.new
              object.set_builder_id(row['builder_id'])
              object.set_name_of_builder(row['name_of_builder'])
              @feedBack << object
            end
        end
        results = nil
        return @feedBack
      else
        return (@feedBack="Error")
    end
  end

  def create_photographer_table
    @conn.exec("DROP TABLE IF EXISTS Photographer")

    @conn.exec ("CREATE TABLE Photographer(
                    photographer_id		                SERIAL 		PRIMARY KEY
                    , name_of_photographer		        VARCHAR(100)	NOT NULL
                    , email_of_photographer           VARCHAR(100)
                    , phone_number_of_photographer		VARCHAR(14)
                    , notes_of_photographer           VARCHAR(1000)
             );")
  end

  def interact_with_photographer(choice,object = "empty")
    choice = toupper(choice)
    case choice
      when 'C'
        results = Array.new
        @conn.exec("INSERT INTO Builder (name_of_photographer,email_of_photographer,phone_number_of_photographer,notes_of_photographer) VALUES($1,$2,$3,$4,$5)",[object.get_name,object.get_email,object.get_phone,object.get_notes])
        results = @conn.exec("SELECT photographer_id FROM Photographer WHERE name_of_photographer=$1 AND phone_number_of_photographer=$2",[object.get_name,object.get_number])
        object.set_builder_id(results.getvalue 0,0)
        results = nil
        return object
      when 'D'
        @conn.exec("DELETE FROM Photographer WHERE photographer_id = $1",[object.get_photographer_id])
      else
        return (@feedBack="Error")
    end
  end

end