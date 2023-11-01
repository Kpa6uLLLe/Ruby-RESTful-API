Rails.application.routes.draw do
  namespace 'api' do
    post 'consultation_requests' => "recommendations#consultation_requests"
    post 'consultation_requests/:request_id/recommendations' => "recommendations#consultation_recommendations"
    get '/patients/:patient_id/recommendations' => "recommendations#patient_recommendations"
  end
end
