json.array!(@nominates) do |nominate|
  json.extract! nominate, :id, :user_id, :candidate, :reason
  json.url nominate_url(nominate, format: :json)
end
