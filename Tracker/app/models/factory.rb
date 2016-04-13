require 'pg'

class Factory

  # Overall connection to db done here
  def initialize
    @conn =""
    @feedBack =""
  end

  def connect_to_db(user_name,pw,database)
    @conn = PG::Connection.open(:dbname => database,:user =>user_name, :password =>pw)
  end

  # Builder Table information
  def create_builder_table
    @conn.exec("DROP TABLE IF EXISTS Builder")

    @conn.exec ("CREATE TABLE Builder(
                    builder_id		        SERIAL 		      PRIMARY KEY
                    , name_of_builder		  VARCHAR(100)	                                      NOT NULL
             );")
  end

  def interact_with_builder(choice,object="empty")
    choice = choice.upcase
    case choice
      when 'C'
        results = Array.new
        @conn.exec("INSERT INTO Builder (name_of_builder) VALUES($1)",[object.get_name_of_builder])
        results = @conn.exec("SELECT MAX(builder_id) FROM Builder")
        object.set_builder_id(results.getvalue 0,0)
        results = nil
        return object
      when 'R'
        results = Array.new
        results = @conn.exec("SELECT builder_id, name_of_builder FROM Builder WHERE builder_id=$1",[object.get_builder_id])
        object.set_name_of_builder(results.getvalue 0,1)
        results = nil
        return object
      when 'U'
        results = Array.new
        results = @conn.exec("SELECT builder_id, name_of_builder FROM Builder WHERE builder_id=$1",[object.get_builder_id])
        compare_value = results.getvalue 0,1
        if !compare_value.eql? object.get_name_of_builder
          @conn.exec("UPDATE Builder SET name_of_builder=$2 WHERE builder_id=$1",[object.get_builder_id,object.get_name_of_builder])
        end
      when 'D'
        @conn.exec("DELETE FROM Builder WHERE builder_id = $1",[object.get_builder_id])
      when 'L'
        @feedBack = Array.new
        @conn.exec "SELECT builder_id, name_of_builder FROM Builder ORDER BY name_of_builder" do |results|
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
                    , swag                            VARCHAR(2)
             );")
  end

  def interact_with_photographer(choice,object = "empty")
    choice = choice.upcase
    case choice
      when 'C'
        results = Array.new
        @conn.exec("INSERT INTO Photographer (name_of_photographer,email_of_photographer,phone_number_of_photographer,notes_of_photographer,swag) VALUES($1,$2,$3,$4,$5)",[object.get_name,object.get_email,object.get_phone,object.get_notes,object.get_swag])
        results = @conn.exec("SELECT MAX(photographer_id) FROM Photographer")
        object.set_photographer_id(results.getvalue 0,0)
        results = nil
        return object
      when 'D'
        @conn.exec("DELETE FROM Photographer WHERE photographer_id = $1",[object.get_photographer_id])
      when 'L'
        @feedBack = Array.new
        @conn.exec "SELECT photographer_id, name_of_photographer FROM Photographer order by name_of_photographer" do |results|
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
        results = @conn.exec("SELECT photographer_id, name_of_photographer, email_of_photographer, phone_number_of_photographer, notes_of_photographer, swag FROM Photographer WHERE photographer_id=$1",[object.get_photographer_id])
	if !results.num_tuples.zero?
        object.set_name(results.getvalue 0,1)
        object.set_email(results.getvalue 0,2)
        object.set_phone(results.getvalue 0,3)
        object.set_notes(results.getvalue 0,4)
        object.set_swag(results.getvalue 0,5)
        results = nil
        return object
	else
	return nil
	end
      when 'L'
	@feedback = Array.new
      	results = Array.new
	results = @conn.exec("SELECT * FROM photographer")
	results.each do | row |
		object = Photographer.new
		object.set_photographer_id(row['photographer_id'])
		object.set_name(row['name_of_photographer'])
		object.set_email(row['email_of_photographer'])
		object.set_phone(row['phone_of_photographer'])
		object.set_notes(row['notes_of_photographer'])
		object.set_swag(row['swag'])
		@feedback << object
	end
	return @feedback
      when 'U'
        results = Array.new
        results = @conn.exec("SELECT photographer_id, name_of_photographer, email_of_photographer, phone_number_of_photographer,notes_of_photographer, swag FROM Photographer WHERE photographer_id=$1",[object.get_photographer_id])
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
          @conn.exec("UPDATE Photographer SET phone_number_of_photographer=$2 WHERE photographer_id=$1",[object.get_photographer_id,object.get_phone])
        end
        compare_value = results.getvalue 0,4
        if !compare_value.eql? object.get_notes
          @conn.exec("UPDATE Photographer SET notes_of_photographer=$2 WHERE photographer_id=$1",[object.get_photographer_id,object.get_notes])
        end
        compare_value = results.getvalue 0,5
        if !compare_value.eql? object.get_swag
          @conn.exec("UPDATE Photographer SET swag=$2 WHERE photographer_id=$1",[object.get_photographer_id,object.get_swag])
        end
        results = nil
      else
        return (@feedBack="Error")
    end
  end

 ## Parade area
  def create_parade_table

   #@conn.exec("ALTER TABLE Home DROP CONSTRAINT home_parade_id_fkey")

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

        @conn.exec "SELECT * FROM Parade" do |results|
        results.each do |row|
            object = Parade.new(row['parade_id'],row['name_of_parade'],row['city_of_parade'],row['state_of_parade'],row['start_date_of_parade'],row['end_date_of_parade'])
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
                    , home_number                     INTEGER
                    , home_address                    VARCHAR(100)
                    , city                            VARCHAR(100)
                    , state                           VARCHAR(100)
                    , zip                             INTEGER
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

        @conn.exec("INSERT INTO Home (home_name,home_address,home_number,city,state,zip,notes,parade_id,builder_id) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9)",[object.get_home_name,object.get_home_address,object.get_home_number,object.get_city,object.get_state,object.get_zipcode,object.get_home_notes,parade_id,builder_id])
        results = @conn.exec("SELECT MAX(home_id) FROM Home")
        object.set_home_id(results.getvalue 0,0)
        results = nil
        return object
      # Delete a home based off of the id
      when 'D'
        @conn.exec("DELETE FROM Home WHERE home_id = $1",[object.get_home_id])
      when 'L'
        @feedBack = Array.new
        @conn.exec("SELECT  h.*, b.name_of_builder, p.name_of_parade
                    FROM Home h
                        LEFT JOIN builder b
                        ON h.builder_id = b.builder_id
                        LEFT JOIN Parade p
                        ON h.parade_id = p.parade_id
			ORDER BY h.home_number" )do |results|
          results.each do |row|
            object = Home.new(row['home_id'],row['home_name'],row['home_number'],row['home_address'],row['city'],row['state'],row['zipcode'],row['notes'])

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
        object.set_home_number(results.getvalue 0,2)
        object.set_home_address(results.getvalue 0,3)
        object.set_city(results.getvalue 0,4)
        object.set_state(results.getvalue 0,5)
        object.set_zipcode(results.getvalue 0,6)
        object.set_notes(results.getvalue 0,7)

        # Get parade associated with home
        compare_value = results.getvalue 0,8
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
        compare_value = results.getvalue 0,9
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
      when 'O'
        id = object.get_home_id
        results = Array.new
        results = @conn.exec("SELECT order_id FROM Order_table WHERE home_id=$1",[object.get_home_id])
        order = Order.new
	if results.num_tuples.zero?
       		order.set_order_id(-1)
	else
       		order.set_order_id(results.getvalue(0,0))
	end
        order = interact_with_order('R',order)
        return order
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
        if !compare_value.eql? object.get_home_number
          @conn.exec("UPDATE Home SET home_number=$2 WHERE home_id=$1",[object.get_home_id,object.get_home_number])
        end
        compare_value = results.getvalue 0,4
        if !compare_value.eql? object.get_city
          @conn.exec("UPDATE Home SET city=$2 WHERE home_id=$1",[object.get_home_id,object.get_city])
        end
        compare_value = results.getvalue 0,5
        if !compare_value.eql? object.get_state
          @conn.exec("UPDATE Home SET state=$2 WHERE home_id=$1",[object.get_home_id,object.get_state])
        end
        compare_value = results.getvalue 0,6
        if !compare_value.eql? object.get_zipcode
          @conn.exec("UPDATE Home SET zip=$2 WHERE home_id=$1",[object.get_home_id,object.get_zipcode])
        end
        compare_value = results.getvalue 0,7
        if !compare_value.eql? object.get_notes
          @conn.exec("UPDATE Home SET notes=$2 WHERE home_id=$1",[object.get_home_id,object.get_notes])
        end
        compare_value = results.getvalue 0,8
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
        compare_value = results.getvalue 0,9
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
                    , num_package_photos		INTEGER
		    , raw_photos	                    INTEGER
                    , raw_photos_date                 TIMESTAMP
                    , estimated_photos                INTEGER
                    , photos_approved                  VARCHAR(2)
                    , photos_approved_date            TIMESTAMP
                    , photographer_paid               VARCHAR(2)
                    , photographer_paid_date          TIMESTAMP
                    , quick_edit_upload               VARCHAR(2)
                    , quick_edit_upload_date          TIMESTAMP
                    , assigned_to_editor              VARCHAR(2)
                    , assigned_to_editor_date         TIMESTAMP
                    , final_edits_approve             VARCHAR(2)
                    , final_edits_approve_date        TIMESTAMP
                    , final_photos_num                INTEGER
                    , final_cropping                  VARCHAR(2)
                    , final_cropping_date             TIMESTAMP
                    , final_edit_upload               VARCHAR(2)
                    , final_edit_upload_date          TIMESTAMP
                    , home_id                         INTEGER
                    , photographer_id                 INTEGER
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
        @conn.exec("INSERT INTO Order_table (num_package_photos,raw_photos,raw_photos_date,estimated_photos,photos_approved,photos_approved_date,photographer_paid,photographer_paid_date,quick_edit_upload,quick_edit_upload_date,assigned_to_editor,assigned_to_editor_date,final_edits_approve,final_edits_approve_date,final_photos_num,final_cropping,final_cropping_date,final_edit_upload,final_edit_upload_date,home_id,photographer_id) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21)",[object.get_num_package_photos, object.get_raw_photos, object.get_raw_photos_date, object.get_estimated_photos, object.get_photos_approved, object.get_photos_approved_date, object.get_photographer_paid, object.get_photographer_paid_date, object.get_quick_edit_upload, object.get_quick_edit_upload_date, object.get_assigned_to_editor, object.get_assigned_to_editor_date, object.get_final_edits_approve, object.get_final_edits_approve_date,object.get_final_photos_number, object.get_cropping, object.get_cropping_date, object.get_final_edit_upload, object.get_final_edit_upload_date, home_id, photographer_id])
        results = @conn.exec("SELECT MAX(order_id) FROM Order_table")
        object.set_order_id(results.getvalue 0,0)
        results = nil
        return object
      # Delete a Order based off of the id
      when 'D'
        @conn.exec("DELETE FROM Order_table WHERE order_id = $1",[object.get_order_id])
      when 'L'
        @feedBack = Array.new
        @conn.exec("SELECT  order_id, num_package_photos, home_name, a.home_id, name_of_parade, b.parade_id, name_of_photographer, a.photographer_id
                    FROM    Order_table a
                                LEFT JOIN(SELECT *
                                          FROM    Home
                                        ) b
                                        ON a.home_id = b.home_id
                                LEFT JOIN(SELECT *
                                          FROM    Parade
                                        ) c
                                        ON b.parade_id = c.parade_id
                                LEFT JOIN(
                                    SELECT *
                                    FROM    Photographer
                                  ) e
                                  ON a.photographer_id = e.photographer_id" )do |results|
          results.each do |row|
            object = Order.new
            object.set_order_id(row['order_id'])
	    object.set_num_package_photos(row['num_package_photos'])

            home = Home.new
            home.set_home_id(row['home_id'])
            home.set_home_name(row['home_name'])

            photographer = Photographer.new
            photographer.set_photographer_id(row['photographer_id'])
            photographer.set_name(row['name_of_photographer'])
	    photographer = interact_with_photographer('R', photographer)

            parade = Parade.new
            parade.set_parade_id(row['parade_id'])
            parade.set_parade_name(row['name_of_parade'])
            home.set_parade(parade)

            object.set_home(home)
            object.set_photographer(photographer)
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
	if !results.num_tuples.zero?
        object.set_num_package_photos(results.getvalue 0,1)
        object.set_raw_photos(results.getvalue 0,2)
        object.set_raw_photos_date(results.getvalue 0,3)
        object.set_estimated_photos(results.getvalue 0,4)
        object.set_photos_approved(results.getvalue 0,5)
        object.set_photos_approved_date(results.getvalue 0,6)
        object.set_photographer_paid(results.getvalue 0,7)
        object.set_photographer_paid_date(results.getvalue 0,8)
        object.set_quick_edit_upload(results.getvalue 0,9)
        object.set_quick_edit_upload_date(results.getvalue 0,10)
        object.set_assigned_to_editor(results.getvalue 0,11)
        object.set_assigned_to_editor_date(results.getvalue 0,12)
        object.set_final_edits_approve(results.getvalue 0,13)
        object.set_final_edits_approve_date(results.getvalue 0,14)
        object.set_final_photos_number(results.getvalue 0,15)
        object.set_cropping(results.getvalue 0,16)
        object.set_cropping_date(results.getvalue 0,17)
        object.set_final_edit_upload(results.getvalue 0,18)
        object.set_final_edit_upload_date(results.getvalue 0,19)

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
	end
        results = nil
        return object
      when 'U'
        results = Array.new
        results = @conn.exec("SELECT * FROM order_table WHERE order_id=$1",[object.get_order_id])
	compare_value = results.getvalue 0,1
        if !compare_value.eql? object.get_num_package_photos 
          @conn.exec("UPDATE order_table SET num_package_photos=$2 WHERE order_id=$1",[object.get_order_id,object.get_num_package_photos.to_i])
        end

        compare_value = results.getvalue 0,3
        if !compare_value.eql? object.get_raw_photos
          @conn.exec("UPDATE order_table SET raw_photos=$2 WHERE order_id=$1",[object.get_order_id,object.get_raw_photos])
        end
        compare_value = results.getvalue 0,4
        if !compare_value.nil?
          @conn.exec("UPDATE order_table SET raw_photos_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_raw_photos_date])
        end
        compare_value = results.getvalue 0,5
        if !compare_value.eql? object.get_estimated_photos
          @conn.exec("UPDATE order_table SET estimated_photos=$2 WHERE order_id=$1",[object.get_order_id,object.get_estimated_photos])
        end
        compare_value = results.getvalue 0,6
        if !compare_value.eql? object.get_photos_approved
          @conn.exec("UPDATE order_table SET photos_approved=$2 WHERE order_id=$1",[object.get_order_id,object.get_photos_approved])
        end
        compare_value = results.getvalue 0,7
        if !compare_value.nil?
          @conn.exec("UPDATE order_table SET photos_approved_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_photos_approved_date])
        end
        compare_value = results.getvalue 0,8
        if !compare_value.eql? object.get_photographer_paid
          @conn.exec("UPDATE order_table SET photographer_paid=$2 WHERE order_id=$1",[object.get_order_id,object.get_photographer_paid])
        end
        compare_value = results.getvalue 0,9
        if !compare_value.nil?
          @conn.exec("UPDATE order_table SET photographer_paid_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_photographer_paid_date])
        end
        compare_value = results.getvalue 0,10
        if !compare_value.eql? object.get_quick_edit_upload
          @conn.exec("UPDATE order_table SET quick_edit_upload=$2 WHERE order_id=$1",[object.get_order_id,object.get_quick_edit_upload])
        end
        compare_value = results.getvalue 0,11
        if !compare_value.nil?
          @conn.exec("UPDATE order_table SET quick_edit_upload_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_quick_edit_upload_date])
        end
        compare_value = results.getvalue 0,12
        if !compare_value.eql? object.get_assigned_to_editor
          @conn.exec("UPDATE order_table SET assigned_to_editor=$2 WHERE order_id=$1",[object.get_order_id,object.get_assigned_to_editor])
        end
        compare_value = results.getvalue 0,13
        if !compare_value.nil?
          @conn.exec("UPDATE order_table SET assigned_to_editor_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_assigned_to_editor_date])
        end
        compare_value = results.getvalue 0,14
        if !compare_value.eql? object.get_final_edits_approve
          @conn.exec("UPDATE order_table SET final_edits_approve=$2 WHERE order_id=$1",[object.get_order_id,object.get_final_edits_approve])
        end
        compare_value = results.getvalue 0,15
        if !compare_value.nil?
          @conn.exec("UPDATE order_table SET final_edits_approve_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_final_edits_approve_date])
        end
        compare_value = results.getvalue 0,16
        if !compare_value.eql? object.get_final_photos_number
          @conn.exec("UPDATE order_table SET final_photos_num=$2 WHERE order_id=$1",[object.get_order_id,object.get_final_photos_number])
        end
        compare_value = results.getvalue 0,17
        if !compare_value.eql? object.get_cropping
          @conn.exec("UPDATE order_table SET final_cropping=$2 WHERE order_id=$1",[object.get_order_id,object.get_cropping])
        end
        compare_value = results.getvalue 0,18
        if compare_value.nil?
          @conn.exec("UPDATE order_table SET final_cropping_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_cropping_date.to_time])
        end
        compare_value = results.getvalue 0,19
        if !compare_value.eql? object.get_final_edit_upload
          @conn.exec("UPDATE order_table SET final_edit_upload=$2 WHERE order_id=$1",[object.get_order_id,object.get_final_edit_upload])
        end
        compare_value = results.getvalue 0,20
        if !compare_value.nil?
          @conn.exec("UPDATE order_table SET final_edit_upload_date=$2 WHERE order_id=$1",[object.get_order_id,object.get_final_edit_upload_date])
        end
        compare_value = results.getvalue 0,21
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
          if home_id == -1
            home = interact_with_home('c',home)
            home_id = home.get_home_id.to_i
          end
        end
        if compare_value.to_i != home_id
          @conn.exec("UPDATE Order_table SET home_id=$2 WHERE order_id=$1",[object.get_order_id,home_id])
        end

        compare_value = results.getvalue 0,22
        if object.get_photographer.eql? "empty"
          if !compare_value.nil?
            photographer_id = nil
          end
        elsif !object.get_photographer.eql? "empty"
          photographer = Photographer.new
          photographer = object.get_photographer
          photographer_id = photographer.get_photographer_id.to_i

          if photographer_id == -1
            photographer = interact_with_photographer('c',photographer)
            photographer_id = photographer.get_photographer_id.to_i
          end
        end
        @conn.exec("UPDATE Order_table SET photographer_id=$2 WHERE order_id=$1",[object.get_order_id,photographer_id])
    end
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

  def create_user_table
    @conn.exec("DROP TABLE IF EXISTS user_table")

    @conn.exec ("CREATE TABLE user_table(
                first_name      VARCHAR(100),
                last_name       VARHCAR(100),
                email           VARCHAR(1000),
                user_id         INTEGER,
                time_stamp      TIMESTAMP         DEFAULT         current_timestamp     NOT NULL
              );")
  end

  def interact_with_user(choice,object="empty")
    choice = choice.upcase
    case choice
      when 'C'
        results = Array.new
        @conn.exec("INSERT INTO user_table (first_name,last_name,email,user_id) VALUES($1,$2,$3,$4)",[object.get_first_name,object.get_last_name,object.get_email,object.get_user_id])
      when 'V'
        results = Array.new
        results = @conn.exec("SELECT user_id FROM user_table WHERE user_id=$1",[object.get_user_id])
        if (results.num_tuples.zero?)
          return FALSE
        else
          return TRUE
        end
      when 'U'
        results = Array.new
        results = @conn.exec("SELECT first_name,last_name,user_id FROM user_table WHERE user_id=$1",[object.get_user_id])
        compare_value = results.getvalue 0,0
        if !compare_value.eql? object.get_first_name
          @conn.exec("UPDATE user_table SET first_name=$2 WHERE user_id=$1",[object.get_user_id,object.get_first_name])
        end
        compare_value = results.getvalue 0,1
        if !compare_value.eql? object.get_last_name
          @conn.exec("UPDATE user_table SET last_name=$2 WHERE user_id=$1",[object.get_user_id,object.get_last_name])
        end
        compare_value = results.getvalue 0,2
        if !compare_value.eql? object.get_last_name
          @conn.exec("UPDATE user_table SET email=$2 WHERE user_id=$1",[object.get_user_id,object.get_email])
        end
      when 'D'
        @conn.exec("DELETE FROM user_table WHERE user_id = $1",[object.get_user_id])
      when 'L'
        @feedBack = Array.new
        @conn.exec "SELECT first_name, last_name, email FROM user_table" do |results|
          results.each do |row|
            object = User.new
            object.set_first_name(row['first_name'])
            object.set_last_name(row['last_name'])
            object.set_email(row['email'])
            @feedBack << object
          end
        end
        results = nil
        return @feedBack
      else
        return (@feedBack="Error")
    end
    end
  end
