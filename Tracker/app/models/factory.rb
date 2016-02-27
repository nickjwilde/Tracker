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
    @conn.exec("ALTER TABLE Home DROP CONSTRAINT home_builder_id_fkey")
    @conn.exec("DROP TABLE IF EXISTS Builder")

    @conn.exec ("CREATE TABLE Builder(
                    builder_id		        SERIAL 		      PRIMARY KEY
                    , name_of_builder		  VARCHAR(100)	                                      NOT NULL
                    , phone_number		    VARCHAR(14)
                    , email_address       VARCHAR(100)
                    , time_stamp          TIMESTAMP        DEFAULT      current_timestamp     NOT NULL
             );")
  end

  def interact_with_builder(choice,object="empty")
    choice = choice.upcase
    case choice
      when 'C'
        results = Array.new
        @conn.exec("INSERT INTO Builder (name_of_builder,phone_number,email_address) VALUES($1,$2,$3)",[object.get_name_of_builder,object.get_phone_number,object.get_email])
        results = @conn.exec("SELECT MAX(builder_id) FROM Builder")
        object.set_builder_id(results.getvalue 0,0)
        results = nil
        return object
      when 'R'
        results = Array.new
        results = @conn.exec("SELECT * FROM Builder WHERE builder_id=$1",[object.get_builder_id])
        object.set_name_of_builder(results.getvalue 0,1)
        object.set_phone_number(results.getvalue 0,2)
        object.set_email(results.getvalue 0,3)
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
        compare_value = results.getvalue 0,3
        if !compare_value.eql? object.get_email
          @conn.exec("UPDATE Builder SET email_address=$2 WHERE builder_id=$1",[object.get_builder_id,object.get_email])
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

  # Photographer section
  def create_photographer_table
    @conn.exec("DROP TABLE IF EXISTS Photographer")

    @conn.exec ("CREATE TABLE Photographer(
                    photographer_id		                SERIAL 		      PRIMARY KEY
                    , name_of_photographer		        VARCHAR(100)	                                      NOT NULL
                    , email_of_photographer           VARCHAR(100)
                    , phone_number_of_photographer		VARCHAR(14)
                    , notes_of_photographer           VARCHAR(1000)
                    , time_stamp                      TIMESTAMP        DEFAULT      current_timestamp     NOT NULL
             );")
  end

  def interact_with_photographer(choice,object = "empty")
    choice = choice.upcase
    case choice
      when 'C'
        results = Array.new
        @conn.exec("INSERT INTO Photographer (name_of_photographer,email_of_photographer,phone_number_of_photographer,notes_of_photographer) VALUES($1,$2,$3,$4)",[object.get_name,object.get_email,object.get_phone,object.get_notes])
        results = @conn.exec("SELECT MAX(photographer_id) FROM Photographer")
        object.set_photographer_id(results.getvalue 0,0)
        results = nil
        return object
      when 'D'
        @conn.exec("DELETE FROM Photographer WHERE photographer_id = $1",[object.get_photographer_id])
      when 'L'
        @feedBack = Array.new
        @conn.exec "SELECT photographer_id, name_of_photographer FROM Photographer" do |results|
          results.each do |row|
            object = Photographer.new
            object.set_photographer_id(row['photographer_id'])
            object.set_name(row['name_of_photographer'])
            @feedBack << object
          end
        end
        results = nil
        return @feedBack
      when 'R'
        results = Array.new
        results = @conn.exec("SELECT * FROM Photographer WHERE photographer_id=$1",[object.get_photographer_id])
        object.set_name(results.getvalue 0,1)
        object.set_email(results.getvalue 0,2)
        object.set_phone(results.getvalue 0,3)
        object.set_notes(results.getvalue 0,4)
        results = nil
        return object
      when 'U'
        results = Array.new
        results = @conn.exec("SELECT * FROM Photographer WHERE photographer_id=$1",[object.get_photographer_id])
        compare_value = results.getvalue 0,1
        if !compare_value.eql? object.get_name
          @conn.exec("UPDATE Photographer SET name_of_photographer=$2 WHERE photographer_id=$1",[object.get_photographer_id,object.get_name])
        end
        compare_value = results.getvalue 0,2
        if !compare_value.eql? object.get_email
          @conn.exec("UPDATE Photographer SET email_of_photographer=$2 WHERE photographer_id=$1",[object.get_photographer_id,object.get_email])
        end
        compare_value = results.getvalue 0,3
        if !compare_value.eql? object.get_phone
          @conn.exec("UPDATE Photographer SET phone_number_of_photographer=$2 WHERE photographer_id=$1",[object.get_photographer_id_id,object.get_phone])
        end
        compare_value = results.getvalue 0,4
        if !compare_value.eql? object.get_notes
          @conn.exec("UPDATE Photographer SET notes_of_photographer=$2 WHERE photographer_id=$1",[object.get_photographer_id_id,object.get_notes])
        end
        results = nil
      else
        return (@feedBack="Error")
    end
  end
  # Package area

  def create_package_table
    @conn.exec("DROP TABLE IF EXISTS Package")

    @conn.exec ("CREATE TABLE Package(
                    package_id		                    SERIAL 		      PRIMARY KEY
                    , number_of_photos                INTEGER
                    , notes_of_package                VARCHAR(10000)
                    , time_stamp                      TIMESTAMP        DEFAULT      current_timestamp     NOT NULL
             );")
  end

  def interact_with_package(choice,object="empty")
    choice = choice.upcase
    case choice
      when 'C'
        results = Array.new
        @conn.exec("INSERT INTO Package (number_of_photos,notes_of_package) VALUES($1,$2)",[object.get_num_of_photos,object.get_notes])
        results = @conn.exec("SELECT MAX(package_id) FROM Package")
        object.set_package_id(results.getvalue 0,0)
        results = nil
        return object
      when 'D'
        @conn.exec("DELETE FROM Package WHERE package_id = $1",[object.get_package_id])
      when 'L'
        @feedBack = Array.new
        @conn.exec("SELECT  package_id
                    FROM    Package" )do |results|
          results.each do |row|
            object = Package.new
            object.set_package_id(row['package_id'])
            object.set_notes(row['notes_of_package'])
            object.set_num_of_photos(row['number_of_photos'])
            @feedBack << object
          end
        end
        results = nil
        return @feedBack
      when 'R'
        results = Array.new
        results = @conn.exec("SELECT * FROM Package WHERE package_id=$1",[object.get_package_id])
        object.set_num_of_photos(results.getvalue 0,1)
        object.set_notes(results.getvalue 0,2)
        return object
      when 'U'
        results = Array.new
        results = @conn.exec("SELECT * FROM Package WHERE package_id=$1",[object.get_package_id])
        compare_value = results.getvalue 0,1
        if !compare_value.eql? object.get_num_of_photos
          @conn.exec("UPDATE Package SET number_of_photos=$2 WHERE package=$1",[object.get_package_id,object.get_num_of_photos])
        end
        compare_value = results.getvalue 0,2
        if !compare_value.eql? object.get_notes
          @conn.exec("UPDATE Package SET notes_of_package=$2 WHERE package_id=$1",[object.get_package_id,object.get_notes])
        end
        results = nil
      else
        return (@feedBack="Error")
    end
  end

  ## Parade area
  def create_parade_table
    @conn.exec("ALTER TABLE Home DROP CONSTRAINT home_parade_id_fkey")
    @conn.exec("DROP TABLE IF EXISTS Parade")

    @conn.exec ("CREATE TABLE Parade(
                    parade_id	                    SERIAL 		      PRIMARY KEY
                    , name_of_parade		          VARCHAR(1000)	                                      NOT NULL
                    , city_of_parade              VARCHAR(100)
                    , state_of_parade             VARCHAR(100)
                    , start_date_of_parade		    TIMESTAMP
                    , end_date_of_parade          TIMESTAMP
                    , parade_notes                VARCHAR(10000)
                    , time_stamp                  TIMESTAMP        DEFAULT      current_timestamp     NOT NULL
             );")

  end

  def interact_with_parade(choice,object="empty")
    choice = choice.upcase
    case choice
      when 'C'
        results = Array.new
        @conn.exec("INSERT INTO Parade (name_of_parade,city_of_parade,state_of_parade,start_date_of_parade,end_date_of_parade,parade_notes) VALUES($1,$2,$3,$4,$5,$6)",[object.get_parade_name,object.get_city,object.get_state,object.get_start_date,object.get_end_date,object.get_notes])
        results = @conn.exec("SELECT MAX(parade_id) FROM Parade")
        object.set_parade_id(results.getvalue 0,0)
        results = nil
        return object
      when 'D'
        @conn.exec("DELETE FROM Parade WHERE parade_id = $1",[object.get_parade_id])
      when 'R'
        results = Array.new
        results = @conn.exec("SELECT * FROM Parade WHERE parade_id=$1",[object.get_parade_id])
        object.set_parade_name(results.getvalue 0,1)
        object.set_city(results.getvalue 0,2)
        object.set_state(results.getvalue 0,3)
        object.set_start_date(results.getvalue 0,4)
        object.set_end_date(results.getvalue 0,5)
        object.set_notes(results.getvalue 0,6)
        results = nil
        return object
      when 'L'
        @feedBack = Array.new
        @conn.exec "SELECT parade_id, name_of_parade FROM Parade" do |results|
          results.each do |row|
            object = Parade.new
            object.set_parade_id(row['parade_id'])
            object.set_parade_name(row['name_of_parade'])
            @feedBack << object
          end
        end
        results = nil
        return @feedBack
      when 'U'
        results = Array.new
        results = @conn.exec("SELECT * FROM Parade WHERE parade_id=$1",[object.get_parade_id])
        compare_value = results.getvalue 0,1
        if !compare_value.eql? object.get_parade_name
          @conn.exec("UPDATE Parade SET name_of_parade=$2 WHERE parade_id=$1",[object.get_parade_id,object.get_parade_name])
        end
        compare_value = results.getvalue 0,2
        if !compare_value.eql? object.get_city
          @conn.exec("UPDATE Parade SET city_of_parade=$2 WHERE parade_id=$1",[object.get_parade_id,object.get_city])
        end
        compare_value = results.getvalue 0,3
        if !compare_value.eql? object.get_city
          @conn.exec("UPDATE Parade SET state_of_parade=$2 WHERE parade_id=$1",[object.get_parade_id,object.get_state])
        end
        compare_value = results.getvalue 0,4
        if !compare_value.eql? (object.get_start_date)
          @conn.exec("UPDATE Parade SET start_date_of_parade=$2 WHERE parade_id=$1",[object.get_parade_id,object.get_start_date])
        end
        compare_value = results.getvalue 0,5
        if !compare_value.eql? (object.get_end_date)
          @conn.exec("UPDATE Parade SET end_date_of_parade=$2 WHERE parade_id=$1",[object.get_parade_id,object.get_end_date])
        end
        compare_value = results.getvalue 0,6
        if !compare_value.eql? object.get_notes
          @conn.exec("UPDATE Parade SET parade_notes=$2 WHERE parade_id=$1",[object.get_parade_id,object.get_notes])
        end
      else
        return (@feedBack="Error")
    end
  end

  ## Home area
  def create_home_table
    @conn.exec("DROP TABLE IF EXISTS Home")

    # Need to add order id/Photographer
    @conn.exec ("CREATE TABLE Home(
                    home_id		                        SERIAL 		        PRIMARY KEY
                    , home_name     		              VARCHAR(100)
                    , home_address                    VARCHAR(100)
                    , city                            VARCHAR(100)
                    , state                           VARCHAR(100)
                    , notes                           VARCHAR(10000)
                    , parade_id                       INTEGER           REFERENCES      Parade(parade_id)
                    , builder_id                      INTEGER           REFERENCES      Builder(builder_id)
                    , time_stamp                      TIMESTAMP         DEFAULT         current_timestamp     NOT NULL
             );")
  end

  def interact_with_home(choice,object="empty")
    choice = choice.upcase
    case choice
      when 'C'
        results = Array.new
        # Check to see if builder is assigned
        if !object.get_builder.eql? "empty"
          # A builder has been assigned
          builder = Builder.new
          builder = object.get_builder
          builder_id = (builder.get_builder_id.to_i)

          # Check to see if builder has been added to the database already
          # The builder is in the system
          if builder_id != -1
            builder = interact_with_builder('U',builder)
          elsif builder_id == -1
            # The builder is not in the system
            builder = interact_with_builder('C',builder)
            builder_id = (builder.get_builder_id.to_i)
          end
        else
          # A builder has not been assigned
          builder_id = nil
        end

        # Check to see if parade has been assigned
        if !object.get_parade.eql? "empty"
          # A parade has been assigned
          parade = Parade.new
          parade = object.get_parade
          parade_id = (parade.get_parade_id.to_i)

          # Check to see if the parade has been added to the database
          # The parade is in the system
          if parade_id != -1
            parade = interact_with_parade('U',parade)
          else

            # The parade is not in the system
            parade = interact_with_parade('C',parade)
            parade_id = (parade.get_parade_id.to_i)
          end

          # A parade has not been assigned
        else
          parade_id = nil
        end

        @conn.exec("INSERT INTO Home (home_name,home_address,city,state,notes,parade_id,builder_id) VALUES($1,$2,$3,$4,$5,$6,$7)",[object.get_home_name,object.get_home_address,object.get_city,object.get_state,object.get_home_notes,parade_id,builder_id])
        results = @conn.exec("SELECT MAX(home_id) FROM Home")
        object.set_home_id(results.getvalue 0,0)
        results = nil
        return object
      # Delete a home based off of the id
      when 'D'
        @conn.exec("DELETE FROM Home WHERE home_id = $1",[object.get_home_id])
      when 'L'
        @feedBack = Array.new
        @conn.exec("SELECT  home_id, home_name, b.builder_id, name_of_builder, b.parade_id, name_of_parade
                    FROM    Home b
                                LEFT JOIN(SELECT *
                                          FROM    Builder
                                        ) a
                                        ON b.builder_id = a.builder_id
                                LEFT JOIN(
                                    SELECT *
                                    FROM    Parade
                                  ) c
                                  ON b.parade_id = c.parade_id" )do |results|
          results.each do |row|
            object = Home.new
            object.set_home_id(row['home_id'])
            object.set_home_name(row['home_name'])

            builder = Builder.new
            builder.set_builder_id(row['builder_id'])
            builder.set_name_of_builder(row['name_of_builder'])

            parade = Parade.new
            parade.set_parade_id(row['parade_id'])
            parade.set_parade_name(row['name_of_parade'])

            object.set_parade(parade)
            object.set_builder(builder)
            @feedBack << object
          end
        end
        results = nil
        return @feedBack
      # Here
      when 'R'
        results = Array.new
        results = @conn.exec("SELECT  *
                              FROM    Home
                              WHERE   home_id=$1",[object.get_home_id])
        object.set_home_id(results.getvalue 0,0)
        object.set_home_name(results.getvalue 0,1)
        object.set_home_address(results.getvalue 0,2)
        object.set_city(results.getvalue 0,3)
        object.set_state(results.getvalue 0,4)
        object.set_notes(results.getvalue 0,5)

        # Get parade associated with home
        compare_value = results.getvalue 0,6
        # If no parade has been assigned yet
        if compare_value.nil? | (compare_value.eql? "empty")
          object.set_parade("empty")
          # value has been assigned
        else
          parade_id = compare_value
          parade = Parade.new
          parade.set_parade_id(parade_id)
          parade = interact_with_parade('R',parade)
          object.set_parade(parade)
        end

        # Get builder associated with home
        compare_value = results.getvalue 0,7
        # if no builder has been assigned yet
        if compare_value.nil? |(compare_value.eql? "empty")
          object.set_builder("empty")
        else
          builder_id = compare_value
          builder = Builder.new
          builder.set_builder_id(builder_id)
          builder = interact_with_builder('R',builder)
          object.set_builder(builder)
        end
        results = nil
        return object
      when 'U'
        results = Array.new
        results = @conn.exec("SELECT * FROM Home WHERE home_id=$1",[object.get_home_id])
        compare_value = results.getvalue 0,1
        if !compare_value.eql? object.get_home_name
          @conn.exec("UPDATE Home SET home_name=$2 WHERE home_id=$1",[object.get_home_id,object.get_home_name])
        end
        compare_value = results.getvalue 0,2
        if !compare_value.eql? object.get_home_address
          @conn.exec("UPDATE Home SET home_address=$2 WHERE home_id=$1",[object.get_home_id,object.get_home_address])
        end
        compare_value = results.getvalue 0,3
        if !compare_value.eql? object.get_city
          @conn.exec("UPDATE Home SET city=$2 WHERE home_id=$1",[object.get_home_id,object.get_city])
        end
        compare_value = results.getvalue 0,4
        if !compare_value.eql? object.get_state
          @conn.exec("UPDATE Home SET state=$2 WHERE home_id=$1",[object.get_home_id,object.get_state])
        end
        compare_value = results.getvalue 0,5
        if !compare_value.eql? object.get_notes
          @conn.exec("UPDATE Home SET notes=$2 WHERE home_id=$1",[object.get_home_id,object.get_notes])
        end
        compare_value = results.getvalue 0,6
        if object.get_parade.eql? "empty"
          if !compare_value.nil?
            parade_id = nil
          end
        elsif !object.get_parade.eql? "empty"
          parade = Parade.new
          parade = object.get_parade
          parade_id = parade.get_parade_id.to_i

          if parade_id != -1
            parade = interact_with_parade('u',parade)
          elsif parade_id == -1
            parade = interact_with_parade('c',parade)
            parade_id = parade.get_parade_id.to_i
          end
        end
        if compare_value.to_i != parade_id
          @conn.exec("UPDATE Home SET parade_id=$2 WHERE home_id=$1",[object.get_home_id,parade_id])
        end
        compare_value = results.getvalue 0,7
        if object.get_builder.eql? "empty"
          if !compare_value.nil?
            builder_id = nil
          end
        elsif !object.get_builder.eql? "empty"
          builder = Builder.new
          builder = object.get_builder
          builder_id = builder.get_builder_id.to_i

          if builder_id != -1
            builder = interact_with_builder('u',builder)
          elsif builder_id == -1
            builder = interact_with_builder('c',builder)
            builder_id = parade.get_builder_id.to_i
          end
        end
        if compare_value.to_i != builder_id
          @conn.exec("UPDATE Home SET builder_id=$2 WHERE home_id=$1",[object.get_home_id,builder_id])
        end
      else
        return (@feedBack="Error")
    end
  end

  ## Order Area
end