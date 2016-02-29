class Order
    def initialize(id = "-1",received="empty",received_date=nil,ordered="empty",usable="empty",notes="empty",date_pictures_approved=nil,paid="empty",paid_date=nil,initial_client_upload="empty",initial_client_upload_date=nil,sent_to_philippines="empty",sent_to_philippines_date=nil,received_from_philippines="empty",received_from_philippines_date=nil,approve_philippines="empty",approve_philippines_date=nil,cropping="empty",cropping_date="empty",final_client_upload="empty",final_client_upload_date=nil,verify_photo_replacement="empty",verify_photo_replacement_date=nil,home = "empty",photographer="empty",package="empty")
      @order_id=id
      @photos_received=received
      @photos_received_date = received_date
      @photos_ordered=ordered
      @photos_usable=usable
      @picture_notes=notes
      @photos_approved_date=date_pictures_approved
      @photographer_paid=paid
      @photographer_paid_date=paid_date
      @initial_client_upload=initial_client_upload
      @initial_client_upload_date = initial_client_upload_date
      @sent_to_philippines = sent_to_philippines
      @sent_to_philippines_date = sent_to_philippines_date
      @received_from_philippines=received_from_philippines
      @received_from_philippines_date=received_from_philippines_date
      @approve_philippines = approve_philippines
      @approve_philippines_date = approve_philippines_date
      @cropping=cropping
      @cropping_date=cropping_date
      @final_client_upload= final_client_upload
      @final_client_upload_date=final_client_upload_date
      @verify_photo_replacement=verify_photo_replacement
      @verify_photo_replacement_date = verify_photo_replacement_date
      @home = home
      @package=package
      @photographer=photographer
    end

    def get_order_id
      @order_id
    end
    def set_order_id(id)
      @order_id=id
    end
    def get_photos_received
      @photos_received
    end
    def set_photo_received(receive)
      @photos_received = receive
    end
  def get_received_date
    @received_date
  end
  def set_received_date(date)
    @received_date = date
  end
  def get_photos_ordered
    @photos_ordered
  end
  def set_photos_ordered(ordered)
    @photos_ordered = ordered
  end
  def get_photos_usable
    @photos_usable
  end
  def set_photos_usable(usable)
    @photos_usable=usable
  end
  def get_notes
    @picture_notes
  end
  def set_notes(notes)
    @picture_notes = notes
  end
  def set_photos_approved_date(approved)
    @photos_approved_date = approved
  end
  def get_photos_approved_date
    @photos_approved_date
  end
  def set_photographer_paid(paid)
    @photographer_paid=paid
  end
  def get_photographer_paid
    @photographer_paid
  end
    def set_photographer_paid_date(paid_date)
      @photographer_paid_date=paid_date
    end
    def get_photographer_paid_date
      @photographer_paid_date
    end
  def set_initial_client_upload(upload)
    @initial_client_upload=upload
  end
  def get_initial_client_upload
    @initial_client_upload
  end
  def set_initial_client_upload_date(upload_date)
    @initial_client_upload_date=upload_date
  end
  def get_initial_client_upload_date
    @initial_client_upload_date
  end
  def set_sent_to_philippines(sent_to)
    @sent_to_philippines =sent_to
  end
  def get_sent_to_philippines
    @sent_to_philippines
  end
  def set_sent_to_philippines_date(sent_to_date)
    @sent_to_philippines_date =sent_to_date
  end
  def get_sent_to_philippines_date
    @sent_tophilippines_date
  end
  def set_cropping(cropping)
    @cropping = cropping
  end
  def get_cropping
    @cropping
  end
  def set_cropping_date(cropping_date)
    @cropping_date = cropping_date
  end
  def get_cropping_date
    @cropping_date
  end
  def set_final_client_upload(upload)
    @final_client_upload = upload
  end
  def get_final_client_upload
    @final_client_upload
  end
  def set_final_client_upload_date(upload_date)
    @final_client_upload_date = upload_date
  end
  def get_final_client_upload_date
    @final_client_upload_date
  end
  def set_verify_photo_replacement(photo_replacement)
    @verify_photo_replacement = photo_replacement
  end
  def get_verify_photo_replacement
    @verify_photo_replacement
  end
    def get_verify_photo_replacement_date
      @verify_photo_replacement_date
    end
    def set_verify_photo_replacement_date(date)
      @verify_photo_replacement_date = date
    end
  def set_approve_philippines(approve_philippines)
    @approve_philippines = approve_philippines
  end
  def get_approve_philippines
    @approve_philippines
  end
  def set_approve_philippines_date(approve_philippines_date)
    @approve_philippines_date = approve_philippines_date
  end
  def get_approve_philippines_date
    @approve_philippines_date
  end
    def get_home
      @home
    end
    def set_home(home)
      @home = home
    end
  def set_package(package)
    @package= package
  end
  def get_package
    @package
  end
  def set_photographer(photographer)
    @photographer= photographer
  end
  def get_photographer
    @photographer
  end
end
