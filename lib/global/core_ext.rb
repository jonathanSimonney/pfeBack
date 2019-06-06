# frozen_string_literal: true

class String
  def convert_to_decimal
    (sub! ',', '.').to_f
  end
end
