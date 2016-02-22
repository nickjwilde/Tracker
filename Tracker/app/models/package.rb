class Package
  private
    @package_id
    @photographer
    @num_of_photos
    @notes
    #@@array = Array.new('15','30','45')
  public
    def initialize(id = "-1",photo_num="0",notes="empty",photographer="empty")
      @package_id=id
      @num_of_photos=photo_num
      @notes=notes
      @photographer=photographer
    end
    def set_package_id(id)
      @package_id = id
    end
    def get_package_id
      @package_id
    end
    def set_num_of_photos(num)
      @num_of_photos=num
    end
    def get_num_of_photos
      @num_of_photos
    end
    def set_notes(notes)
      @notes = notes
    end
    def get_notes
      @notes
    end
    def set_photographer(photographer)
      @photographer=photographer
    end
    def get_photographer
      @photographer
    end
    def get_standard_photo_list()
      @@array
    end
end
