class AdminController < ApplicationController
  #Home page to display events
  def events
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    @results = worker.interact_with_parade('L')
  end

  #add new page to add event, photographer, and project
  def addnew
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    @builderlist = worker.interact_with_builder('L')
    @photographerlist = worker.interact_with_photographer('L')
    @eventlist = worker.interact_with_parade('L')
  end

  #admin page to view users
  def admin
    worker = Factory.new
    worker.connect_to_db("nitrous","","postgres")
    @userlist = worker.interact_with_user('L')
  end
end
