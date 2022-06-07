class Records::IntroductionController < ApplicationController
  before_action :require_login

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

  def time_now
    @time_now ||= Time.now
  end

  def introduction_hash
    @introduction_hash ||= {
      'тип'           => 'представление',
      'дата'          => time_now.to_s,
      'имя'           => introduction_params['firstname'],
      'отчество'      => introduction_params['patronymic'],
      'фамилия'       => introduction_params['surname'],
      'дата рождения' => introduction_params['birthdate'],
      'адрес'         => introduction_params['address'],
      'открытый ключ' => current_user.public_key,
      'отпечаток'     => current_user.fingerprint,
    }
  end

  def create
    content = introduction_hash.to_yaml

    Record.create!(
      {
        content:,
        author_id: current_user.id,
        sha3: SHA3::Digest.hexdigest(:sha256, content),
        created_at: time_now,
      }
    )

    redirect_to root_path
  end
end
