class JqueryController < ActionController::Base
  def homes
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    @parade_id = params[:id]
    @home_results = worker.interact_with_home('L')
  end

  def paradenotes
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    parade = Parade.new
    parade.set_parade_id(params[:id].to_i)
    parade = worker.interact_with_parade('R', parade)
    @paradenotes = parade.get_notes
  end

  def updateparadenotes
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    parade = Parade.new
    parade.set_parade_id(params[:parade_id].to_i)
    parade = worker.interact_with_parade('R', parade)
    parade.set_notes(params[:notes])
    worker.interact_with_parade('U', parade)
  end
  
  def homenotes
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    home = Home.new
    home.set_home_id(params[:home_id].to_i)
    home = worker.interact_with_home('R', home)
    @homenotes = home.get_notes

  end

  def updatehomenotes
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    home = Home.new
    home.set_home_id(params[:home_id].to_i)
    home = worker.interact_with_home('R', home)
    home.set_notes(params[:notes])
    worker.interact_with_home('U', home)
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
    if @orderdetails.try(:get_photos_approved).try(:upcase) == 'Y'
    	@orderdetails.set_photos_approved(true)
    else
    	@orderdetails.set_photos_approved(false)
    end
    if @orderdetails.get_photographer.try(:get_swag).try(:upcase) == 'Y'
    	@orderdetails.get_photographer.try(:set_swag,true)
    else
    	@orderdetails.get_photographer.try(:set_swag,false)
    end
    if @orderdetails.get_photographer_paid.try(:upcase) == 'Y'
    	@orderdetails.set_photographer_paid(true)
    else
    	@orderdetails.set_photographer_paid(false)
    end
    if @orderdetails.get_quick_edit_upload.try(:upcase) == 'Y'
    	@orderdetails.set_quick_edit_upload(true)
    else
    	@orderdetails.set_quick_edit_upload(false)
    end
    if @orderdetails.get_assigned_to_editor.try(:upcase) == 'Y'
    	@orderdetails.set_assigned_to_editor(true)
    else
    	@orderdetails.set_assigned_to_editor(false)
    end
    if @orderdetails.get_final_edits_approve.try(:upcase) == 'Y'
    	@orderdetails.set_final_edits_approve(true)
    else
    	@orderdetails.set_final_edits_approve(false)
    end
    if @orderdetails.get_cropping.try(:upcase) == 'Y'
    	@orderdetails.set_cropping(true)
    else
    	@orderdetails.set_cropping(false)
    end
    if @orderdetails.get_final_edit_upload.try(:upcase) == 'Y'
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
	photographer.set_notes(params[:photographer_notes])
	worker.interact_with_photographer('U', photographer)
	order.set_num_package_photos(params[:num_photos])
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
	order.set_home(home)
	worker.interact_with_order('U', order)
	worker.interact_with_photographer('U', photographer)
	worker.interact_with_home('U', home)
  end

  def addevent
	worker = Factory.new
	worker.connect_to_db("nitrous","","postgres")
	parade = Parade.new
	parade.set_parade_name(params[:name])
	parade.set_city(params[:city])
	parade.set_state(params[:state])
	parade.set_start_date(params[:start_date])
	if params[:end_date] == ""
		parade.set_end_date(params[:start_date])
	else
		parade.set_end_date(params[:end_date])
	end
	parade.set_notes(params[:notes])
	worker.interact_with_parade('C',parade)
  end
  def addphotographer
	worker = Factory.new
	worker.connect_to_db("nitrous","","postgres")
	photographer = Photographer.new
	photographer.set_name(params[:last_name]+", "+params[:first_name])
	photographer.set_email(params[:email])
	photographer.set_phone(params[:phone])
	photographer.set_notes(params[:notes])
	worker.interact_with_photographer('C',photographer)
  end
  def addproject
	worker = Factory.new
	worker.connect_to_db("nitrous","","postgres")
	home = Home.new
	home.set_home_number(params[:home_number])
	home.set_home_name(params[:home_name])
	home.set_home_address(params[:address])
	home.set_city(params[:city])
	home.set_state(params[:state])
	home.set_zipcode(params[:zip])
	home.set_home_notes(params[:notes])
	photographer = Photographer.new
	photographer.set_photographer_id(params[:photographer_id])
	photographer = worker.interact_with_photographer('R',photographer)
	builder = Builder.new
	builder.set_builder_id(params[:builder_id])
	builder = worker.interact_with_builder('R',builder)
	parade = Parade.new
	parade.set_parade_id(params[:event_id])
	parade = worker.interact_with_parade('R',parade)
	home.set_builder(builder)
	home.set_parade(parade)
	@connection = PG::Connection.open(:dbname => "postgres",:user => 'nitrous',:password => "")
	new_home = Home.new
	new_home = worker.interact_with_home('C',home)
	@connection.exec("INSERT INTO order_table (home_id, photographer_id) values($1, $2)",[new_home.get_home_id.to_i, photographer.get_photographer_id.to_i])
  end
	
end
