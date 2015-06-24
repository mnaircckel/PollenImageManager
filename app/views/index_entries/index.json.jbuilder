json.array!(@index_entries) do |index_entry|
  json.extract! index_entry, :id, :latin_name, :family, :common_name
  json.url index_entry_url(index_entry, format: :json)
end
