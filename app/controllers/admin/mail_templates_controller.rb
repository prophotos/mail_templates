class Admin::MailTemplatesController < ApplicationController
  layout "admin"
  require_admin
  preload :mail_template!, :field => :name, :only => [:test, :update, :destroy, :show]

  def test
    Notifier.send("test_#{@mail_template.name}", current_user)
    redirect_to [:admin, @mail_template]
  end

  def index
    @mail_templates = MailTemplate.find(:all, :order => 'display_name')
  end

  def update
    if @mail_template.update_attributes(params[:mail_template])
      redirect_to [:admin, @mail_template]
    else
      render :action => :show
    end
  end

  def new
    @mail_template = MailTemplate.new
  end

  def create
    @mail_template = MailTemplate.new(params[:mail_template])
    if @mail_template.save
      redirect_to [:admin, @mail_template]
    else
      render :action => new
    end
  end

  def destroy
    @mail_template.destroy
    redirect_to(admin_mail_templates_url)
  end
end
