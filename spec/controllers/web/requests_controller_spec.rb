require 'rails_helper'

describe Web::RequestsController do
  render_views

  describe "GET /:trap_id/requests" do
    context "with wrong trap_id" do
      let!(:trap_attributes) { Fabricate.attributes_for :trap }
      let!(:trap_id) { trap_attributes[:id] }

      it "return failure response" do
        expect(
          get :index, trap_id: trap_attributes[:id]
        ).to_not be_success
      end
    end

    context "with existing trap_id" do
      let!(:trap) { Fabricate :trap }

      before { Fabricate.times(3, :request, trap: trap )}

      it "return successful response" do
        expect(
          get :index, trap_id: trap.id
        ).to be_success
      end
    end
  end

  describe "GET /:trap_id/requests/:id" do
    let!(:request) { Fabricate :request }
    let!(:trap) { request.trap }

    it "return successful response" do
      expect(
        get :index, trap_id: trap.id, id: request.id
      ).to be_success
    end
  end
end