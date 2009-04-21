# это методы, которые надо переопределить в наследнике ActionMailer, чтобы он использовал темплейты из базы

def render_message(method_name, assigns)
  template = MailTemplate.find_by_name(method_name)
  from         'noreply@photoawards.ru'
  content_type 'text/html'
  subject      render_string_template(template.subject, assigns)
  text =       render_string_template(template.body, assigns)

  unless content_type =~ /multipart/
    @headers["Content-Transfer-Encoding"] = "base64"
    @subject = "=?UTF-8?B?" +  Base64.encode64(@subject) + "?="
    text = Base64.encode64(text)
  end
  text
end

def render_string_template(inline_template, assigns)
  template = initialize_template_class(assigns)
  template.render(:inline => inline_template)
end

def initialize_template_class(assigns)
  template = ActionView::Base.new([template_root], assigns, self)

  # эта строка используется если мы хотим дать доступ к специфичным хелперам из шаблона
  # template = template.extend NotifierHelper

  template
end