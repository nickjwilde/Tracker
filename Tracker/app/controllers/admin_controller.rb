class AdminController < ApplicationController
  def events
    worker = Factory.new
    worker.connect_to_db("nick","Ln53gi8N","postgres")
    @results = worker.interact_with_parade('L')
  end
end
