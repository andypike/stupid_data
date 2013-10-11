class TypedRecordFactory
  attr_reader :klass, :type_converter

  def initialize(klass)
    @klass = klass
    @type_converter = TypeConverter.new
  end

  def create(fields, row)
    record = klass.new

    fields.each do |field_name, field_type|
      attribute_writer = "#{field_name}="

      if record.respond_to? attribute_writer
        record.send(attribute_writer, type_converter.convert(row[field_name], field_type))
      end
    end

    record
  end
end
