class Records::SignatureController < ApplicationController
  before_action :require_login

  def signature_params
    @signature_params ||= params.permit(
      %i[
        date
        sha3
        signature
      ]
    ).to_h
  end

  def time_now
    @time_now ||= Time.now
  end

  def signature_hash
    @signature_hash ||= {
      'тип'         => 'подпись',
      'дата'        => time_now.to_s,
      'дата записи' => signature_params['date'],
      'хэш записи'  => "sha3:#{signature_params['sha3']}",
      'подпись'     => signature_params['signature'].gsub(/\r\n?/, "\n"),
      'отпечаток'   => current_user.fingerprint,
    }
  end

  def create
    content = signature_hash.to_yaml

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
