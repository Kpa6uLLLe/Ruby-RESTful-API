module Api
  class RecommendationsController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? }
    def consultation_requests
      patient = Patient.find_by email: patient_params[:email]
      if patient == nil
        patient = Patient.new(patient_params)
      end
      request = Request.new({
        patient: patient,
        requestBody: request_params[:requestBody],
        creationDate: request_params[:creationDate]
      })
      if(patient.save && request.save)
        render json: {status:"SUCCESS", message:"Created request", data: request},status: :ok
      else
        render json: {status:"ERROR", message:"Couldn't save request"}, status: :unprocessable_entity
      end
    end


    private
    def request_params
      params.permit(:initials, :birthdate, :phone, :email, :requestBody, :creationDate, nil)
    end
    def patient_params
      params.permit(:initials, :birthdate, :phone, :email)
    end
  end
end
