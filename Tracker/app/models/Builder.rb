class Builder
  
  def initialize(id="-1",name="empty",phone="-1")
    @builder_id = id
    @name_of_builder= name
    @phone_number = phone
  end

  def self.set_builder_id(id)
    @builder_id = id
  end
  #
  def self.get_builder_id()
    @builder_id
  end

  def self.set_name_of_builder(name)
    @name_of_builder = name
  end

  def self.get_name_of_builder()
    @name_of_builder
  end

  def self.set_phone_number(phone)
    @phone_number = phone
  end

  def self.get_phone_number()
    @phone_number
  end

end
