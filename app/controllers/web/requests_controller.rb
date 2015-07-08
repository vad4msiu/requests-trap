class Web::RequestsController < Web::BaseController
  before_action :load_trap, only: [:index, :show]

  def index
    @requests = @trap.requests.order(created_at: 'desc').page(params[:page])
  end

  def show
    @request = @trap.requests.find(params[:id])
  end

  private

  def load_trap
    @trap = Trap.find(params[:trap_id])
  end
end