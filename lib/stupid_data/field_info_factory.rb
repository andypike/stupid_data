class FieldInfoFactory
  def create(results)
    types = {}

    results.fields.each do |field|
      field_index = results.fnumber(field)
      field_type_id = results.ftype(field_index)

      types[field] = type_lookup.fetch(field_type_id, :string)
    end

    types
  end

  private

  def type_lookup
    { 
      16 => :boolean, 
      20 => :integer,
      23 => :integer,
      1082 => :date,
      1114 => :datetime,
      1700 => :decimal
    }
  end
end