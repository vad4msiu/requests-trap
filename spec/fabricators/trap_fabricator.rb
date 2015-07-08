Fabricator(:trap) do
  id { sequence(:id) { |i| "trap_id_#{i}" }}
end
