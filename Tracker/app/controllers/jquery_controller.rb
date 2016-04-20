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
	order = worker.interact_with_order('R',order)
	order.set_raw_photos(params[:raw_photos].to_i)
	order.set_estimated_photos(params[:est_photos].to_i)
	order.set_final_photos_number(params[:final_photos].to_i)
	if(params[:swag] == 'true')
		photographer.set_swag('Y')
	else
		photographer.set_swag('N')
	end
	if(params[:photos_approved] == 'true')
		if (order.get_photos_approved_date.nil? or order.get_photos_approved == 'N')
			order.set_photos_approved_date(Time.now)
		end
		order.set_photos_approved('Y')
	else
		order.set_photos_approved('N')
	end
	if(params[:photographer_paid] == 'true')
		if (order.get_photographer_paid_date.nil? or order.get_photographer_paid == 'N')
		order.set_photographer_paid_date(Time.now)
		end
		order.set_photographer_paid('Y')
	else
		order.set_photographer_paid('N')
	end
	if(params[:quick_edit_upload] == 'true')
		if (order.get_quick_edit_upload.nil? or order.get_quick_edit_upload == 'N')
		order.set_quick_edit_upload_date(Time.now)
		end
		order.set_quick_edit_upload('Y')
	else
		order.set_quick_edit_upload('N')
	end
	if(params[:assigned_to_editor] == 'true')
		if (order.get_assigned_to_editor_date.nil? or order.get_assigned_to_editor == 'N')
		order.set_assigned_to_editor_date(Time.now)
		end
		order.set_assigned_to_editor('Y')
	else
		order.set_assigned_to_editor('N')
	end
	if(params[:final_edits_approve] == 'true')
		if (order.get_final_edits_approve.nil? or order.get_final_edits_approve == 'N')
		order.set_final_edits_approve_date(Time.now)
		end
		order.set_final_edits_approve('Y')
	else
		order.set_final_edits_approve('N')
	end
	if(params[:final_crops] == 'true')
		if (order.get_cropping_date.nil? or order.get_cropping == 'N')
			order.set_cropping_date(Time.now)
		end
		order.set_cropping('Y')
	else
		order.set_cropping('N')
	end
	if(params[:final_edit_upload] == 'true')
		if (order.get_final_edit_upload_date.nil? or order.get_photographer_paid == 'N')
		order.set_final_edit_upload_date(Time.now)
		end
		order.set_final_edit_upload('Y')
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
		parade.set_end_date(nil)
	else
		parade.set_end_date(params[:end_date])
	end
	parade.set_notes(params[:notes])
	worker.interact_with_parade('C',parade)
  @eventlist = worker.interact_with_parade('L')
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
  @photographerlist = worker.interact_with_photographer('L')
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
	@connection.exec("INSERT INTO order_table (home_id, photographer_id, photos_approved, photographer_paid, quick_edit_upload, assigned_to_editor, final_edits_approve, final_cropping, final_edit_upload) values($1, $2,'N','N','N','N','N','N','N')",[new_home.get_home_id.to_i, photographer.get_photographer_id.to_i])
  end

  def editparade
	worker = Factory.new
	worker.connect_to_db("nitrous","","postgres")
	@parade = Parade.new
	@parade.set_parade_id(params[:parade_id])
	@parade = worker.interact_with_parade('R',@parade)
  end

  def updateparade
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    @parade = Parade.new
    @parade.set_parade_id(params[:parade_id])
    @parade.set_parade_name(params[:name])
    @parade.set_city(params[:city])
    @parade.set_state(params[:state])
    @parade.set_start_date(params[:start_date])
    @parade.set_end_date(params[:end_date])
    @parade.set_notes(params[:notes])
    worker.interact_with_parade('U', @parade)
  end

   def edithome
	worker = Factory.new
	worker.connect_to_db("nitrous","","postgres")
  @builderlist = worker.interact_with_builder('L')
	@home = Home.new
	@home.set_home_id(params[:home_id])
	@home = worker.interact_with_home('R',@home)
  end

   def updatehome
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    builder = Builder.new
    builder.set_builder_id(params[:builder_id])
    builder = worker.interact_with_builder('R', builder)
    @home = Home.new
    @home.set_home_id(params[:home_id])
    @home = worker.interact_with_home('R', @home)
    @home.set_home_name(params[:name])
    @home.set_home_number(params[:home_number])
    @home.set_home_address(params[:address])
    @home.set_city(params[:city])
    @home.set_state(params[:state])
    @home.set_home_zipcode(params[:zipcode])
    @home.set_notes(params[:notes])
    @home.set_builder(builder)
    worker.interact_with_home('U', @home)
  end

  def eventfilters
    @filtered = Array.new
    parade = Parade.new
    #not good practice to put logic here, but time constraints call for exceptions
    @connection = PG::Connection.open(:dbname => "postgres",:user => 'nitrous',:password => "")
    if !params[:state].empty? and !params[:year].empty?
        results = @connection.exec("SELECT * FROM parade where state_of_parade = $1 AND date_part('year',start_date_of_parade) = $2",[params[:state], params[:year]])
        results.each do | row |
          parade = Parade.new(row['parade_id'],row['name_of_parade'],row['city_of_parade'],row['state_of_parade'],row['start_date_of_parade'],row['end_date_of_parade'])
          @filtered << parade
        end
    elsif !params[:state].empty?
            results = @connection.exec("SELECT * FROM parade where state_of_parade = $1",[params[:state]])
        results.each do | row |
          parade = Parade.new(row['parade_id'],row['name_of_parade'],row['city_of_parade'],row['state_of_parade'],row['start_date_of_parade'],row['end_date_of_parade'])
          @filtered << parade
        end
    elsif !params[:year].empty?
            results = @connection.exec("SELECT * FROM parade where date_part('year',start_date_of_parade) = $1",[params[:year]])
        results.each do | row |
          parade = Parade.new(row['parade_id'],row['name_of_parade'],row['city_of_parade'],row['state_of_parade'],row['start_date_of_parade'],row['end_date_of_parade'])
          @filtered << parade
        end
    else
        worker = Factory.new
        worker.connect_to_db("nitrous","","postgres")
        @filtered = worker.interact_with_parade('L')
    end
  end

  def filterforms
    #do nothing cause we just want the home filter form
  end

  def resetfilterform
    #do nothing here as well cause we're just reloading event filters
  end

  def homefilters
   @filtered = Array.new
    home = Home.new
    @parade_id = params[:parade_id]
    #not good practice to put logic here, but time constraints call for exceptions
    @connection = PG::Connection.open(:dbname => "postgres",:user => 'nitrous',:password => "")
    if !params[:builder].empty? and !params[:photographer].empty?
       @connection.exec("SELECT  h.*, b.name_of_builder, p.name_of_parade
                    FROM Home h
                        LEFT JOIN builder b
                        ON h.builder_id = b.builder_id
                        LEFT JOIN Parade p
                        ON h.parade_id = p.parade_id
                        LEFT JOIN order_table ot
                        ON ot.home_id = h.home_id
                        LEFT JOIN photographer ph
                        ON ph.photographer_id = ot.photographer_id
         WHERE b.name_of_builder Ilike $1 AND ph.name_of_photographer ilike $2 ORDER BY h.home_number",['%' + params[:builder] + '%','%' + params[:photographer]+ '%']) do  |results|
          results.each do |row|
            home = Home.new(row['home_id'],row['home_name'],row['home_number'],row['home_address'],row['city'],row['state'],row['zip'],row['notes'])

            builder = Builder.new
            builder.set_builder_id(row['builder_id'])
            builder.set_name_of_builder(row['name_of_builder'])

            parade = Parade.new
            parade.set_parade_id(row['parade_id'])
            parade.set_parade_name(row['name_of_parade'])

            home.set_parade(parade)
            home.set_builder(builder)
            @filtered << home
          end
      end
    elsif !params[:builder].empty?
 @connection.exec("SELECT  h.*, b.name_of_builder, p.name_of_parade
                    FROM Home h
                        LEFT JOIN builder b
                        ON h.builder_id = b.builder_id
                        LEFT JOIN Parade p
                        ON h.parade_id = p.parade_id
			WHERE b.name_of_builder ILIKE $1 ORDER BY h.home_number",['%'+ params[:builder] + '%'] ) do |results|
          results.each do |row|
            home = Home.new(row['home_id'],row['home_name'],row['home_number'],row['home_address'],row['city'],row['state'],row['zip'],row['notes'])

            builder = Builder.new
            builder.set_builder_id(row['builder_id'])
            builder.set_name_of_builder(row['name_of_builder'])

            parade = Parade.new
            parade.set_parade_id(row['parade_id'])
            parade.set_parade_name(row['name_of_parade'])

            home.set_parade(parade)
            home.set_builder(builder)
            @filtered << home
                    end
      end
    elsif !params[:photographer].empty?
 @connection.exec("SELECT  h.*, b.name_of_builder, p.name_of_parade
                    FROM Home h
                        LEFT JOIN builder b
                        ON h.builder_id = b.builder_id
                        LEFT JOIN Parade p
                        ON h.parade_id = p.parade_id
                        LEFT JOIN order_table ot
                        ON ot.home_id = h.home_id
                        LEFT JOIN photographer ph
                        ON ph.photographer_id = ot.photographer_id
			 WHERE ph.name_of_photographer ILIKE $1 ORDER BY h.home_number",['%' + params[:photographer] + '%'] ) do |results|
          results.each do |row|
            home = Home.new(row['home_id'],row['home_name'],row['home_number'],row['home_address'],row['city'],row['state'],row['zip'],row['notes'])

            builder = Builder.new
            builder.set_builder_id(row['builder_id'])
            builder.set_name_of_builder(row['name_of_builder'])

            parade = Parade.new
            parade.set_parade_id(row['parade_id'])
            parade.set_parade_name(row['name_of_parade'])

            home.set_parade(parade)
            home.set_builder(builder)
            @filtered << home
                    end
      end
    else
        worker = Factory.new
        worker.connect_to_db("nitrous","","postgres")
        @filtered = worker.interact_with_home('L')
    end
  end

  def addbuilder
      builder = Builder.new
      worker = Factory.new
      worker.connect_to_db("nitrous","","postgres")
      builder.set_name_of_builder(params[:builder_name])
      worker.interact_with_builder('C', builder)
      @builderlist = worker.interact_with_builder('L')
  end

  def editphotographer
      @photographer = Photographer.new
      worker = Factory.new
      worker.connect_to_db("nitrous","","postgres")
      @photographer.set_photographer_id(params[:photographer_id])
      @photographer = worker.interact_with_photographer('R', @photographer)
  end

  def updatephotographer
    @photographer = Photographer.new
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    @photographer.set_photographer_id(params[:photographer_id])
    @photographer = worker.interact_with_photographer('R', @photographer)
    @photographer.set_name(params[:lastname] + ", " + params[:firstname])
    @photographer.set_email(params[:email])
    @photographer.set_phone(params[:phone])
    @photographer.set_notes(params[:notes])
    worker.interact_with_photographer('U', @photographer)    
    @photographer_list = worker.interact_with_photographer('L')
  end

  def updatephotographerinfo
    @photographer = Photographer.new
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    @photographer.set_photographer_id(params[:photographer_id])
    @photographer = worker.interact_with_photographer('R', @photographer)
     if @photographer.try(:get_swag).try(:upcase) == 'Y'
    	@photographer.try(:set_swag,true)
    else
    	@photographer.try(:set_swag,false)
    end
    @photographer_list = worker.interact_with_photographer('L')
  end
end
