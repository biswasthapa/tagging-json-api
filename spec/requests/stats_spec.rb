require 'rails_helper'

RSpec.describe "Stats", type: :request do
  describe "GET /stats" do
    it "gets stats of all tags" do
      tag1 = FactoryGirl.create :entity, entity_type: 'Product', entity_id: Faker::Number.number(10), tags: ['Large', 'Pink']
      tag2 = FactoryGirl.create :entity, entity_type: 'Product', entity_id: Faker::Number.number(10), tags: ['Large', 'Red']
      tag3 = FactoryGirl.create :entity, entity_type: 'Product', entity_id: Faker::Number.number(10), tags: ['Small', 'Pink']

      get "/stats", {}, { "Accept" => "application/json" }
      expect(response.status).to eq 200
      body = JSON.parse(response.body, :symbolize_names => true)

      expect(body[:tag_stats]).to include({tag: "Large", count: 2})
      expect(body[:tag_stats]).to include({tag: "Small", count: 1})
      expect(body[:tag_stats]).to include({tag: "Pink", count: 2})
    end
  end

  describe "GET stats/:entity_type/:entity_id" do
    it "gets stat of an entity with matching entity_type and entity_id" do
      tag = FactoryGirl.create :entity, entity_type: 'Product', entity_id: Faker::Number.number(10), tags: ['Large', 'Pink']
      get "/stats/#{tag.entity_type}/#{tag.entity_id}", {}, { "Accept" => "application/json" }

      expect(response.status).to eq 200

      body = JSON.parse(response.body, :symbolize_names => true)

      expect(body[:entity_stat]).to include({tag: "Large", count: 1})
      expect(body[:entity_stat]).to include({tag: "Pink", count: 1})
    end

  end
end