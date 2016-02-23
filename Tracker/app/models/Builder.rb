class Builder
  
  def initialize(id="-1",name="empty",phone="-1",email = "empty")
    @builder_id = id
    @name_of_builder= name
    @phone_number = phone
    @email = email
  end

  def set_builder_id(id)
    @builder_id = id
  end
  #
  def get_builder_id
    @builder_id
  end

  def set_name_of_builder(name)
    @name_of_builder = name
  end

  def get_name_of_builder
    @name_of_builder
  end

  def set_phone_number(phone)
    @phone_number = phone
  end

  def get_phone_number()
    @phone_number
  end

  def set_email(email)
    @email = email
  end

  def get_email
    @email
  end

end
