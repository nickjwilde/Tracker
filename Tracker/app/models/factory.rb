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
                    builder_id		        SERIAL 		      PRIMARY KEY
                    , name_of_builder		  VARCHAR(100)	                                      NOT NULL
                    , phone_number		    VARCHAR(14)
                    , time_stamp          TIMESTAMP        DEFAULT      current_timestamp     NOT NULL
             );")
  end

  def interact_with_builder(choice,object="empty")
    choice = choice.upcase
    case choice
      when 'C'
        results = Array.new
        @conn.exec("INSERT INTO Builder (name_of_builder,phone_number) VALUES($1,$2)",[object.get_name_of_builder,object.get_phone_number])
        results = @conn.exec("SELECT b.builder_id, max_date
                              FROM    Builder b
                                          INNER JOIN(
                                                  SELECT builder_id, MAX(time_stamp) AS max_date
                                                  FROM   Builder
                                                  GROUP BY builder_id
                                                  ) a
                                                   ON a.builder_id = b.builder_id
                                                   AND a.max_date = time_stamp")
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

  # Photographer section
  def create_photographer_table
    @conn.exec("ALTER TABLE Package DROP CONSTRAINT package_photographer_id_fkey")
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
        results = @conn.exec("SELECT b.photographer_id, max_date
                              FROM    Photographer b
                                          INNER JOIN(
                                                  SELECT photographer_id, MAX(time_stamp) AS max_date
                                                  FROM   Photographer
                                                  GROUP BY photographer_id
                                                  ) a
                                                   ON a.photographer_id = b.photographer_id
                                                   AND a.max_date = time_stamp")
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
          @conn.exec("UPDATE Photographer SET email_of_photographer=$2 WHERE photographer_id=$1",[object.get_photographer_id_id,object.get_email])
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
                    , photographer_id     		        INTEGER         REFERENCES Photographer(photographer_id)
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
      # Check to see if there is a photographer assigned to this package
      if object.get_photographer.eql? "empty"
        new_package_photographer_id = nil
        # If a photographer is assigned
      elsif !object.get_photographer.eql? "empty"
        photographer = object.get_photographer
        # Check to see if the photographer is already created
        if photographer.get_photographer_id.eql? "-1"
          # Create a new photographer and then get the ID
          new_package_photographer_id = interact_with_photographer('C',(object.get_photographer))
        else
          # Get the id from the exisiting photographer
          new_package_photographer_id = photographer.get_photographer_id
        end
      end
      @conn.exec("INSERT INTO Package (photographer_id,number_of_photos,notes_of_package) VALUES($1,$2,$3)",[new_package_photographer_id.to_i,object.get_num_of_photos,object.get_notes])
      results = @conn.exec("SELECT b.package_id, max_date
                              FROM    Package b
                                          INNER JOIN(
                                                  SELECT package_id, MAX(time_stamp) AS max_date
                                                  FROM   Package
                                                  GROUP BY package_id
                                                  ) a
                                                   ON a.package_id = b.package_id
                                                   AND a.max_date = time_stamp")
      object.set_package_id(results.getvalue 0,0)
      results = nil
      new_package_photographer_id = nil
      return object
      when 'D'
        @conn.exec("DELETE FROM Package WHERE package_id = $1",[object.get_package_id])
      when 'L'
        @feedBack = Array.new
        @conn.exec "SELECT  package_id, name_of_photographer
                    FROM    Package b
                                LEFT JOIN(SELECT name_of_photographer
                                          FROM    Photographer
                                        ) a
                                        ON b.photographer_id = a.photographer_id" do |results|
          results.each do |row|
            object = Package.new
            object.set_package_id(row['package_id'])
            object.set_photographer.set_name(row['name_of_photographer'])
            @feedBack << object
          end
        end
        results = nil
        return @feedBack
      when 'R'
        results = Array.new
        results = @conn.exec("SELECT * FROM Package WHERE package_id=$1",[object.get_photographer_id])
        object.set_number_of_photos(results.getvalue 0,2)
        object.set_notes(results.getvalue 0,3)
        results = nil
        compare_value = results.getvalue 0,1
        if compare_value.eql? -1
          object.set_photographer("empty")
        else
          photographer_id = results.getvalue 0,1
          photographer = Photographer.new
          photographer.set_photographer_id(photographer_id)
          photographer = interact_with_photographer('R',photographer)
          object.set_photographer(photographer)
        end
        return object
    else
      return (@feedBack="Error")
    end

  end

end