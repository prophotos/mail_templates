class MailTemplatesController < ApplicationController
  before_filter :require_admin

  def test
    @mail_template = MailTemplate.find_by_name(params[:id])
    Notifier.send("test_#{@mail_template.name}", @logged_user)
    redirect_to :action => :edit, :id => @mail_template
  end

  def index
    @mail_templates = MailTemplate.find(:all, :order => 'display_name')
  end

  def edit
    @mail_template = MailTemplate.find_by_name(params[:id])
  end

  def update
    @mail_template = MailTemplate.find_by_name(params[:id])
    if @mail_template.update_attributes(params[:mail_template])
      redirect_to :action => :edit, :id => @mail_template
    else
      render :action => :edit
    end
  end

  def new
    @mail_template = MailTemplate.new
  end

  def create
    @mail_template = MailTemplate.new(params[:mail_template])
    if @mail_template.save
      redirect_to :action => edit, :id => @mail_template
    else
      render :action => new
    end
  end

  def destroy
    @mail_template = MailTemplate.find_by_name(params[:id])
    @mail_template.destroy
    redirect_to(mail_templates_url)
  end
end
