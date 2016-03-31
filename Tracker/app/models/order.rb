class Order
    def initialize(id = "-1", raw="empty", raw_date=nil,estimated="empty", approved = "N", date_pictures_approved=nil, paid="empty", paid_date=nil, quick_edit="empty", quick_edit_date=nil, assigned_editor="empty", assigned_editor_date=nil, final_edits="empty", final_edits_date=nil,final_num=0, cropping="empty", cropping_date="empty", final_edit_upload="empty", final_edit_upload_date=nil, home = "empty", photographer="empty", package="empty")
      @order_id=id
      @home = home
      @package=package
      @photographer=photographer
      @raw_photos=raw
      @raw_photos_date = raw_date
      @estimated_photos=estimated
      @photos_approved = approved
      @photos_approved_date=date_pictures_approved
      @photographer_paid=paid
      @photographer_paid_date=paid_date
      @quick_edit_upload=quick_edit
      @quick_edit_upload_date = quick_edit_date
      @assigned_to_editor = assigned_editor
      @assigned_to_editor_date = assigned_editor_date
      @final_edits_approve=final_edits
      @final_edits_approve_date=final_edits_date
      @final_photos_num = final_num
      @final_cropping=cropping
      @final_cropping_date=cropping_date
      @final_edit_upload= final_edit_upload
      @final_edit_upload_date=final_edit_upload_date
  end
  def get_order_id
    @order_id
  end
  def set_order_id(id)
    @order_id=id
  end
  def get_raw_photos
    @raw_photos
  end
  def set_raw_photos(raw)
    @raw_photos = raw
  end
  def get_raw_photos_date
    @raw_photos_date
  end
  def set_raw_photos_date(date)
    @raw_photos_date = date
  end
  def get_estimated_photos
    @estimated_photos
  end
  def set_estimated_photos(estimated)
    @estimated_photos=estimated
  end
  def set_photos_approved(photos)
    @photos_approved = photos
  end
  def get_photos_approved
    @photos_approved
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
  def set_quick_edit_upload(upload)
    @quick_edit_upload=upload
  end
  def get_quick_edit_upload
    @quick_edit_upload
  end
  def set_quick_edit_upload_date(upload_date)
    @quick_edit_upload_date=upload_date
  end
  def get_quick_edit_upload_date
    @quick_edit_upload_date
  end
  def set_assigned_to_editor(sent_to)
    @assigned_to_editor =sent_to
  end
  def get_assigned_to_editor
    @assigned_to_editor
  end
  def set_assigned_to_editor_date(assigned_to_date)
    @assigned_to_editor_date =assigned_to_date
  end
  def get_assigned_to_editor_date
    @assigned_to_editor_date
  end
  def set_final_edits_approve(final_edits)
    @final_edits_approve =final_edits
  end
  def get_final_edits_approve
    @final_edits_approve
  end
  def set_final_edits_approve_date(final_edits_date)
    @final_edits_approve_date =final_edits_date
  end
  def get_final_edits_approve_date
    @final_edits_approve_date
  end
  def set_final_photos_number(num)
    @final_photos_num = num
  end
  def get_final_photos_number
    @final_photos_num
  end
  def set_cropping(cropping)
    @final_cropping = cropping
  end
  def get_cropping
    @final_cropping
  end
  def set_cropping_date(cropping_date)
    @final_cropping_date = cropping_date
  end
  def get_cropping_date
    @final_cropping_date
  end
  def set_final_edit_upload(upload)
    @final_edit_upload = upload
  end
  def get_final_edit_upload
    @final_edit_upload
  end
  def set_final_edit_upload_date(upload_date)
    @final_edit_upload_date = upload_date
  end
  def get_final_edit_upload_date
    @final_edit_upload_date
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
