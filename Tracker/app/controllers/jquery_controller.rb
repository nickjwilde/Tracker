class JqueryController < ActionController::Base
  def homes
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    @parade_id = params[:id]
    @home_results = worker.interact_with_home('L')
  end

  def order
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    home = Home.new
    home.set_home_id(params[:home_id]);
    @photographer_list = worker.interact_with_photographer('L');
    @orderdetails = worker.interact_with_home('O', home)
    if @orderdetails.get_raw_photos.to_i < 0
    	@orderdetails.set_raw_photos(0)
    end
    if @orderdetails.get_estimated_photos.to_i < 0
    	@orderdetails.set_estimated_photos(0)
    end
    if @orderdetails.get_final_photos_number.to_i < 0
    	@orderdetails.set_final_photos_number(0)
    end
    if @orderdetails.get_photos_approved.upcase == 'Y'
    	@orderdetails.set_photos_approved(true)
    else
    	@orderdetails.set_photos_approved(false)
    end
    if @orderdetails.get_photographer.get_swag.upcase == 'Y'
    	@orderdetails.get_photographer.set_swag(true)
    else
    	@orderdetails.get_photographer.set_swag(false)
    end
    if @orderdetails.get_photographer_paid.upcase == 'Y'
    	@orderdetails.set_photographer_paid(true)
    else
    	@orderdetails.set_photographer_paid(false)
    end
    if @orderdetails.get_quick_edit_upload.upcase == 'Y'
    	@orderdetails.set_quick_edit_upload(true)
    else
    	@orderdetails.set_quick_edit_upload(false)
    end
    if @orderdetails.get_assigned_to_editor.upcase == 'Y'
    	@orderdetails.set_assigned_to_editor(true)
    else
    	@orderdetails.set_assigned_to_editor(false)
    end
    if @orderdetails.get_final_edits_approve.upcase == 'Y'
    	@orderdetails.set_final_edits_approve(true)
    else
    	@orderdetails.set_final_edits_approve(false)
    end
    if @orderdetails.get_cropping.upcase == 'Y'
    	@orderdetails.set_cropping(true)
    else
    	@orderdetails.set_cropping(false)
    end
    if @orderdetails.get_final_edit_upload.upcase == 'Y'
    	@orderdetails.set_final_edit_upload(true)
    else
    	@orderdetails.set_final_edit_upload(false)
    end
  end

  def updateorder

  end
	
end
