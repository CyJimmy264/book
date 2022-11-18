class Records::SignatureController < ApplicationController
  before_action :require_login

  def signature_params
    @signature_params ||= params.permit(
      %i[
        id
        date
        sha3
        signature
      ]
    ).to_h
  end

  def time_now
    @time_now ||= Time.now
  end

  def signature
    signature_params['signature'].gsub(/\r\n?/, "\n")
  end

  def signature_hash
    @signature_hash ||= {
      'тип'         => 'подпись',
      'дата'        => time_now.to_s,
      'дата записи' => signature_params['date'],
      'хэш записи'  => "sha3:#{signature_params['sha3']}",
      'подпись'     => signature,
      'отпечаток'   => current_user.fingerprint,
    }
  end

  def signature_valid?
    result = SafeShell.execute(
      'node',
      'js/openpgp.js',
      'verify',
      Record.find_by(id: signature_params['id']).content,
      signature,
      current_user.public_key
    )

    logger.info "OpenPGP.js verify result: #{result}"
    result.include? current_user.fingerprint.last(16)
  end

  def create
    content = signature_hash.to_yaml

    if signature_valid?
      Record.create!(
        {
          content:,
          author_id: current_user.id,
          sha3: SHA3::Digest.hexdigest(:sha256, content),
          created_at: time_now,
          signed_record_id: signature_params['id'],
        }
      )

      redirect_to root_path
    else
      redirect_to root_path, alert: 'Invalid signature'
    end
  end
end
