class String
  def convert_to_decimal
    (self.sub! ',', '.').to_f
  end
end