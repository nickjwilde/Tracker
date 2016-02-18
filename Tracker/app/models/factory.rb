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
                    , nameOfBuilder		VARCHAR(100)	NOT NULL
                    , phoneNumber		VARCHAR(14)
             );")
  end

  def interact_with_builder(choice,object="empty")
    choice = choice.upcase
    case choice
      when 'C'
        @conn.exec("INSERT INTO Builder (nameofbuilder,phoneNumber) VALUES($1,$2)",[object[1],object[2]])
      when choice == 'R'
        @conn.prepare('stm1', "SELECT * FROM Builder WHERE Id=$1")
        rs = con.exec_prepared('stm1', [object[0]])
        @feedBack = rs
      when 'U'

      when 'D'

      when 'L'
        @feedBack
        results = @conn.exec('SELECT builder_id, nameOfBuilder FROM Builder')
        res.each do |row|

        end
      else
        @feedBack="Error"
    end

  end
  @feedBack
end