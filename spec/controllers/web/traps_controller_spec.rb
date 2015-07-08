require 'rails_helper'

describe Web::TrapsController do
  render_views

  describe "GET /:trap_id" do
    context "with new trap_id" do
      let!(:trap_attributes) { Fabricate.attributes_for :trap}
      let!(:trap_id) { trap_attributes[:id] }

      subject { get :capture, trap_id: trap_attributes[:id] }

      it "return successful response" do
        expect(subject).to be_success
      end

      it "create new trap" do
        expect { subject }.to change { Trap.count }.by(1)
      end

      it "create new trap with id" do
        subject

        trap = Trap.find_by(id: trap_id)
        expect(trap).to be_present
      end

      it "create new request with filled attributes" do
        subject

        trap = Trap.find(trap_id)
        request = trap.requests.first

        expect(request.remote_ip).to_not be_nil
        expect(request.request_method).to_not be_nil
        expect(request.scheme).to_not be_nil
        expect(request.query_string).to_not be_nil
        expect(request.query_params).to_not be_nil
        expect(request.cookies).to_not be_nil
        expect(request.headers).to_not be_nil
        expect(request.raw).to_not be_nil
      end

      it "create new request for trap" do
        subject

        trap = Trap.find(trap_id)

        expect(trap.requests.count).to eq(1)
      end

      context "with params" do
        subject { get :capture, trap_id: trap_attributes[:id], 'test' => 'test' }

        it "return successful response" do
          expect(subject).to be_success
        end

        it "save params to request" do
          subject

          trap = Trap.find(trap_id)
          request = trap.requests.first

          expect(request.query_params['test']).to eq('test')
        end
      end
    end

    context "with existing trap_id" do
      let!(:trap) { Fabricate :trap}

      subject { get :capture, trap_id: trap.id }

      it "return successful response" do
        expect(subject).to be_success
      end

      it "does not create new trap" do
        expect { subject }.to change { Trap.count }.by(0)
      end

      it "create new request for trap" do
        expect {
          subject
          trap.reload
        }.to change { trap.requests.count }.by(1)
      end
    end
  end

  describe "POST /:trap_id" do
    let!(:trap_attributes) { Fabricate.attributes_for :trap}
    let!(:trap_id) { trap_attributes[:id] }

    it "return successful response" do
      expect(
        post :capture, trap_id: trap_attributes[:id]
      ).to be_success
    end
  end

  describe "DELETE /:trap_id" do
    let!(:trap_attributes) { Fabricate.attributes_for :trap}
    let!(:trap_id) { trap_attributes[:id] }

    it "return successful response" do
      expect(
        delete :capture, trap_id: trap_attributes[:id]
      ).to be_success
    end
  end

  describe "PUT /:trap_id" do
    let!(:trap_attributes) { Fabricate.attributes_for :trap}
    let!(:trap_id) { trap_attributes[:id] }

    it "return successful response" do
      expect(
        put :capture, trap_id: trap_attributes[:id]
      ).to be_success
    end
  end
end