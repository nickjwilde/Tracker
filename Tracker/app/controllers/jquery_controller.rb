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
    @order_object = worker.interact_with_home('O', home)
  end
	
end
