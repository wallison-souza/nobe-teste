module FullErrorMessage
  extend ActiveSupport::Concern


  def self.error_message(obj)
    q_erros = obj.errors.count.to_s
    p_erros = "erro".pluralize(obj.errors.count)
    all_erros = ''
    obj.errors.full_messages.each do |message|
      all_erros += "<li>" + message + "</li>"
    end
    return mensagem =
        "<div class='row'>" +
            "<div class='col-sm-12 col-md-12'>" +
            "<div class='panel panel-danger fade in collapse show' id='alerta'>" +
            "<div class='panel-heading panel-heading-message'>" +
            "<a data-toggle='collapse'   href='#alerta'  class='close'> &times;</a>"+
            "<h3>" + q_erros +' '+ p_erros + " em " + obj.class.model_name.human + "</h3>" +
            "<div class='panel-body panel-body-message'>" +
            "<ul class='ul-message'>" + all_erros + "</ul>" +
            "</div></div></div></div></div>"
  end
end
