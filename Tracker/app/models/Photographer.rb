class Photographer
  private
    @photographer_id
    @name
    @email
    @phone
    @notes

  public
    def initialize(id = "-1",name="empty",email="empty",phone="empty",notes="empty")
      @photographer_id = id
      @name = name
      @email = email
      @phone = phone
      @notes = notes
    end

    def set_photographer_id(id)
      @photographer_id = id
    end
    def get_photographer_id
      @photographer_id
    end
    def set_name(name)
      @name=name
    end
    def get_name
      @name
    end
    def set_email(email)
      @email = email
    end
    def get_email
      @email
    end
    def set_phone(phone)
      @phone = phone
    end
    def get_phone
      @phone
    end
    def set_notes(notes)
      @notes = notes
    end
    def get_notes
      @notes
    end
end
