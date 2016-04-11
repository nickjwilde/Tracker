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
    if @orderdetails.get_photographer.try(:get_swag).try(:upcase) == 'Y'
    	@orderdetails.get_photographer.try(:set_swag,true)
    else
    	@orderdetails.get_photographer.try(:set_swag,false)
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
	worker = Factory.new
	worker.connect_to_db('nitrous',"",'postgres')
	order = Order.new
	photographer = Photographer.new
	photographer.set_photographer_id(params[:photographer_id].to_i)
	photographer = worker.interact_with_photographer('R',photographer)
	package = Package.new
	package.set_package_id(params[:package_id].to_i)
	package = worker.interact_with_package('R', package)	
	package.set_num_of_photos(params[:num_photos].to_i)
	home = Home.new
	home.set_home_id(params[:home_id].to_i)
	home = worker.interact_with_home('R',home)

	@order_id = params[:order_id].to_i
	order.set_order_id(params[:order_id].to_i)
	order.set_raw_photos(params[:raw_photos].to_i)
	order.set_estimated_photos(params[:est_photos].to_i)
	order.set_final_photos_number(params[:final_photos].to_i)
	if(params[:swag] == 'true')
		photographer.set_swag('Y')
	else
		photographer.set_swag('N')
	end
	if(params[:photos_approved] == 'true')
		order.set_photos_approved('Y')
		order.set_photos_approved_date(Time.now)
	else
		order.set_photos_approved('N')
	end
	if(params[:photographer_paid] == 'true')
		order.set_photographer_paid('Y')
		order.set_photographer_paid_date(Time.now)
	else
		order.set_photographer_paid('N')
	end
	if(params[:quick_edit_upload] == 'true')
		order.set_quick_edit_upload('Y')
		order.set_quick_edit_upload_date(Time.now)
	else
		order.set_quick_edit_upload('N')
	end
	if(params[:assigned_to_editor] == 'true')
		order.set_assigned_to_editor('Y')
		order.set_assigned_to_editor_date(Time.now)
	else
		order.set_assigned_to_editor('N')
	end
	if(params[:final_edits_approve] == 'true')
		order.set_final_edits_approve('Y')
		order.set_final_edits_approve_date(Time.now)
	else
		order.set_final_edits_approve('N')
	end
	if(params[:final_crops] == 'true')
		order.set_cropping('Y')
		order.set_cropping_date(Time.now)
	else
		order.set_cropping('N')
	end
	if(params[:final_edit_upload] == 'true')
		order.set_final_edit_upload('Y')
		order.set_final_edit_upload_date(Time.now)
	else
		order.set_final_edit_upload('N')
	end
	order.set_photographer(photographer)
	order.set_package(package)
	order.set_home(home)
	worker.interact_with_order('U', order)
	worker.interact_with_photographer('U', photographer)
	worker.interact_with_home('U', home)
	worker.interact_with_package('U', package)
  end
	
end
