
#
# CBRAIN Project
#
# Controller for the user feedback resource.
#
# Original author: Tarek Sherif
#
# $Id$
#

#RESTful controller for the Feedback resource.
class FeedbacksController < ApplicationController
  before_filter :login_required
  
  Revision_info="$Id$"
  
  # GET /feedbacks
  # GET /feedbacks.xml
  def index #:nodoc:
    @feedbacks = Feedback.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feedbacks }
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.xml
  def show #:nodoc:
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feedback }
    end
  end

  # GET /feedbacks/new
  # GET /feedbacks/new.xml
  def new #:nodoc:
    @feedback = Feedback.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feedback }
    end
  end

  # GET /feedbacks/1/edit
  def edit #:nodoc:
    @feedback = Feedback.find(params[:id])
  end

  # POST /feedbacks
  # POST /feedbacks.xml
  def create #:nodoc:
    @feedback = Feedback.new(params[:feedback])
    @feedback.user_id = current_user.id

    respond_to do |format|
      if @feedback.save
        flash[:notice] = 'Feedback was successfully created.'
        format.js
        format.xml  { render :xml => @feedback, :status => :created, :location => @feedback }
      else
        format.js
        format.xml  { render :xml => @feedback.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feedbacks/1
  # PUT /feedbacks/1.xml
  def update #:nodoc:
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      if @feedback.update_attributes(params[:feedback])
        flash[:notice] = 'Feedback was successfully updated.'
        format.html { redirect_to(@feedback) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feedback.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.xml
  def destroy #:nodoc:
    @feedback = Feedback.find(params[:id])
    @destroyed = @feedback.destroy

    respond_to do |format|
      format.html { redirect_to(feedbacks_url) }
      format.js
      format.xml  { head :ok }
    end
  end
end
