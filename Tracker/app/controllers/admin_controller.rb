class AdminController < ApplicationController
  def events
    worker = Factory.new
    worker.connect_to_db("nick","Ln53gi8N","postgres")
    @results = worker.interact_with_parade('L')
  end

  def addnew
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    @builderlist = worker.interact_with_builder('L')
    @photographerlist = worker.interact_with_photographer('L')
    @eventlist = worker.interact_with_parade('L')
  end
end
