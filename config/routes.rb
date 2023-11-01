Rails.application.routes.draw do
  namespace 'api' do
    post 'consultation_requests' => "recommendations#consultation_requests"
  end
end
