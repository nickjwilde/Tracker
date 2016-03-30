class Home
  def initialize(home = "-1",name="empty",home_num = 0,address="empty",city="empty",state="empty",zipcode = 0,notes="empty",parade="empty",builder="empty")
    @home_id = home
    @home_name=name
    @address = address
    @city = city
    @state = state
    @notes = notes
    @parade = parade
    @builder = builder
    @zipcode = zipcode
    @home_number = home_num
  end
  def set_zipcode(zip)
    @zipcode = zip
  end
  def get_zipcode
    @zipcode
  end
  def set_home_number(num)
    @home_number = num
  end
  def get_home_number
    @home_number
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
  def get_home_zipcode
    @zipcode
  end
  def set_home_zipcode(zipcode)
    @zipcode = zipcode
  end
  def get_home_notes
    @notes
  end
  def set_parade(parade)
    @parade=parade
  end
  def get_parade
    @parade
  end
  def set_notes(order)
  @order=order
  end
  def get_notes
    @order
  end
  def get_builder
    @builder
  end
  def set_builder(builder)
    @builder = builder
  end
end
