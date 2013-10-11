class DynamicRecordFactory
  attr_reader :type_converter

  def initialize
    @type_converter = TypeConverter.new
  end

  def create(fields, row)
    record = OpenStruct.new
    
    fields.each do |field_name, field_type|
      record[field_name] = type_converter.convert(row[field_name], field_type)
      
      if field_type == :boolean
        record[(field_name + "?").to_sym] = record[field_name.to_sym]
      end
    end

    record
  end
end
