::ActionMailer::Base.class_eval do

  def render_message(method_name, assigns)
    template     = MailTemplate.find_by_name(method_name)
    Rails.logger.debug "Loading mail template #{method_name} from MailTemplate"
    return super(method_name, assigns) unless template
    content_type 'text/html'
    subject      "=?UTF-8?B?" +  Base64.encode64(render_string_template(template.subject, assigns)) + "?="
    text =       render_string_template(template.body, assigns)

    unless content_type =~ /multipart/
      @headers["Content-Transfer-Encoding"] = "base64"
      text = Base64.encode64(text)
    end
    text
  end

  def render_string_template(inline_template, assigns)
    template = initialize_template_class(assigns)
    template.render(:inline => inline_template)
  end

end