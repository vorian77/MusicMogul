class SliderInput < SimpleForm::Inputs::Base
  def input
    "<span class='slider-value'></span><div class='slider-input'></div>#{@builder.hidden_field(attribute_name, input_html_options)}".html_safe
  end
end