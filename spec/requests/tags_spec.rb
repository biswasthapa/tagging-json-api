require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe "POST /tag" do
    it "creates an entity with tags" do
      entity_id = Faker::Number.number(10)
      entity_params = {
        "entity_type" => 'Product',
          "entity_id" => entity_id,
               "tags" => ['Large', 'Pink']
      }.to_json

      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }

      post "/tag", entity_params, request_headers

      expect(response.status).to eq 200
      expect(Entity.first.entity_type).to eq 'Product'
      expect(Entity.first.entity_id).to eq entity_id
      expect(Entity.first.tags).to eq ['Large', 'Pink']
    end
  end

  describe "GET /tags/:entity_type/:entity_id" do
    it "returns an entity with matching entity_type and entity_id" do
      tag = FactoryGirl.create :entity, entity_type: 'Product', entity_id: Faker::Number.number(10), tags: ['Large', 'Pink']

      get "/tags/#{tag.entity_type}/#{tag.entity_id}", {}, { "Accept" => "application/json" }

      expect(response.status).to eq 200

      body = JSON.parse(response.body)

      expect(body['entity']['entity_type']).to eq tag.entity_type
      expect(body['entity']['entity_id']).to eq tag.entity_id
      expect(body['entity']['tags']).to eq tag.tags
    end
  end

  describe "DELETE /tags/:entity_type/:entity_id" do
    it "deletes an entity with matching entity_type and entity_id" do
      tag = FactoryGirl.create :entity, entity_type: 'Product', entity_id: '1234', tags: ['Large', 'Pink']


      expect {
        delete "/tags/#{tag.entity_type}/#{tag.entity_id}", {}, { "Accept" => "application/json" }
      }.to change(Entity, :count).by(-1)
    end
  end

end
