class Company < ApplicationRecord
  has_rich_text :description
  
  validates :email,
            format: { with: /\b[A-Z0-9._%a-z\-]+@getmainstreet\.com\z/, message: 'Allowed Domain is getmainstreet.com.' },
            allow_blank: true
  
  before_save :get_city_state, if: Proc.new { |company| company.zip_code_changed? }
  
  def get_city_state
    zip_code = ZipCodes.identify(self.zip_code.to_s)
    if zip_code
      self.city = zip_code[:city]
      self.state = zip_code[:state_code]
    end
  end

end
