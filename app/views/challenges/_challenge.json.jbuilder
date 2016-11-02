json.extract! challenge, :id, :description, :amount, :status, :created_at, :updated_at
json.url challenge_url(challenge, format: :json)