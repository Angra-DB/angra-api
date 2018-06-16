class AngraServicesController < ApplicationController
  before_action :connect_to_angra
  before_action :connect_to_db, only: %i[save update lookup delete]

  def create_db
    response = @cursor.create_db(params[:db_name])
    render json: {db_message: response}, status: :ok
  end

  def save
    begin
      response = @cursor.save document_param['document']
      render json: {db_message: response}, status: :ok
    rescue RuntimeError => e
      render json: {error: e}, status: :error
    end
  end

  private

  def connect_to_angra
    connection_data_param = params.require(:conection_data).permit(:ip, :port)
    @cursor = Angradb::Driver.new(connection_data_param['ip'],
                                  connection_data_param['port'])
  end

  def connect_to_db
    db_data_param = params.require(:db_data).permit(:db_name)
    @cursor.connect(db_data_param[:db_name])
  end

  def document_param
    params.require(:document_param).permit(:document)
  end
end
