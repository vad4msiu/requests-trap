require 'rails_helper'

describe Web::TrapsController do
  context "with new trap_id" do
    describe "GET /:trap_id" do
      let!(:trap_attributes) { Fabricate.attributes_for :trap}
      let!(:trap_id) { trap_attributes[:id] }

      it "return successful response" do
        expect(
          get :capture, trap_id: trap_attributes[:id]
        ).to be_success
      end

      it "create new trap" do
        expect {
          get :capture, trap_id: trap_attributes[:id]
        }.to change { Trap.count }.by(1)
      end

      it "create new trap with name" do
        get :capture, trap_id: trap_attributes[:id]

        expect(
          Trap.find_by(name: trap_id)
        ).to be_present
      end

      it "create new request for trap" do
        get :capture, trap_id: trap_attributes[:id]
        trap = Trap.find_by(name: trap_id)

        expect(
          trap.requests.count
        ).to eq(1)
      end
    end
  end

  context "with existing trap_id" do
    describe "GET /:trap_id" do
      let!(:trap) { Fabricate :trap}

      it "return successful response" do
        expect(
          get :capture, trap_id: trap.id
        ).to be_success
      end

      it "does not create new trap" do
        expect {
          get :capture, trap_id: trap.id
        }.to change { Trap.count }.by(0)
      end

      it "create new request for trap" do
        expect {
          get :capture, trap_id: trap.id
          trap.reload
        }.to change { trap.requests.count }.by(1)
      end
    end
  end
end