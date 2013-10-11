require "pg"
require "ostruct"

class StupidData
  def initialize(connection_string)
    @connection_string = connection_string
  end

  def query(q)
    records = []
    conn = PG.connect(@connection_string)
    conn.exec(q) do |results|
      field_types = build_field_types_map(results)

      results.each do |row|
        record = build_record(field_types, row)
        records << record
      end
    end

    records
  end

  private 

  def build_field_types_map(results)
    types = {}

    results.fields.each do |field|
      field_index = results.fnumber(field)
      field_type_id = results.ftype(field_index)

      case field_type_id
        when 16
          field_type = :boolean
        when 20
          field_type = :integer
        when 23
          field_type = :integer
        else
          puts "Unknown type_id: #{type_id} for data: #{data}." unless field_type_id == 1043 # varchar
          field_type = :string
      end

      types[field] = field_type
    end

    types
  end

  def build_record(field_types, row)
    record = OpenStruct.new
    field_types.each do |field_name, field_type|
      record[field_name.to_sym] = convert(row[field_name], field_type)
      if field_type == :boolean
        record[(field_name + "?").to_sym] = record[field_name.to_sym]
      end
    end
    record
  end

  def convert(data, type)
    case type
      when :boolean
        data == "t"
      when :integer
        data.to_i
      else
        data
    end
  end
end
