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
    # @conn.exec("ALTER TABLE Home DROP CONSTRAINT home_builder_id_fkey")
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
    # @conn.exec("ALTER TABLE Home DROP CONSTRAINT home_parade_id_fkey")
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


    @conn.exec ("CREATE TABLE Home(
                    home_id		                        SERIAL 		        PRIMARY KEY
                    , home_name     		              VARCHAR(100)
                    , home_address                    VARCHAR(100)
                    , city                            VARCHAR(100)
                    , state                           VARCHAR(100)
                    , notes                           VARCHAR(10000)
                    , parade_id                       INTEGER
                    , builder_id                      INTEGER
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
  def create_order_table
    @conn.exec("DROP TABLE IF EXISTS Order_table")

    @conn.exec ("CREATE TABLE Order_table(
                    order_id		                      SERIAL 		        PRIMARY KEY
                    , photos_received	                VARCHAR(2)
                    , photos_recieved_date            TIMESTAMP
                    , photos_usable                   INTEGER
                    , photo_notes                     VARCHAR(10000)
                    , photos_approved_date            TIMESTAMP
                    , photographer_paid               VARCHAR(2)
                    , photographer_paid_date          TIMESTAMP
                    , initial_client_upload           VARCHAR(2)
                    , initial_client_upload_date      TIMESTAMP
                    , sent_to_philippines            VARCHAR(2)
                    , sent_to_philippines_date        TIMESTAMP
                    , approve_philippines            VARCHAR(2)
                    , approve_philippines_date        TIMESTAMP
                    , cropping                        VARCHAR(2)
                    , cropping_date                   TIMESTAMP
                    , final_client_upload             VARCHAR(2)
                    , final_client_upload_date        TIMESTAMP
                    , verify_photo_replacement        VARCHAR(2)
                    , verify_photo_replacement_date   TIMESTAMP
                    , home_id                         INTEGER
                    , photographer_id                 INTEGER
                    , package_id                      INTEGER
                    , time_stamp                      TIMESTAMP         DEFAULT         current_timestamp     NOT NULL
             );")
  end

  def interact_with_order(choice,object="empty")
    choice = choice.upcase
    case choice
      when 'C'
        results = Array.new
        # Check to see if Home is assigned
        if !object.get_home.eql? "empty"
          # A builder has been assigned
          home = Home.new
          home = object.get_home
          home_id = (home.get_home_id.to_i)

          # Check to see if Home has been added to the database already
          # The Home is in the system
          if home_id != -1
            home = interact_with_home('U',home)
          elsif home_id == -1
            # The Home is not in the system
            home = interact_with_home('C',home)
            home_id = (home.get_home_id.to_i)
          end
        else
          # A home has not been assigned
          home_id = nil
        end
        # Check to see if Photographer has been assigned
        if !object.get_photographer.eql? "empty"
          # A Photographer has been assigned
          photographer = Photographer.new
          photographer = object.get_photographer
          photographer_id = (photographer.get_photographer_id.to_i)

          # Check to see if the Photographer has been added to the database
          # The Photographer is in the system
          if photographer_id != -1
            photographer = interact_with_photographer('U',photographer)
          else
            # The photographer is not in the system
            photographer = interact_with_photographer('C',photographer)
            photographer_id = (photographer.get_photographer_id.to_i)
          end
          # A Photographer has not been assigned
        else
          photographer_id = nil
        end
        # Check to see if Package has been assigned
        if !object.get_package.eql? "empty"
          # A Package has been assigned
          package = Package.new
          package = object.get_package
          package_id = (package.get_package_id.to_i)

          # Check to see if the Package has been added to the database
          # The Package is in the system
          if package_id != -1
            package = interact_with_package('U',package)
          else
            # The Package is not in the system
            package = interact_with_package('C',package)
            package_id = (package.get_package_id.to_i)
          end
          # A Package has not been assigned
        else
          package_id = nil
        end

        @conn.exec("INSERT INTO Order_table (photos_received,photos_recieved_date,photos_usable,photo_notes,photos_approved_date,photographer_paid,photographer_paid_date,initial_client_upload,initial_client_upload_date,sent_to_philippines,sent_to_philippines_date,approve_philippines,approve_philippines_date,cropping,cropping_date,final_client_upload,final_client_upload_date,verify_photo_replacement,verify_photo_replacement_date,home_id,photographer_id,package_id) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22)",[object.get_photos_received,object.get_received_date,object.get_photos_usable,object.get_notes,object.get_photos_approved_date,object.get_photographer_paid,object.get_photographer_paid_date,object.get_initial_client_upload,object.get_initial_client_upload_date,object.get_sent_to_philippines,object.get_sent_to_philippines_date,object.get_approve_philippines,object.get_approve_philippines_date,object.get_cropping,object.get_cropping_date,object.get_final_client_upload,object.get_final_client_upload_date,object.get_verify_photo_replacement,object.get_verify_photo_replacement_date,home_id,photographer_id,package_id])
        results = @conn.exec("SELECT MAX(order_id) FROM Order_table")
        object.set_order_id(results.getvalue 0,0)
        results = nil
        return object
      # Delete a Order based off of the id
      when 'D'
        @conn.exec("DELETE FROM Order_table WHERE order_id = $1",[object.get_order_id])
      when 'L'
        @feedBack = Array.new
        @conn.exec("SELECT  order_id, home_name, a.home_id, name_of_parade, b.parade_id, name_of_photographer, a.photographer_id, a.package_id
                    FROM    Order_table a
                                LEFT JOIN(SELECT *
                                          FROM    Home
                                        ) b
                                        ON a.home_id = b.home_id
                                LEFT JOIN(SELECT *
                                          FROM    Parade
                                        ) c
                                        ON b.parade_id = c.parade_id
                                LEFT JOIN(SELECT *
                                          FROM    Package
                                        ) d
                                        ON a.package_id = d.package_id
                                LEFT JOIN(
                                    SELECT *
                                    FROM    Photographer
                                  ) e
                                  ON a.photographer_id = e.photographer_id" )do |results|
          results.each do |row|
            object = Order.new
            object.set_order_id(row['order_id'])

            home = Home.new
            home.set_home_id(row['home_id'])
            home.set_home_name(row['home_name'])

            photographer = Photographer.new
            photographer.set_photographer_id(row['photographer_id'])
            photographer.set_name(row['name_of_photographer'])

            parade = Parade.new
            parade.set_parade_id(row['parade_id'])
            parade.set_parade_name(row['name_of_parade'])

            package = Package.new
            package.set_package_id(row['package_id'])

            home.set_parade(parade)

            object.set_home(home)
            object.set_photographer(photographer)
            object.set_package(package)
            @feedBack << object
          end
        end
        results = nil
        return @feedBack
      when 'R'
        results = Array.new
        results = @conn.exec("SELECT  *
                              FROM    Order_table
                              WHERE   order_id=$1",[object.get_order_id])
        object.set_order_id(results.getvalue 0,0)
        object.set_photo_received(results.getvalue 0,1)
        object.set_received_date(results.getvalue 0,2)
        object.set_photos_usable(results.getvalue 0,3)
        object.set_notes(results.getvalue 0,4)
        object.set_photos_approved_date(results.getvalue 0,5)
        object.set_photographer_paid(results.getvalue 0,6)
        object.set_photographer_paid_date(results.getvalue 0,7)
        object.set_initial_client_upload(results.getvalue 0,8)
        object.set_initial_client_upload_date(results.getvalue 0,9)
        object.set_sent_to_philippines(results.getvalue 0,10)
        object.set_sent_to_philippines_date(results.getvalue 0,11)
        object.set_approve_philippines(results.getvalue 0,12)
        object.set_approve_philippines_date(results.getvalue 0,13)
        object.set_cropping(results.getvalue 0,14)
        object.set_cropping_date(results.getvalue 0,15)
        object.set_final_client_upload(results.getvalue 0,16)
        object.set_final_client_upload_date(results.getvalue 0,17)
        object.set_verify_photo_replacement(results.getvalue 0,18)
        object.set_verify_photo_replacement_date(results.getvalue 0,19)

        # Get home associated with order
        compare_value = results.getvalue 0,20
        # If no home has been assigned yet
        if compare_value.nil? | (compare_value.eql? "empty")
          object.set_home("empty")
          # value has been assigned
        else
          home_id = compare_value
          home = Home.new
          home.set_home_id(home_id)
          home = interact_with_home('R',home)
          object.set_home(home)
        end

        # Get Photographer associated with order
        compare_value = results.getvalue 0,21
        # if no order has been assigned yet
        if compare_value.nil? |(compare_value.eql? "empty")
          object.set_photographer("empty")
        else
          photographer_id = compare_value
          photographer = Photographer.new
          photographer.set_photographer_id(photographer_id)
          photographer = interact_with_photographer('R',photographer)
          object.set_photographer(photographer)
        end

        # Get Package associated with order
        compare_value = results.getvalue 0,22
        # if no order has been assigned yet
        if compare_value.nil? |(compare_value.eql? "empty")
          object.set_package("empty")
        else
          package_id = compare_value
          package = Package.new
          package.set_package_id(package_id)
          package = interact_with_package('R',package)
          object.set_package(package)
        end
        results = nil
        return object
      when 'U'
        results = Array.new
        results = @conn.exec("SELECT * FROM Order_table WHERE order_id=$1",[object.get_order_id])
        compare_value = results.getvalue 0,1
        if !compare_value.eql? object.get_photos_received
          @conn.exec("UPDATE Order_table SET photos_received=$2 WHERE order_id=$1",[object.get_order_id,object.get_photos_received])
        end
        compare_value = results.getvalue 0,2
        if !compare_value.eql? object.get_received_date
          @conn.exec("UPDATE Order_table SET photos_recieved_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_received_date])
        end
        compare_value = results.getvalue 0,3
        if !compare_value.eql? object.get_photos_usable
          @conn.exec("UPDATE Order_table SET photos_usable=$2 WHERE order_id=$1",[object.get_order_id,object.get_photos_usable])
        end
        compare_value = results.getvalue 0,4
        if !compare_value.eql? object.get_notes
          @conn.exec("UPDATE Order_table SET photo_notes=$2 WHERE order_id=$1",[object.get_order_id,object.get_notes])
        end
        compare_value = results.getvalue 0,5
        if !compare_value.eql? object.get_photos_approved_date
          @conn.exec("UPDATE Order_table SET photos_approved_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_photos_approved_date])
        end
        compare_value = results.getvalue 0,6
        if !compare_value.eql? object.get_photographer_paid
          @conn.exec("UPDATE Order_table SET photographer_paid=$2 WHERE order_id=$1",[object.get_order_id,object.get_photographer_paid])
        end
        compare_value = results.getvalue 0,7
        if !compare_value.eql? object.get_photographer_paid_date
          @conn.exec("UPDATE Order_table SET photographer_paid_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_photographer_paid_date])
        end
        compare_value = results.getvalue 0,8
        if !compare_value.eql? object.get_initial_client_upload
          @conn.exec("UPDATE Order_table SET initial_client_upload=$2 WHERE order_id=$1",[object.get_order_id,object.get_initial_client_upload])
        end
        compare_value = results.getvalue 0,9
        if !compare_value.eql? object.get_initial_client_upload_date
          @conn.exec("UPDATE Order_table SET initial_client_upload_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_initial_client_upload_date])
        end
        compare_value = results.getvalue 0,10
        if !compare_value.eql? object.get_sent_to_philippines
          @conn.exec("UPDATE Order_table SET sent_to_philippines=$2 WHERE order_id=$1",[object.get_order_id,object.get_sent_to_philippines])
        end
        compare_value = results.getvalue 0,11
        if !compare_value.eql? object.get_sent_to_philippines_date
          @conn.exec("UPDATE Order_table SET sent_to_philippines_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_sent_to_philippines_date])
        end
        compare_value = results.getvalue 0,12
        if !compare_value.eql? object.get_approve_philippines
          @conn.exec("UPDATE Order_table SET approve_philippines=$2 WHERE order_id=$1",[object.get_order_id,object.get_approve_philippines])
        end
        compare_value = results.getvalue 0,13
        if !compare_value.eql? object.get_approve_philippines_date
          @conn.exec("UPDATE Order_table SET approve_philippines_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_approve_philippines_date])
        end
        compare_value = results.getvalue 0,14
        if !compare_value.eql? object.get_cropping
          @conn.exec("UPDATE Order_table SET cropping=$2 WHERE order_id=$1",[object.get_order_id,object.get_cropping])
        end
        compare_value = results.getvalue 0,15
        if !compare_value.eql? object.get_cropping_date
          @conn.exec("UPDATE Order_table SET cropping_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_cropping_date])
        end
        compare_value = results.getvalue 0,16
        if !compare_value.eql? object.get_final_client_upload
          @conn.exec("UPDATE Order_table SET final_client_upload=$2 WHERE order_id=$1",[object.get_order_id,object.get_final_client_upload])
        end
        compare_value = results.getvalue 0,17
        if !compare_value.eql? object.get_final_client_upload_date
          @conn.exec("UPDATE Order_table SET final_client_upload_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_final_client_upload_date])
        end
        compare_value = results.getvalue 0,18
        if !compare_value.eql? object.get_verify_photo_replacement
          @conn.exec("UPDATE Order_table SET verify_photo_replacement=$2 WHERE order_id=$1",[object.get_order_id,object.get_verify_photo_replacement])
        end
        compare_value = results.getvalue 0,19
        if !compare_value.eql? object.get_verify_photo_replacement_date
          @conn.exec("UPDATE Order_table SET verify_photo_replacement_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_verify_photo_replacement_date])
        end


        compare_value = results.getvalue 0,20
        if object.get_home.eql? "empty"
          if !compare_value.nil?
            parade_id = nil
          end
        elsif !object.get_home.eql? "empty"
          home = Home.new
          home = object.get_home
          home_id = home.get_home_id.to_i

          if home_id != -1
            home = interact_with_home('u',home)
          elsif home_id == -1
            home = interact_with_home('c',home)
            home_id = home.get_home_id.to_i
          end
        end
        if compare_value.to_i != home_id
          @conn.exec("UPDATE Order_table SET home_id=$2 WHERE order_id=$1",[object.get_order_id,home_id])
        end

        compare_value = results.getvalue 0,21
        if object.get_photographer.eql? "empty"
          if !compare_value.nil?
            photographer_id = nil
          end
        elsif !object.get_photographer.eql? "empty"
          photographer = Photographer.new
          photographer = object.get_photographer
          photographer_id = photographer.get_photographer_id.to_i

          if photographer_id != -1
            photographer = interact_with_photographer('u',photographer)
          elsif photographer_id == -1
            photographer = interact_with_photographer('c',photographer)
            photographer_id = photographer.get_photographer_id.to_i
          end
        end
        if compare_value.to_i != photographer_id
          @conn.exec("UPDATE Order_table SET photographer_id=$2 WHERE order_id=$1",[object.get_order_id,photographer_id])
        end

        compare_value = results.getvalue 0,22
        if object.get_package.eql? "empty"
          if !compare_value.nil?
            package_id = nil
          end
        elsif !object.get_package.eql? "empty"
          package = Package.new
          package = object.get_package
          package_id = package.get_package_id.to_i

          if package_id != -1
            package = interact_with_package('u',package)
          elsif package_id == -1
            package = interact_with_package('c',package)
            package_id = package.get_package_id.to_i
          end
        end
        if compare_value.to_i != package_id
          @conn.exec("UPDATE Order_table SET package_id=$2 WHERE order_id=$1",[object.get_order_id,package_id])
        end
      else
        return (@feedBack="Error")
    end
  end

  def list_all_orders_for_parade(object)
    # Get the ID for the parade
    results = Array.new
    returnResults = Array.new
    results = @conn.exec("SELECT	a.*

                          FROM	Order_table AS a INNER JOIN Home AS b
                                    ON a.home_id = b.home_id

                                    INNER JOIN Parade c
                                    ON b.parade_id = c.parade_id

                          WHERE c.parade_id = $1",[object.get_parade_id])

    results.each do |value|
      orderTemp = Order.new
      orderTemp.set_order_id(value['order_id'])
      returnResults << interact_with_order('r',orderTemp)
    end

    return returnResults
  end
  #
  # SELECT	O
  # FROM	Parade p INNER JOIN Home h
  # ON p.parade_id = h.parade_id
  #
  # INNER JOIN Order_table o
  # ON o.home_id = h.home_id
  #
  # WHERE	p.parade_id = 1
  #
  #
  # SELECT	*
  #     FROM	Order_table
  #
  #
  # SELECT	*
  #     FROM	Home

end
