class Builder
  def initialize(id="-1",name="empty")
    @builder_id = id
    @name_of_builder= name
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
end
