class Home
  private
    @home_id
    @home_name
    @address
    @city
    @state
    @notes
    @parade
    @order
    @photographer
    @builder
  public
    def initialize(home = "-1",name="empty",address="empty",city="empty",state="empty",notes="empty",parade="empty",order="empty",photographer_notes="empty",photographer = "empty",builder="empty")
      @home_id = home
      @home_name=name
      @address = address
      @city = city
      @state = state
      @notes = notes
      @parade = parade
      @order = order
      @photographer_notes = photographer_notes
      @photographer = photographer
      @builder = builder
    end
    def set_home_id(id)
      @home_id=id
    end
    def get_home_id
      @home_id
    end
    def set_home_name(name)
      @home_name = name
    end
    def get_home_name
      @home_name
    end
    def set_home_address(address)
      @address=address
    end
    def get_home_address
      @address
    end
    def set_city(city)
      @city=city
    end
    def get_city
      @city
    end
    def set_state(state)
      @state=state
    end
    def get_state
      @state
    end
    def set_home_notes(notes)
    @notes=notes
    end
    def get_home_notes
      @notes
    end
    def set_parade_notes(parade)
      @parade=parade
    end
    def get_parade_notes
      @parade
    end
    def set_order_notes(order)
    @order=order
  end
  def get_order_notes
    @order
  end
  def set_photographer_notes(photographer)
    @photographer=photographer
  end
  def get_photographer_notes
    @photographer
  end
  def set_builder_notes(builder)
    @builder=builder
  end
  def get_builder_notes
    @builder
  end
end
