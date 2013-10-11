class TypeConverter
  def convert(data, type)
    case type
      when :boolean
        data == "t"
      when :integer
        data.to_i
      when :decimal
        BigDecimal.new(data)
      when :date
        Date.parse(data)
      when :datetime
        DateTime.parse(data)
      else
        data
    end
  end
end
