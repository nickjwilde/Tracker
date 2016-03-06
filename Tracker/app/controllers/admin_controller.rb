class AdminController < ApplicationController
  def home
    worker = Factory.new
    worker.connect_to_db("")
    @results = worker.interact_with_parade('L')
  end
end
