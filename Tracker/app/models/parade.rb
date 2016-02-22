
class Parade
  private
    @parade_id
    @parade_name
    @city
    @state
    @start_date
    @end_date
    @notes
  public
    def initialize(id=-1,name="empty",city="empty",state="empty",start_date="empty",end_date="empty",notes="empty")
      @parade_id=id
      @parade_name=name
      @city = city
      @state=state
      @start_date=start_date
      @end_date=end_date
      @notes=notes
    end
    def get_parade_id
      @parade_id
    end
    def set_parade_id(id)
      @parade_id=id
    end
    def set_parade_name(name)
      @parade_name=name
    end
    def get_parade_name
      @parade_name
    end
    def get_city
      @city
    end
    def set_city(city)
      @city=city
    end
    def set_start_date(start)
      @start_date=start
    end
    def get_start_date
      @start_date
    end
    def get_end_date
      @end_date
    end
    def set_end_date(end_date)
      @end_date=end_date
    end
    def get_notes
      @notes
    end
    def set_notes(notes)
      @notes=notes
    end
end
