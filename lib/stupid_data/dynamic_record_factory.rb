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
        record["#{field_name}?"] = record[field_name]
      end
    end

    record
  end
end
