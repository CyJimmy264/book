class Records::IntroductionController < ApplicationController
  def new; end

  def introduction_params
    @introduction_params ||= params.permit(
      %i[
        firstname
        patronymic
        surname
        birthdate
        address
      ]
    ).to_h
  end

  def introduction_hash
    @introduction_hash ||= {
      'тип'           => 'представление',
      'имя'           => introduction_params['firstname'],
      'отчество'      => introduction_params['patronymic'],
      'фамилия'       => introduction_params['surname'],
      'дата рождения' => introduction_params['birthdate'],
      'адрес'         => introduction_params['address'],
    }
  end

  def create
    Record.create!(
      {
        content: introduction_hash.to_yaml,
        author_id: current_user.id,
      }
    )

    redirect_to root_path
  end
end
