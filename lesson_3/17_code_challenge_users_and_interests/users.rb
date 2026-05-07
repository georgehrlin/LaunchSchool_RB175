require 'tilt/erubi'
require 'sinatra'
require 'sinatra/reloader'
require 'yaml'

def total_number_of_all_users
  @all_users_information.size
end

# Originally created for requirement #5. Keeping original name instead of count_interests
def total_number_of_all_interests
  @all_users_information.map do |_, user_information|
    user_information[:interests]
  end.flatten.size
end

before do
  @all_users_information = YAML.load_file('data/users.yaml')
end

helpers do
  def generate_user_hyperlinks_as_list_items
    all_user_names = @all_users_information.keys
    all_user_names.map do |remaining_user_name|
      if remaining_user_name != @user_name.to_sym
        %(<li><a href="/#{remaining_user_name}">#{remaining_user_name.to_s.capitalize}</a></li>)
      end
    end.join
  end

  def generate_total_all_users_n_intersts_message
    %(<p>There are #{total_number_of_all_users} users with a total of #{total_number_of_all_interests} interests.</p>)
  end
end

get '/' do
  erb :home
end

get '/:user_name' do
  @user_name = params[:user_name]
  @user_specific_information = @all_users_information[@user_name.to_sym]
  @email = @user_specific_information[:email]
  @interests = @user_specific_information[:interests].join(', ')

  erb :user
end
