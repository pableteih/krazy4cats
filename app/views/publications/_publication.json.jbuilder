json.extract! publication, :id, :tittle, :image, :content, :user_id, :created_at, :updated_at
json.url publication_url(publication, format: :json)
