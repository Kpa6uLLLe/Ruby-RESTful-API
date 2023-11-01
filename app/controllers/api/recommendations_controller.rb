module Api
  require 'net/http'
  require 'json'
  class RecommendationsController < ApplicationController
    protect_from_forgery unless: -> { request.format.json? }
    def consultation_requests
      patient = Patient.find_by email: patient_params[:email]
      isAutoresponseOn = request_params[:autoresponse] == nil ? false : request_params[:autoresponse]
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
      response = get_medican_info(request.id)
      if isAutoresponseOn
        str_rec = ""
        response.each do |drug|
          if drug != response[0]
            str_rec += ", "
          end
          str_rec += drug["generic_name"]
        end
        recommendation = Recommendation.new({
          request: request,
          responseBody: str_rec
        })
        recommendation.save
      end
    end
    def consultation_recommendations
      recommendation = Recommendation.find_by request_id: recommendation_params[:request_id]
      if recommendation != nil
        render json: {status:"ERROR", message:"Recommendation already exists"}, status: :not_acceptable
        return
      end
      request = Request.find(recommendation_params[:request_id])
      recommendation = Recommendation.new({
        request: request,
        responseBody: recommendation_params[:responseBody]
      })
      if(recommendation.save)
        render json: {status:"SUCCESS", message:"Created recommendation", data: recommendation},status: :ok
      else
        render json: {status:"ERROR", message:"Couldn't save recommendation"}, status: :unprocessable_entity
      end
    end

    def patient_recommendations
      patient = Patient.find(patientid_params[:patient_id])
      if patient == nil
        render json: {status:"ERROR", message:"Patient doesn't exist"}, status: :not_acceptable
        return
      end
      requests = Request.where(patient_id: patientid_params[:patient_id])
      recommendations_arr = []
      requests.each do |request|
        recommendations = Recommendation.where(request_id: request.id)
        recommendations.each do |recommendation|
          recommendations_arr << recommendation
        end
      end
      data = recommendations_arr.to_json
      render json: data, status: :ok
    end
    private
    def recommendation_params
      params.permit(:request_id, :responseBody)
    end
    def request_params
      params.permit(:initials, :birthdate, :phone, :email, :requestBody, :creationDate, :autoresponse, nil)
    end
    def patient_params
      params.permit(:initials, :birthdate, :phone, :email)
    end
    def patientid_params
      params.permit(:patient_id)
    end
    def request_api(url)
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri)
      response = http.request(request)
      body = JSON.parse(response.body)
      return body["results"]
    end
    def get_medican_info(drugCount)
      request_api(
      "https://api.fda.gov/drug/ndc.json?search=finished:true&limit=#{3+(drugCount%7)}"
    )
    end
  end
end
